import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/nurse_management_section.dart';

class SelectNurseScreen extends StatelessWidget {
  const SelectNurseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[700],
        centerTitle: true,
        title: Text(
          'Select Nurse',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
        elevation: 1,
      ),
      body: NurseManagmentSection(
        onSelect: (nurse) {
          Navigator.pop(context, nurse);
        },
      ),
    );
  }
}
