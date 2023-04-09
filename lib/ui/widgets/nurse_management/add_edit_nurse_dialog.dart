import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/nurse/nurse_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_date_picker.dart';

import '../custom_button.dart';
import '../custom_card.dart';

class AddEditNurseDialog extends StatefulWidget {
  final Map<String, dynamic>? nurseDetails;
  const AddEditNurseDialog({
    super.key,
    this.nurseDetails,
  });

  @override
  State<AddEditNurseDialog> createState() => _AddEditNurseDialogState();
}

class _AddEditNurseDialogState extends State<AddEditNurseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isObscure = true;
  DateTime? _dob;

  @override
  void initState() {
    if (widget.nurseDetails != null) {
      _nameController.text = widget.nurseDetails!['name'];
      _emailController.text = widget.nurseDetails!['email'];
      _phoneNumberController.text = widget.nurseDetails!['phone'].toString();
      _dob = DateTime.parse(widget.nurseDetails!['dob']);
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
        width: 500,
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
                            widget.nurseDetails != null
                                ? "Edit Nurse"
                                : "Add Nurse",
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
                            widget.nurseDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a nurse.",
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
                  'Email',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter Email';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.nurse@onlinediagnostics.com',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: _passwordController,
                    validator: (value) {
                      if ((value != null && value.trim().isNotEmpty) ||
                          widget.nurseDetails != null) {
                        return null;
                      } else {
                        return 'Please enter passsword';
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isObscure = !_isObscure;
                          setState(() {});
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF719BE1),
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.nurseDetails != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  buttonColor: Colors.blue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (_dob != null) {
                        if (widget.nurseDetails != null) {
                          BlocProvider.of<NurseBloc>(context).add(
                            EditNurseEvent(
                              userId: widget.nurseDetails!['user_id'],
                              name: _nameController.text.trim(),
                              phone: _phoneNumberController.text.trim(),
                              dob: _dob!,
                              email: _emailController.text.trim(),
                              password:
                                  _passwordController.text.trim().isNotEmpty
                                      ? _passwordController.text.trim()
                                      : null,
                            ),
                          );
                        } else {
                          BlocProvider.of<NurseBloc>(context).add(
                            AddNurseEvent(
                              name: _nameController.text.trim(),
                              phone: _phoneNumberController.text.trim(),
                              dob: _dob!,
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
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
