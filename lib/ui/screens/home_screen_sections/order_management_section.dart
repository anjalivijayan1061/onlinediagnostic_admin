import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_card.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_date_picker.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_search.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/util/get_age.dart';

import '../../../blocs/orders/orders_bloc.dart';

class OrderManagementSection extends StatefulWidget {
  const OrderManagementSection({super.key});

  @override
  State<OrderManagementSection> createState() => _OrderManagementSectionState();
}

class _OrderManagementSectionState extends State<OrderManagementSection> {
  final OrdersBloc ordersBloc = OrdersBloc();

  @override
  void initState() {
    super.initState();
    ordersBloc.add(GetOrdersEvent());
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
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearch(
                          onSearch: (query) {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomDatePicker(
                        onPick: (date) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      CustomActionButton(
                        iconData: Icons.pending_actions_outlined,
                        onPressed: () {},
                        label: 'Pending',
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      CustomActionButton(
                        iconData: Icons.pending_actions_outlined,
                        onPressed: () {},
                        label: 'Testing',
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      CustomActionButton(
                        iconData: Icons.pending_actions_outlined,
                        onPressed: () {},
                        label: 'Completed',
                        color: Colors.grey,
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
  const OrderCard({Key? key, required this.orderDetails}) : super(key: key);

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
                    onTap: () {},
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
                  LabelWithText(
                    label: 'Assigned to',
                    text: orderDetails['assigned_nurse'] != null
                        ? orderDetails['assigned_nurse']['name']
                        : 'Not Assigned',
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
                      onTap: () {},
                      labelColor: Colors.blue,
                      icon: Icons.document_scanner_outlined,
                      iconColor: Colors.blue,
                    ),
                  CustomButton(
                    label: 'Tests',
                    onTap: () {},
                    labelColor: Colors.blue,
                    icon: Icons.list_alt_outlined,
                    iconColor: Colors.blue,
                  ),
                  if (orderDetails['prescription_document'] != null ||
                      orderDetails['user_id'] == null)
                    CustomButton(
                      label: 'Add Test',
                      onTap: () {},
                      labelColor: Colors.blue,
                      icon: Icons.add,
                      iconColor: Colors.blue,
                    ),
                  if (orderDetails['prescription_document'] != null)
                    CustomButton(
                      label: 'Tests Added',
                      onTap: () {},
                      labelColor: Colors.blue,
                      icon: Icons.done_all,
                      iconColor: Colors.blue,
                    ),
                  if (orderDetails['assigned_nurse'] == null)
                    CustomButton(
                      label: 'Assign Nurse',
                      onTap: () {},
                      labelColor: Colors.orange,
                      icon: Icons.assignment_ind_outlined,
                      iconColor: Colors.orange,
                      hoverBorderColor: Colors.orange,
                    ),
                  CustomButton(
                    label: 'Sample Collected',
                    onTap: () {},
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
