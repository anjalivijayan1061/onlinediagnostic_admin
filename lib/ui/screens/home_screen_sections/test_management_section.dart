import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/manage_test/manage_test_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_search.dart';
import 'package:onlinediagnostic_admin/ui/widgets/test_management/add_edit_test_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/test_management/test_card.dart';

class TestManagementSection extends StatefulWidget {
  const TestManagementSection({super.key});

  @override
  State<TestManagementSection> createState() => _TestManagementSectionState();
}

class _TestManagementSectionState extends State<TestManagementSection> {
  ManageTestBloc manageTestBloc = ManageTestBloc();

  @override
  void initState() {
    manageTestBloc.add(GetAllTestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: BlocProvider<ManageTestBloc>.value(
          value: manageTestBloc,
          child: BlocConsumer<ManageTestBloc, ManageTestState>(
            listener: (context, state) {
              if (state is ManageTestFailureState) {
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
                            manageTestBloc.add(
                              GetAllTestEvent(
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
                                BlocProvider<ManageTestBloc>.value(
                              value: manageTestBloc,
                              child: const AddEditTestDialog(),
                            ),
                          );
                        },
                        label: 'Add Test',
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
                  state is ManageTestLoadingState
                      ? const Center(
                          child: CustomProgressIndicator(),
                        )
                      : Expanded(
                          child: state is ManageTestSuccessState
                              ? state.tests.isNotEmpty
                                  ? SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        alignment: WrapAlignment.start,
                                        children: List<Widget>.generate(
                                          state.tests.length,
                                          (index) => TestCard(
                                            testDetails: state.tests[index],
                                            manageTestBloc: manageTestBloc,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Tests Found!'),
                                    )
                              : state is ManageTestFailureState
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomActionButton(
                                            iconData: Icons.replay_outlined,
                                            onPressed: () {
                                              manageTestBloc
                                                  .add(GetAllTestEvent());
                                            },
                                            label: 'Retry',
                                          ),
                                        ],
                                      ),
                                    )
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
