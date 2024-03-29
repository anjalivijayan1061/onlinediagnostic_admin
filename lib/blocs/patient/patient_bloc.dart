import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientInitialState()) {
    on<PatientEvent>((event, emit) async {
      emit(PatientLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('patients');

      try {
        if (event is GetAllPatientEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<Map<String, dynamic>> patients =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(PatientSuccessState(patients: patients));
        } else if (event is AddPatientEvent) {
          await queryTable.insert({
            'name': event.name,
            'gender': event.gender,
            'phone': event.phone,
            'dob': event.dob.toIso8601String(),
            'address': event.address,
            'city': event.city,
            'district': event.district,
            'state': event.state,
            'latitude': null,
            'longitude': null,
            'user_id': null,
          });
          add(GetAllPatientEvent());
        } else if (event is EditPatientEvent) {
          await queryTable.update({
            'name': event.name,
            'gender': event.gender,
            'phone': event.phone,
            'dob': event.dob.toIso8601String(),
            'address': event.address,
            'city': event.city,
            'district': event.district,
            'state': event.state,
            'latitude': null,
            'longitude': null,
            'user_id': null,
          }).eq('id', event.patientId);
          add(GetAllPatientEvent());
        } else if (event is DeletePatientEvent) {
          await queryTable.delete().eq('id', event.patientId);
          add(GetAllPatientEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(PatientFailureState(message: e.toString()));
      }
    });
  }
}
