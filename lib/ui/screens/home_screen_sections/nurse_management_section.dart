import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/nurse/nurse_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_search.dart';
import 'package:onlinediagnostic_admin/ui/widgets/nurse_management/add_edit_nurse_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/nurse_management/nurse_card.dart';

class NurseManagmentSection extends StatefulWidget {
  final Function(Map<String, dynamic>)? onSelect;
  const NurseManagmentSection({super.key, this.onSelect});

  @override
  State<NurseManagmentSection> createState() => _NurseManagmentSectionState();
}

class _NurseManagmentSectionState extends State<NurseManagmentSection> {
  NurseBloc nurseBloc = NurseBloc();

  @override
  void initState() {
    nurseBloc.add(GetAllNurseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: BlocProvider<NurseBloc>.value(
          value: nurseBloc,
          child: BlocConsumer<NurseBloc, NurseState>(
            listener: (context, state) {
              if (state is NurseFailureState) {
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearch(
                          onSearch: (search) {
                            nurseBloc.add(GetAllNurseEvent(query: search));
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
                            builder: (context) => BlocProvider<NurseBloc>.value(
                              value: nurseBloc,
                              child: const AddEditNurseDialog(),
                            ),
                          );
                        },
                        label: 'Add Nurse',
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
                  state is NurseLoadingState
                      ? const Center(
                          child: CustomProgressIndicator(),
                        )
                      : Expanded(
                          child: state is NurseSuccessState
                              ? state.nurses.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        alignment: WrapAlignment.start,
                                        children: List<Widget>.generate(
                                          state.nurses.length,
                                          (index) => NurseCard(
                                            onSelect: widget.onSelect,
                                            nurseBloc: nurseBloc,
                                            nurseDetails: state.nurses[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Nurses Found!'),
                                    )
                              : state is NurseFailureState
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomActionButton(
                                            iconData: Icons.replay_outlined,
                                            onPressed: () {
                                              nurseBloc.add(GetAllNurseEvent());
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
