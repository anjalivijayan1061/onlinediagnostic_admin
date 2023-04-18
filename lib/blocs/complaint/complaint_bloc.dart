import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:onlinediagnostic_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitialState()) {
    on<ComplaintEvent>((event, emit) async {
      emit(ComplaintLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder subQueryTable = supabaseClient.from('tests');
      List<Map<String, dynamic>> complaintWithTestList = [];
      try {
        if (event is GetAllNurseComplaintEvent) {
          SupabaseQueryBuilder queryTable =
              supabaseClient.from('nurse_complaints');

          List<dynamic> temp = await queryTable.select().order(
                'created_at',
              );

          List<Map<String, dynamic>> complaints = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            return element;
          }).toList();

          Map<String, dynamic> complaintWithTestMap = {};

          for (Map<String, dynamic> complaint in complaints) {
            List<dynamic> tempTest = await supabaseClient.rpc(
              'get_test_bookings',
              params: {
                'search_test_booking_id': complaint['test_booking_id'],
              },
            );

            Map<String, dynamic> test = tempTest.first as Map<String, dynamic>;

            complaintWithTestMap = {
              'complaint': complaint,
              'test': test,
            };

            complaintWithTestList.add(complaintWithTestMap);
          }
          emit(
            ComplaintSuccessState(
              complaints: complaintWithTestList,
            ),
          );
        } else if (event is GetAllPatientComplaintEvent) {
          SupabaseQueryBuilder queryTable = supabaseClient.from('complaints');

          List<dynamic> temp = await queryTable.select().order(
                'created_at',
              );

          List<Map<String, dynamic>> complaints = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            return element;
          }).toList();

          Map<String, dynamic> complaintWithTestMap = {};

          for (Map<String, dynamic> complaint in complaints) {
            List<dynamic> tempTest = await supabaseClient.rpc(
              'get_test_bookings',
              params: {
                'search_test_booking_id': complaint['test_booking_id'],
              },
            );

            Map<String, dynamic> test = tempTest.first as Map<String, dynamic>;

            complaintWithTestMap = {
              'complaint': complaint,
              'test': test,
            };

            complaintWithTestList.add(complaintWithTestMap);
          }
          emit(
            ComplaintSuccessState(
              complaints: complaintWithTestList,
            ),
          );
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ComplaintFailureState());
      }
    });
  }
}
