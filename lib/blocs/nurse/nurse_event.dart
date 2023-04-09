part of 'nurse_bloc.dart';

@immutable
abstract class NurseEvent {}

class AddNurseEvent extends NurseEvent {
  final String name, phone, email, password;
  final DateTime dob;

  AddNurseEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.dob,
  });
}

class EditNurseEvent extends NurseEvent {
  final String name, phone, email, userId;
  final String? password;
  final DateTime dob;

  EditNurseEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    required this.dob,
    this.password,
  });
}

class DeleteNurseEvent extends NurseEvent {
  final String userId;

  DeleteNurseEvent({required this.userId});
}

class ChangeStatusNurseEvent extends NurseEvent {
  final String userId, status;

  ChangeStatusNurseEvent({
    required this.userId,
    required this.status,
  });
}

class GetAllNurseEvent extends NurseEvent {
  final String? query;

  GetAllNurseEvent({this.query});
}
