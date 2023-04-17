import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_card.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';
import 'package:onlinediagnostic_admin/util/get_date.dart';

class SuggestionCard extends StatelessWidget {
  final Map<String, dynamic> suggestionDetails;
  const SuggestionCard({
    super.key,
    required this.suggestionDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: CustomCard(
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
                    getDate(DateTime.parse(suggestionDetails['created_at'])),
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
                suggestionDetails['suggestion'],
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
                      text: suggestionDetails['suggestion']['email'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone Number',
                      text: suggestionDetails['suggestion']['phone'],
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
