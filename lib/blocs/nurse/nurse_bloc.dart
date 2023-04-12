import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:onlinediagnostic_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'nurse_event.dart';
part 'nurse_state.dart';

class NurseBloc extends Bloc<NurseEvent, NurseState> {
  NurseBloc() : super(NurseInitialState()) {
    on<NurseEvent>((event, emit) async {
      emit(NurseLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('nurses');

      try {
        if (event is GetAllNurseEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> nurses = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          emit(NurseSuccessState(nurses: nurses));
        } else if (event is AddNurseEvent) {
          UserResponse userDetails = await supabaseClient.auth.admin.createUser(
            AdminUserAttributes(
              email: event.email,
              password: event.password,
              phone: event.phone,
              userMetadata: {
                'status': 'active',
              },
              emailConfirm: true,
            ),
          );
          if (userDetails.user != null) {
            await queryTable.insert({
              'user_id': userDetails.user!.id,
              'name': event.name,
              'phone': event.phone,
              'dob': event.dob.toIso8601String(),
            });
            add(GetAllNurseEvent());
          } else {
            emit(NurseFailureState());
          }
        } else if (event is EditNurseEvent) {
          AdminUserAttributes attributes =
              AdminUserAttributes(email: event.email);

          if (event.password != null) {
            attributes.password = event.password;
          }

          UserResponse userDetails =
              await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: attributes,
          );
          if (userDetails.user != null) {
            await queryTable.update({
              'name': event.name,
              'phone': event.phone,
              'dob': event.dob.toIso8601String(),
            }).eq('user_id', event.userId);
            add(GetAllNurseEvent());
          } else {
            emit(NurseFailureState());
          }
        } else if (event is DeleteNurseEvent) {
          await queryTable.delete().eq('user_id', event.userId);
          await supabaseClient.auth.admin.deleteUser(event.userId);
          add(GetAllNurseEvent());
        } else if (event is ChangeStatusNurseEvent) {
          await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: AdminUserAttributes(
              userMetadata: {
                'status': event.status,
              },
              banDuration: event.status == 'active' ? 'none' : '1000h0m',
            ),
          );
          add(GetAllNurseEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(NurseFailureState(message: e.toString()));
      }
    });
  }
}
