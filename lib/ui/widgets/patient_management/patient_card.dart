import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlinediagnostic_admin/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_card.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_map.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/ui/widgets/patient_management/add_edit_patient_dialog.dart';
import 'package:onlinediagnostic_admin/util/get_age.dart';

class PatientCard extends StatelessWidget {
  final Map<String, dynamic> patientDetails;
  final PatientBloc patientBloc;
  final bool readOnly;

  const PatientCard({
    Key? key,
    required this.patientDetails,
    required this.patientBloc,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Id',
                      text: '#${patientDetails['id'].toString()}',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Name',
                      text: patientDetails['name'],
                    ),
                  ),
                ],
              ),
              const Divider(),
              LabelWithText(
                label: 'Address',
                text: patientDetails['address'],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Phone',
                      text: patientDetails['phone'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'City',
                      text: patientDetails['city'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'District',
                      text: patientDetails['district'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'State',
                      text: patientDetails['state'],
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
                          patientDetails['dob'].toString(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Gender',
                      text: patientDetails['gender'] == 'male'
                          ? 'Male'
                          : 'Female',
                    ),
                  ),
                ],
              ),
              const Divider(),
              CustomActionButton(
                iconData: (patientDetails['latitude'] != null &&
                        patientDetails['longitude'] != null)
                    ? Icons.arrow_outward_outlined
                    : Icons.block_outlined,
                onPressed: (patientDetails['latitude'] != null &&
                        patientDetails['longitude'] != null)
                    ? () {
                        LatLng latLng = LatLng(
                          patientDetails['latitude'],
                          patientDetails['longitude'],
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CustomMap(latLng: latLng),
                          ),
                        );
                      }
                    : () {},
                label: (patientDetails['latitude'] != null &&
                        patientDetails['longitude'] != null)
                    ? 'Location'
                    : 'Location not added',
                color: (patientDetails['latitude'] != null &&
                        patientDetails['longitude'] != null)
                    ? Colors.blue
                    : Colors.grey,
              ),
              if (!readOnly) const Divider(),
              if (!readOnly)
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
                                  'Are you sure you want to delete this patient? any data associated with this patient will be deleted as well',
                              primaryButtonLabel: 'Delete',
                              primaryOnPressed: () {
                                patientBloc.add(
                                  DeletePatientEvent(
                                    patientId: patientDetails['id'],
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
                              value: patientBloc,
                              child: AddEditPatientDialog(
                                patientDetails: patientDetails,
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
