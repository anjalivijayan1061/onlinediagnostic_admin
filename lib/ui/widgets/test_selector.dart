import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/manage_test/manage_test_bloc.dart';

import 'custom_alert_dialog.dart';
import 'custom_card.dart';

class TestSelector extends StatefulWidget {
  final Function(Map<String, dynamic>) onSelect;
  final int selectedTest;
  const TestSelector({
    super.key,
    required this.onSelect,
    this.selectedTest = 0,
  });

  @override
  State<TestSelector> createState() => _TestSelectorState();
}

class _TestSelectorState extends State<TestSelector> {
  final ManageTestBloc manageTestBloc = ManageTestBloc();

  @override
  void initState() {
    manageTestBloc.add(GetAllTestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<ManageTestBloc>.value(
        value: manageTestBloc,
        child: BlocConsumer<ManageTestBloc, ManageTestState>(
          listener: (context, state) {
            if (state is ManageTestFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    manageTestBloc.add(GetAllTestEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ManageTestSuccessState) {
              return DropdownMenu(
                hintText: 'All Tests',
                initialSelection: widget.selectedTest,
                onSelected: (value) {
                  widget.onSelect(value);
                },
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownMenuEntries: [
                  const DropdownMenuEntry(
                    value: 0,
                    label: 'All Tests',
                  ),
                  ...List<DropdownMenuEntry>.generate(
                    state.tests.length,
                    (index) => DropdownMenuEntry(
                      value: state.tests[index],
                      label: state.tests[index]['name'],
                    ),
                  ),
                ],
              );
            } else if (state is ManageTestFailureState) {
              return const SizedBox();
            } else {
              return const SizedBox(
                width: 100,
                child: SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
