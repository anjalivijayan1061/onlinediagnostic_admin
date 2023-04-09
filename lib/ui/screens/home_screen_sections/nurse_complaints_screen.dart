import 'package:flutter/material.dart';

class NurseComplaintsScreen extends StatefulWidget {
  const NurseComplaintsScreen({super.key});

  @override
  State<NurseComplaintsScreen> createState() => _NurseComplaintsScreenState();
}

class _NurseComplaintsScreenState extends State<NurseComplaintsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          children: const [Text('Complaints')],
        ),
      ),
    );
  }
}
