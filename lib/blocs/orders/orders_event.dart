part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {
  final String? status;
  final String? userId, nurseId, query;
  final int? patientId;
  final DateTime? date;

  GetOrdersEvent({
    this.status,
    this.patientId,
    this.userId,
    this.nurseId,
    this.date,
    this.query,
  });
}

class AddOrderEvent extends OrdersEvent {
  final int patientId;
  final PlatformFile? prescription;
  final List<Map<String, dynamic>> tests;

  AddOrderEvent({
    required this.patientId,
    this.prescription,
    required this.tests,
  });
}

class AddOrderTestEvent extends OrdersEvent {
  final int orderId;
  final Map<String, dynamic> test;

  AddOrderTestEvent({
    required this.orderId,
    required this.test,
  });
}

class ChangeOrderStatusEvent extends OrdersEvent {
  final int orderId;
  final String status;

  ChangeOrderStatusEvent({
    required this.orderId,
    required this.status,
  });
}

class MarkTestsAddedOrderEvent extends OrdersEvent {
  final int orderId;

  MarkTestsAddedOrderEvent({
    required this.orderId,
  });
}

class ChangeOrderTestStatusEvent extends OrdersEvent {
  final int testBookingId;
  final String status;

  ChangeOrderTestStatusEvent({
    required this.testBookingId,
    required this.status,
  });
}

class UploadOrderTestReportEvent extends OrdersEvent {
  final int testBookingId;
  final PlatformFile report;

  UploadOrderTestReportEvent({
    required this.testBookingId,
    required this.report,
  });
}

class AssignOrderNurseEvent extends OrdersEvent {
  final int orderId;
  final String nurseId;

  AssignOrderNurseEvent({
    required this.orderId,
    required this.nurseId,
  });
}

class DeleteOrderTestEvent extends OrdersEvent {
  final int testBookingId;

  DeleteOrderTestEvent({required this.testBookingId});
}

class DeleteOrderEvent extends OrdersEvent {
  final int orderId;

  DeleteOrderEvent({required this.orderId});
}

class PaymentOrderEvent extends OrdersEvent {
  final int orderId;
  final String paymentId;

  PaymentOrderEvent({
    required this.orderId,
    required this.paymentId,
  });
}
