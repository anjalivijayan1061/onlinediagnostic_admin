import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  String lastStatus = 'pending';
  OrdersBloc() : super(OrdersInitialState()) {
    on<OrdersEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder testBookings =
            supabaseClient.from('test_bookings');
        SupabaseQueryBuilder testBookingItems =
            supabaseClient.from('test_booking_item');

        if (event is GetOrdersEvent) {
          if (event.status != null) {
            lastStatus = event.status!;
          }
          List<dynamic> tempOrders = await supabaseClient.rpc(
            'get_test_bookings',
            params: {
              'search_status': lastStatus,
              'search_query': event.query,
              'search_user_id': event.userId,
              'search_nurse_id': event.nurseId,
              'search_patient_id': event.patientId,
              'search_date': event.date != null
                  ? DateFormat('yyyy-MM-dd').format(event.date!)
                  : null,
            },
          );

          List<Map<String, dynamic>> orders =
              tempOrders.map((e) => e as Map<String, dynamic>).toList();

          Logger().w(orders);

          emit(OrdersSuccessState(orders: orders));
        } else if (event is AddOrderEvent) {
          Map<String, dynamic> data = {
            'user_id': supabaseClient.auth.currentUser!.id,
            'patient_id': event.patientId,
          };

          if (event.prescription != null) {
            String path = await supabaseClient.storage.from('docs').upload(
                'prescriptions/${DateTime.now().millisecondsSinceEpoch.toString()}${event.prescription!.name}',
                File(event.prescription!.path!));

            path = path.replaceRange(0, 5, '');

            Logger().wtf(path);

            data['prescription_document'] =
                supabaseClient.storage.from('docs').getPublicUrl(path);
            data['can_pay'] = false;
          }

          Map<String, dynamic> order =
              await testBookings.insert(data).select().single();

          if (event.tests.isNotEmpty) {
            List<Map<String, dynamic>> orderItems = [];
            for (int i = 0; i < event.tests.length; i++) {
              orderItems.add(
                {
                  'test_booking_id': order['id'],
                  'test_id': event.tests[i]['id'],
                  'price': event.tests[i]['price'],
                },
              );
            }
            await testBookingItems.insert(orderItems);
          }

          add(GetOrdersEvent());
        } else if (event is AddOrderTestEvent) {
          await testBookingItems.insert({
            'test_booking_id': event.orderId,
            'test_id': event.test['id'],
            'price': event.test['price'],
          });
          add(GetOrdersEvent());
        } else if (event is UploadOrderTestReportEvent) {
          String path = await supabaseClient.storage.from('docs').uploadBinary(
                'reports/${DateTime.now().millisecondsSinceEpoch.toString()}${event.report.name}',
                event.report.bytes!,
              );

          path = path.replaceRange(0, 5, '');

          Logger().wtf(path);

          String reportUrl =
              supabaseClient.storage.from('docs').getPublicUrl(path);

          await testBookingItems.update({
            'report': reportUrl,
          }).eq('id', event.testBookingId);
          add(GetOrdersEvent());
        } else if (event is ChangeOrderTestStatusEvent) {
          await testBookingItems
              .update({'status': event.status}).eq('id', event.testBookingId);
          add(GetOrdersEvent());
        } else if (event is MarkTestsAddedOrderEvent) {
          await testBookings.update({'can_pay': true}).eq('id', event.orderId);
          add(GetOrdersEvent());
        } else if (event is ChangeOrderStatusEvent) {
          await testBookings
              .update({'status': event.status}).eq('id', event.orderId);
          add(GetOrdersEvent());
        } else if (event is AssignOrderNurseEvent) {
          await testBookings.update(
            {'assigned_nurse_id': event.nurseId},
          ).eq('id', event.orderId);
          add(GetOrdersEvent());
        } else if (event is DeleteOrderTestEvent) {
          await testBookingItems.delete().eq('id', event.testBookingId);
          add(GetOrdersEvent());
        } else if (event is PaymentOrderEvent) {
          await testBookings.update({
            'payment_status': 'paid',
            'payment_id': event.paymentId,
          }).eq('id', event.orderId);
          add(GetOrdersEvent());
        } else if (event is DeleteOrderEvent) {
          await testBookings.delete().eq('id', event.orderId);
          add(GetOrdersEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(OrdersFailureState());
      }
    });
  }
}
