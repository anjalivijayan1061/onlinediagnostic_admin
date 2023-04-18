import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/order_management_section.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/dashcard.dart';

import '../../widgets/custom_alert_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  @override
  void initState() {
    super.initState();
    dashboardCountBloc.add(DashboardCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            BlocProvider<DashboardCountBloc>.value(
              value: dashboardCountBloc,
              child: BlocConsumer<DashboardCountBloc, DashboardCountState>(
                listener: (context, state) {
                  if (state is DashboardCountFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Failure',
                        message: state.message,
                        primaryButtonLabel: 'Ok',
                        primaryOnPressed: () {
                          dashboardCountBloc.add(DashboardCountEvent());
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return state is DashboardCountSuccessState
                      ? Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            DashCard(
                              iconData: Icons.receipt_outlined,
                              label: 'Pending Bookings',
                              value: state.dashbordCount['test_booking_count']
                                  .toString(),
                            ),
                            DashCard(
                              iconData: Icons.local_hospital_outlined,
                              label: 'Total Nurses',
                              value:
                                  state.dashbordCount['nurse_count'].toString(),
                            ),
                            DashCard(
                              iconData: Icons.text_snippet_outlined,
                              label: 'Total Tests',
                              value:
                                  state.dashbordCount['test_count'].toString(),
                            ),
                            DashCard(
                              iconData: Icons.sick_outlined,
                              label: 'Total Patients',
                              value: state.dashbordCount['patient_count']
                                  .toString(),
                            ),
                          ],
                        )
                      : const Padding(
                          padding: EdgeInsets.all(50.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                },
              ),
            ),
            const Expanded(
              child: OrderManagementSection(
                fromDashboard: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
