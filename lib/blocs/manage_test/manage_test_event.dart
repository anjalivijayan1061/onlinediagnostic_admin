part of 'manage_test_bloc.dart';

@immutable
abstract class ManageTestEvent {}

class AddTestEvent extends ManageTestEvent {
  final String name, sampleType;
  final bool sampleFromHome;
  final double duration;
  final int price;

  AddTestEvent({
    required this.name,
    required this.price,
    required this.sampleFromHome,
    required this.sampleType,
    required this.duration,
  });
}

class EditTestEvent extends ManageTestEvent {
  final String name, sampleType;
  final bool sampleFromHome;
  final double duration;
  final int testId, price;

  EditTestEvent({
    required this.name,
    required this.price,
    required this.sampleFromHome,
    required this.sampleType,
    required this.duration,
    required this.testId,
  });
}

class DeleteTestEvent extends ManageTestEvent {
  final int testId;

  DeleteTestEvent({required this.testId});
}

class GetAllTestEvent extends ManageTestEvent {
  final String? query;

  GetAllTestEvent({this.query});
}
