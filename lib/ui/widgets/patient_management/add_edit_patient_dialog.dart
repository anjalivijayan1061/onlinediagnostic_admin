import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_date_picker.dart';
import 'package:onlinediagnostic_admin/ui/widgets/gender_selector.dart';

import '../custom_button.dart';
import '../custom_card.dart';

class AddEditPatientDialog extends StatefulWidget {
  final Map<String, dynamic>? patientDetails;
  const AddEditPatientDialog({
    super.key,
    this.patientDetails,
  });

  @override
  State<AddEditPatientDialog> createState() => _AddEditPatientDialogState();
}

class _AddEditPatientDialogState extends State<AddEditPatientDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  DateTime? _dob;
  String _gender = 'male';

  @override
  void initState() {
    if (widget.patientDetails != null) {
      _nameController.text = widget.patientDetails!['name'];
      _addressController.text = widget.patientDetails!['address'];
      _phoneNumberController.text = widget.patientDetails!['phone'];
      _cityController.text = widget.patientDetails!['city'];
      _districtController.text = widget.patientDetails!['district'];
      _stateController.text = widget.patientDetails!['state'];
      _dob = DateTime.parse(widget.patientDetails!['dob']);
      _gender = widget.patientDetails!['gender'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: SizedBox(
        width: 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.patientDetails != null
                                ? "Edit Patient"
                                : "Add Patient",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.patientDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a patient.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter Name';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg. Mr.John',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Address',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    maxLines: 3,
                    controller: _addressController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter address';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'address line 1, address line 2',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _phoneNumberController,
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter Phone';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'eg. 9876543210',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _cityController,
                              validator: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) ||
                                    widget.patientDetails != null) {
                                  return null;
                                } else {
                                  return 'Please enter your city';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Kannur',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'District',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _districtController,
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter your district';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Kannur',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomCard(
                            child: TextFormField(
                              controller: _stateController,
                              validator: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) ||
                                    widget.patientDetails != null) {
                                  return null;
                                } else {
                                  return 'Please enter your state';
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Kerala',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                GenderSelector(
                  selected: _gender,
                  onSelect: (gender) {
                    _gender = gender;
                  },
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Date of Birth',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomDatePicker(
                  defaultDate: _dob,
                  onPick: (date) {
                    _dob = date;
                  },
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.patientDetails != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  buttonColor: Colors.blue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (_dob != null) {
                        if (widget.patientDetails != null) {
                          BlocProvider.of<PatientBloc>(context).add(
                            EditPatientEvent(
                              patientId: widget.patientDetails!['id'],
                              name: _nameController.text.trim(),
                              phone: _phoneNumberController.text.trim(),
                              address: _addressController.text.trim(),
                              city: _cityController.text.trim(),
                              district: _districtController.text.trim(),
                              dob: _dob!,
                              gender: _gender,
                              state: _stateController.text.trim(),
                            ),
                          );
                        } else {
                          BlocProvider.of<PatientBloc>(context).add(
                            AddPatientEvent(
                              name: _nameController.text.trim(),
                              phone: _phoneNumberController.text.trim(),
                              address: _addressController.text.trim(),
                              city: _cityController.text.trim(),
                              district: _districtController.text.trim(),
                              dob: _dob!,
                              gender: _gender,
                              state: _stateController.text.trim(),
                            ),
                          );
                        }

                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Required!',
                            message:
                                'Date of Birth is required, please select the Date of Birth',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
