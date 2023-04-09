import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/dashcard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomActionButton(
                  mainAxisSize: MainAxisSize.min,
                  label: 'Reload',
                  onPressed: () {},
                  iconData: Icons.refresh_outlined,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                DashCard(
                  iconData: Icons.receipt_outlined,
                  label: 'Total Orders Today',
                  value: '340',
                ),
                DashCard(
                  iconData: Icons.local_hospital_outlined,
                  label: 'Total Nurses',
                  value: '26',
                ),
                DashCard(
                  iconData: Icons.text_snippet_outlined,
                  label: 'Total Tests',
                  value: '12',
                ),
                DashCard(
                  iconData: Icons.sick_outlined,
                  label: 'Total Patients',
                  value: '16',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
