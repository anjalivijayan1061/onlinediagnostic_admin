import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/screens/test_details_screen.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_action_button.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/util/get_date.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaintDetails;
  const ComplaintCard({
    super.key,
    required this.complaintDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getDate(DateTime.parse(
                        complaintDetails['complaint']['created_at'])),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black38,
              ),
              Text(
                complaintDetails['complaint']['complaint'],
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Divider(
                color: Colors.black38,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'User details',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Email',
                      text: complaintDetails['complaint']['email'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone Number',
                      text: complaintDetails['complaint']['phone'],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black38,
              ),
              CustomActionButton(
                label: 'Test Details',
                iconData: Icons.arrow_outward,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TestDetailsScreen(
                        testDetails: complaintDetails['test'],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
