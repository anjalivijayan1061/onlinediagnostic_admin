import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_search.dart';
import 'package:onlinediagnostic_admin/ui/widgets/patient_management/add_edit_patient_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/patient_management/patient_card.dart';

class UserManagementSection extends StatefulWidget {
  const UserManagementSection({super.key});

  @override
  State<UserManagementSection> createState() => _UserManagementSectionState();
}

class _UserManagementSectionState extends State<UserManagementSection> {
  PatientBloc patientBloc = PatientBloc();

  @override
  void initState() {
    patientBloc.add(GetAllPatientEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: BlocProvider<PatientBloc>.value(
          value: patientBloc,
          child: BlocConsumer<PatientBloc, PatientState>(
            listener: (context, state) {
              if (state is PatientFailureState) {
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
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearch(
                          onSearch: (search) {
                            patientBloc.add(
                              GetAllPatientEvent(
                                query: search,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomActionButton(
                        iconData: Icons.add,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                BlocProvider<PatientBloc>.value(
                              value: patientBloc,
                              child: const AddEditPatientDialog(),
                            ),
                          );
                        },
                        label: 'Add Patient',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  state is PatientLoadingState
                      ? const Center(
                          child: CustomProgressIndicator(),
                        )
                      : Expanded(
                          child: state is PatientSuccessState
                              ? state.patients.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        alignment: WrapAlignment.start,
                                        children: List<Widget>.generate(
                                          state.patients.length,
                                          (index) => PatientCard(
                                            patientDetails:
                                                state.patients[index],
                                            patientBloc: patientBloc,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Patients Found!'),
                                    )
                              : state is PatientFailureState
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomActionButton(
                                            iconData: Icons.replay_outlined,
                                            onPressed: () {
                                              patientBloc
                                                  .add(GetAllPatientEvent());
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
