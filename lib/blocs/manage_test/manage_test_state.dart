part of 'manage_test_bloc.dart';

@immutable
abstract class ManageTestState {}

class ManageTestInitialState extends ManageTestState {}

class ManageTestLoadingState extends ManageTestState {}

class ManageTestSuccessState extends ManageTestState {
  final List<Map<String, dynamic>> tests;

  ManageTestSuccessState({required this.tests});
}

class ManageTestFailureState extends ManageTestState {
  final String message;

  ManageTestFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
