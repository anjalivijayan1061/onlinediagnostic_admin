import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/manage_test/manage_test_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/ui/widgets/test_management/add_edit_test_dialog.dart';

class TestCard extends StatelessWidget {
  final Map<String, dynamic> testDetails;
  final ManageTestBloc manageTestBloc;
  const TestCard({
    Key? key,
    required this.testDetails,
    required this.manageTestBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black26,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Id',
                      text: '#${testDetails['id'].toString()}',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Test Name',
                      text: '${testDetails['name']}',
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Sample Type',
                      text: '${testDetails['sample_type']}',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Price',
                      text: '₹ ${testDetails['price'].toString()}',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Duration',
                      text: '${testDetails['duration']} hours',
                    ),
                  ),
                ],
              ),
              const Divider(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Can collect sample from home : ',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                    children: [
                      TextSpan(
                        text: testDetails['sample_from_home'] ? 'Yes' : 'No',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: testDetails['sample_from_home']
                                  ? Colors.green[700]
                                  : Colors.red[700],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.delete,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => CustomAlertDialog(
                            title: 'Are you sure?',
                            message:
                                'Are you sure you want to delete this test? any data associated with this test will be deleted as well',
                            primaryButtonLabel: 'Delete',
                            primaryOnPressed: () {
                              manageTestBloc.add(
                                DeleteTestEvent(
                                  testId: testDetails['id'],
                                ),
                              );
                              Navigator.pop(context);
                            },
                            secondaryButtonLabel: 'Cancel',
                          ),
                        );
                      },
                      label: 'Delete',
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.edit,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: manageTestBloc,
                            child: AddEditTestDialog(
                              testDetails: testDetails,
                            ),
                          ),
                        );
                      },
                      label: 'Edit',
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
