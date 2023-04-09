import 'package:flutter/material.dart';

class PatientComplaintsScreen extends StatefulWidget {
  const PatientComplaintsScreen({super.key});

  @override
  State<PatientComplaintsScreen> createState() =>
      _PatientComplaintsScreenState();
}

class _PatientComplaintsScreenState extends State<PatientComplaintsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          children: const [Text('Patient Complaints')],
        ),
      ),
    );
  }
}
