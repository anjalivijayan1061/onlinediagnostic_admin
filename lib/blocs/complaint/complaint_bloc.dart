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

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> complaints = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;
            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';
            element['phone'] = user != null ? user.phone : '';

            return element;
          }).toList();

          Map<String, dynamic> complaintWithTestMap = {};

          for (Map<String, dynamic> complaint in complaints) {
            Map<String, dynamic> test = await subQueryTable
                .select()
                .eq('id', complaint['test_id'])
                .single();

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

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> complaints = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;
            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';
            element['phone'] = user != null ? user.phone : '';

            return element;
          }).toList();

          Map<String, dynamic> complaintWithTestMap = {};

          for (Map<String, dynamic> complaint in complaints) {
            Map<String, dynamic> test = await subQueryTable
                .select()
                .eq('id', complaint['test_id'])
                .single();

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
