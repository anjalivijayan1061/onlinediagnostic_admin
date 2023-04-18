import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/blocs/orders/orders_bloc.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/order_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/test_details_screen.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_card.dart';
import 'package:onlinediagnostic_admin/util/get_date.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaintDetails;
  const ComplaintCard({
    super.key,
    required this.complaintDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getDate(DateTime.parse(
                        complaintDetails['complaint']['created_at'])),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black38,
              ),
              Text(
                complaintDetails['complaint']['complaint'],
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Divider(
                color: Colors.black38,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomActionButton(
                label: 'Test Details',
                iconData: Icons.arrow_outward,
                onPressed: () {
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
                                        child: OrderCard(
                                          orderDetails:
                                              complaintDetails['test'],
                                          ordersBloc: OrdersBloc(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
