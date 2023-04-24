import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:onlinediagnostic_admin/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_admin/ui/screens/select_nurse_screen.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_card.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_date_picker.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_search.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/ui/widgets/patient_management/patient_card.dart';
import 'package:onlinediagnostic_admin/util/get_age.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/orders/orders_bloc.dart';
import '../../widgets/custom_file_picker.dart';
import '../../widgets/test_selector.dart';

class OrderManagementSection extends StatefulWidget {
  final bool fromDashboard;
  const OrderManagementSection({
    super.key,
    this.fromDashboard = false,
  });

  @override
  State<OrderManagementSection> createState() => _OrderManagementSectionState();
}

class _OrderManagementSectionState extends State<OrderManagementSection> {
  final OrdersBloc ordersBloc = OrdersBloc();
  String selectedStatus = 'pending';
  DateTime? selectedDate;
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() {
    ordersBloc.add(
      GetOrdersEvent(
        status: selectedStatus,
        date: selectedDate,
        query: searchQuery,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: BlocProvider<OrdersBloc>.value(
          value: ordersBloc,
          child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is OrdersFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Retry',
                    primaryOnPressed: () {
                      getOrders();
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  if (widget.fromDashboard)
                    Row(
                      children: [
                        Text(
                          "Pending Bookings",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  if (!widget.fromDashboard)
                    Row(
                      children: [
                        Expanded(
                          child: CustomSearch(
                            onSearch: (query) {
                              searchQuery = query;
                              getOrders();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomDatePicker(
                          onPick: (date) {
                            selectedDate = date;
                            getOrders();
                          },
                          onClear: () {
                            selectedDate = null;
                            getOrders();
                          },
                        ),
                      ],
                    ),
                  if (!widget.fromDashboard) const SizedBox(height: 10),
                  if (!widget.fromDashboard) const Divider(height: 1),
                  if (!widget.fromDashboard) const SizedBox(height: 15),
                  if (!widget.fromDashboard)
                    Row(
                      children: [
                        CustomActionButton(
                          iconData: Icons.pending_actions_outlined,
                          onPressed: () {
                            selectedStatus = 'pending';
                            getOrders();
                            setState(() {});
                          },
                          label: 'Pending',
                          color: selectedStatus == 'pending'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        CustomActionButton(
                          iconData: Icons.library_books_outlined,
                          onPressed: () {
                            selectedStatus = 'collected';
                            getOrders();
                            setState(() {});
                          },
                          label: 'Testing',
                          color: selectedStatus == 'collected'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        CustomActionButton(
                          iconData: Icons.file_download_done_rounded,
                          onPressed: () {
                            selectedStatus = 'complete';
                            getOrders();
                            setState(() {});
                          },
                          label: 'Completed',
                          color: selectedStatus == 'complete'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ],
                    ),
                  const SizedBox(height: 15),
                  const Divider(height: 1),
                  Expanded(
                    child: state is OrdersLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : state is OrdersSuccessState
                            ? state.orders.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    itemBuilder: (context, index) => OrderCard(
                                      orderDetails: state.orders[index],
                                      ordersBloc: ordersBloc,
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemCount: state.orders.length,
                                  )
                                : const Center(
                                    child: Text('No Bookings Found.'))
                            : const SizedBox(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> orderDetails;
  final OrdersBloc ordersBloc;
  const OrderCard(
      {Key? key, required this.orderDetails, required this.ordersBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${orderDetails['id'].toString()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black45,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: SizedBox(
                            width: 1000,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: PatientCard(
                                        readOnly: true,
                                        patientDetails: orderDetails['patient'],
                                        patientBloc: PatientBloc(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      orderDetails['patient']['name'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${getAge(DateTime.parse(orderDetails['patient']['dob']))} ${orderDetails['patient']['gender']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Divider(
                    height: 30,
                    endIndent: 100,
                  ),
                  Row(
                    children: [
                      LabelWithText(
                        label: 'Assigned to',
                        text: orderDetails['assigned_nurse'] != null
                            ? orderDetails['assigned_nurse']['name']
                            : 'Not Assigned',
                      ),
                      const SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          width: 30,
                        ),
                      ),
                      LabelWithText(
                        label: 'Number of Tests',
                        text: orderDetails['test_booking_items'] != null
                            ? orderDetails['test_booking_items']
                                .length
                                .toString()
                            : '-',
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                    endIndent: 100,
                  ),
                  Text(
                    '₹${orderDetails['total_price'].toString()} ${orderDetails['payment_status']}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: orderDetails['payment_status'] == 'paid'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.end,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  if (orderDetails['prescription_document'] != null)
                    CustomButton(
                      label: 'Prescription',
                      onTap: () {
                        launchUrl(
                            Uri.parse(orderDetails['prescription_document']));
                      },
                      labelColor: Colors.blue,
                      icon: Icons.document_scanner_outlined,
                      iconColor: Colors.blue,
                    ),
                  CustomButton(
                    label: 'Tests',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          title: 'Tests',
                          message: '',
                          content: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Material(
                              color: Colors.blueGrey[50],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderDetails['test_booking_items']
                                                [index]['test']['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '₹${orderDetails['test_booking_items'][index]['price'].toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${orderDetails['test_booking_items'][index]['test']['sample_type']} | ${orderDetails['test_booking_items'][index]['test']['duration']}h | ${orderDetails['test_booking_items'][index]['test']['sample_from_home'] ? 'From Home' : ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    orderDetails['test_booking_items'][index]
                                                ['report'] !=
                                            null
                                        ? InkWell(
                                            onTap: () async {
                                              launchUrl(
                                                Uri.parse(
                                                  orderDetails[
                                                          'test_booking_items']
                                                      [index]['report'],
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.document_scanner_outlined,
                                              size: 18,
                                              color: Colors.blue,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              PlatformFile? file =
                                                  await pickFile();
                                              if (file != null) {
                                                ordersBloc.add(
                                                  UploadOrderTestReportEvent(
                                                    report: file,
                                                    testBookingId: orderDetails[
                                                            'test_booking_items']
                                                        [index]['id'],
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Icon(
                                              Icons.upload_outlined,
                                              size: 18,
                                              color: Colors.blue,
                                            ),
                                          ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        ordersBloc.add(
                                          DeleteOrderTestEvent(
                                            testBookingId: orderDetails[
                                                    'test_booking_items'][index]
                                                ['id'],
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.delete_forever_outlined,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount:
                                orderDetails['test_booking_items'].length,
                          ),
                        ),
                      );
                    },
                    labelColor: Colors.blue,
                    icon: Icons.list_alt_outlined,
                    iconColor: Colors.blue,
                  ),
                  if ((orderDetails['prescription_document'] != null ||
                          orderDetails['user_id'] == null) &&
                      !orderDetails['can_pay'])
                    CustomButton(
                      label: 'Add Test',
                      onTap: () {
                        Map<String, dynamic>? selectedTest;
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Add Test',
                            message:
                                'Select a test from list to add it for the patient',
                            content: TestSelector(
                              onSelect: (test) {
                                selectedTest = test;
                              },
                            ),
                            primaryButtonLabel: 'Add',
                            primaryOnPressed: () {
                              if (selectedTest != null) {
                                ordersBloc.add(
                                  AddOrderTestEvent(
                                    orderId: orderDetails['id'],
                                    test: selectedTest!,
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => const CustomAlertDialog(
                                    title: 'Required',
                                    message: 'Please select a test to add it.',
                                    primaryButtonLabel: 'Ok',
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                      labelColor: Colors.blue,
                      icon: Icons.add,
                      iconColor: Colors.blue,
                    ),
                  if (orderDetails['prescription_document'] != null &&
                      !orderDetails['can_pay'])
                    CustomButton(
                      label: 'Tests Added',
                      onTap: () {
                        ordersBloc.add(MarkTestsAddedOrderEvent(
                            orderId: orderDetails['id']));
                      },
                      labelColor: Colors.blue,
                      icon: Icons.done_all,
                      iconColor: Colors.blue,
                    ),
                  if (orderDetails['assigned_nurse'] == null)
                    CustomButton(
                      label: 'Assign Nurse',
                      onTap: () async {
                        Map<String, dynamic>? nurseDetails =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SelectNurseScreen(),
                          ),
                        );

                        if (nurseDetails != null) {
                          ordersBloc.add(
                            AssignOrderNurseEvent(
                              orderId: orderDetails['id'],
                              nurseId: nurseDetails['user_id'],
                            ),
                          );
                        }
                      },
                      labelColor: Colors.orange,
                      icon: Icons.assignment_ind_outlined,
                      iconColor: Colors.orange,
                      hoverBorderColor: Colors.orange,
                    ),
                  if (orderDetails['status'] == 'pending' ||
                      orderDetails['status'] == 'collected')
                    CustomButton(
                      label: orderDetails['status'] == 'pending'
                          ? 'Sample Collected'
                          : 'Complete',
                      onTap: () {
                        ordersBloc.add(
                          ChangeOrderStatusEvent(
                            orderId: orderDetails['id'],
                            status: orderDetails['status'] == 'pending'
                                ? 'collected'
                                : 'complete',
                          ),
                        );
                      },
                      labelColor: Colors.green,
                      icon: Icons.done,
                      iconColor: Colors.green,
                      hoverBorderColor: Colors.green,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
