import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/manage_test/manage_test_bloc.dart';
import 'package:onlinediagnostic_admin/ui/widgets/option_selector.dart';

import '../custom_button.dart';
import '../custom_card.dart';

class AddEditTestDialog extends StatefulWidget {
  final Map<String, dynamic>? testDetails;
  const AddEditTestDialog({
    super.key,
    this.testDetails,
  });

  @override
  State<AddEditTestDialog> createState() => _AddEditTestDialogState();
}

class _AddEditTestDialogState extends State<AddEditTestDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sampleTypeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  bool _sampleFromHome = false;

  @override
  void initState() {
    if (widget.testDetails != null) {
      _nameController.text = widget.testDetails!['name'];
      _priceController.text = widget.testDetails!['price'].toString();
      _sampleTypeController.text = widget.testDetails!['sample_type'];
      _durationController.text = widget.testDetails!['duration'].toString();
      _sampleFromHome = widget.testDetails!['sample_from_home'];
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
                            widget.testDetails != null
                                ? "Edit Test"
                                : "Add Test",
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
                            widget.testDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a test.",
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
                  'Test Name',
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
                        return 'Please enter test name';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg. Blood Test',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Duration (in hours)',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _durationController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter duration';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.12',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Sample Type',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _sampleTypeController,
                    validator: (value) {
                      if ((value != null && value.trim().isNotEmpty) ||
                          widget.testDetails != null) {
                        return null;
                      } else {
                        return 'Please enter sample type';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.Blood',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Price',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _priceController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter a price';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg.100',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Can collect sample from home ?',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                OptionSelector(
                  selected: _sampleFromHome,
                  onSelect: (value) {
                    _sampleFromHome = value;
                  },
                ),
                const SizedBox(height: 20),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.testDetails != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  buttonColor: Colors.blue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.testDetails != null) {
                        BlocProvider.of<ManageTestBloc>(context).add(
                          EditTestEvent(
                            testId: widget.testDetails!['id'],
                            name: _nameController.text.trim(),
                            duration: double.parse(
                                _durationController.text.trim().toString()),
                            price: int.parse(
                                _priceController.text.trim().toString()),
                            sampleFromHome: _sampleFromHome,
                            sampleType: _sampleTypeController.text.trim(),
                          ),
                        );
                      } else {
                        BlocProvider.of<ManageTestBloc>(context).add(
                          AddTestEvent(
                            name: _nameController.text.trim(),
                            duration: double.parse(
                                _durationController.text.trim().toString()),
                            price: int.parse(
                                _priceController.text.trim().toString()),
                            sampleFromHome: _sampleFromHome,
                            sampleType: _sampleTypeController.text.trim(),
                          ),
                        );
                      }

                      Navigator.pop(context);
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
