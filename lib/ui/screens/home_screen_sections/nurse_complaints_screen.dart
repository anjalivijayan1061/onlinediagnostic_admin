import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/complaint/complaint_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/complaints/complaint_card.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_progress_indicator.dart';

class NurseComplaintsScreen extends StatefulWidget {
  const NurseComplaintsScreen({super.key});

  @override
  State<NurseComplaintsScreen> createState() => _NurseComplaintsScreenState();
}

class _NurseComplaintsScreenState extends State<NurseComplaintsScreen> {
  ComplaintBloc complaintBloc = ComplaintBloc();

  @override
  void initState() {
    complaintBloc.add(GetAllNurseComplaintEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: BlocProvider<ComplaintBloc>.value(
          value: complaintBloc,
          child: BlocConsumer<ComplaintBloc, ComplaintState>(
            listener: (context, state) {
              if (state is ComplaintFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  state is ComplaintLoadingState
                      ? const Center(
                          child: CustomProgressIndicator(),
                        )
                      : Expanded(
                          child: state is ComplaintSuccessState
                              ? state.complaints.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        alignment: WrapAlignment.start,
                                        children: List<Widget>.generate(
                                          state.complaints.length,
                                          (index) => ComplaintCard(
                                            complaintDetails:
                                                state.complaints[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Nurse complaints Found!'),
                                    )
                              : state is ComplaintFailureState
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomActionButton(
                                            iconData: Icons.replay_outlined,
                                            onPressed: () {
                                              complaintBloc.add(
                                                  GetAllNurseComplaintEvent());
                                            },
                                            label: 'Retry',
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                        ),
                  const SizedBox(
                    height: 30,
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
