part of 'nurse_bloc.dart';

@immutable
abstract class NurseState {}

class NurseInitialState extends NurseState {}

class NurseLoadingState extends NurseState {}

class NurseSuccessState extends NurseState {
  final List<Map<String, dynamic>> nurses;

  NurseSuccessState({required this.nurses});
}

class NurseFailureState extends NurseState {
  final String message;

  NurseFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
