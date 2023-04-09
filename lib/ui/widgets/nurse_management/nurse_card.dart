import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/nurse/nurse_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/ui/widgets/nurse_management/add_edit_nurse_dialog.dart';
import 'package:onlinediagnostic_admin/util/get_age.dart';

class NurseCard extends StatelessWidget {
  final NurseBloc nurseBloc;
  final Map<String, dynamic> nurseDetails;
  const NurseCard(
      {Key? key, required this.nurseDetails, required this.nurseBloc})
      : super(key: key);

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
                      text: '#${nurseDetails['id'].toString()}',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Name',
                      text: '${nurseDetails['name']}',
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
                      label: 'Age',
                      text: getAge(
                        DateTime.parse(
                          nurseDetails['dob'].toString(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone',
                      text: '${nurseDetails['phone']}',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                crossAxisAlignment: CrossAxisAlignment.start,
                label: 'Email',
                text: '${nurseDetails['email']}',
              ),
              const Divider(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Status : ',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                    children: [
                      TextSpan(
                        text: nurseDetails['status'] == 'active'
                            ? 'Active'
                            : 'Blocked',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: nurseDetails['status'] == 'active'
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
                                'Are you sure you want to delete this nurse? any data associated with this nurse will be deleted as well',
                            primaryButtonLabel: 'Delete',
                            primaryOnPressed: () {
                              nurseBloc.add(
                                DeleteNurseEvent(
                                  userId: nurseDetails['user_id'],
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
                            value: nurseBloc,
                            child: AddEditNurseDialog(
                              nurseDetails: nurseDetails,
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
              const Divider(),
              CustomActionButton(
                iconData: Icons.block_outlined,
                onPressed: () {
                  nurseBloc.add(
                    ChangeStatusNurseEvent(
                      userId: nurseDetails['user_id'],
                      status: nurseDetails['status'] == 'active'
                          ? 'blocked'
                          : 'active',
                    ),
                  );
                },
                label: nurseDetails['status'] == 'active' ? 'Block' : 'Unblock',
                color: nurseDetails['status'] == 'active'
                    ? Colors.orange
                    : Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
