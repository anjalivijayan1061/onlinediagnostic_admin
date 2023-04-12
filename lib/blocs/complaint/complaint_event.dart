part of 'complaint_bloc.dart';

@immutable
abstract class ComplaintEvent {}

class GetAllNurseComplaintEvent extends ComplaintEvent {
  final String? query;

  GetAllNurseComplaintEvent({this.query});
}

class GetAllPatientComplaintEvent extends ComplaintEvent {
  final String? query;

  GetAllPatientComplaintEvent({this.query});
}
