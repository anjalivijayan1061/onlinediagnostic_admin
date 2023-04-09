import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_test_event.dart';
part 'manage_test_state.dart';

class ManageTestBloc extends Bloc<ManageTestEvent, ManageTestState> {
  ManageTestBloc() : super(ManageTestInitialState()) {
    on<ManageTestEvent>((event, emit) async {
      emit(ManageTestLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('tests');

      try {
        if (event is GetAllTestEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<Map<String, dynamic>> tests =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(ManageTestSuccessState(tests: tests));
        } else if (event is AddTestEvent) {
          await queryTable.insert({
            'name': event.name,
            'price': event.price,
            'sample_type': event.sampleType,
            'sample_from_home': event.sampleFromHome,
            'duration': event.duration,
          });
          add(GetAllTestEvent());
        } else if (event is EditTestEvent) {
          await queryTable.update({
            'name': event.name,
            'price': event.price,
            'sample_type': event.sampleType,
            'sample_from_home': event.sampleFromHome,
            'duration': event.duration,
          }).eq('id', event.testId);
          add(GetAllTestEvent());
        } else if (event is DeleteTestEvent) {
          await queryTable.delete().eq('id', event.testId);
          add(GetAllTestEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ManageTestFailureState(message: e.toString()));
      }
    });
  }
}
