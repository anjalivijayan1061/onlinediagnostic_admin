import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/widgets/label_with_text.dart';

class TestDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> testDetails;
  const TestDetailsScreen({super.key, required this.testDetails});

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Test Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0xFF719BE1),
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Material(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: LabelWithText(
                              label: 'Id',
                              text: '#${widget.testDetails['id'].toString()}',
                            ),
                          ),
                          Expanded(
                            child: LabelWithText(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              label: 'Test Name',
                              text: widget.testDetails['name'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: LabelWithText(
                              label: 'Price',
                              text:
                                  '₹ ${widget.testDetails['price'].toString()}',
                            ),
                          ),
                          Expanded(
                            child: LabelWithText(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              label: 'Duration',
                              text:
                                  '${widget.testDetails['duration'].toString()} Hour',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LabelWithText(
                        label: 'Sample Type',
                        text: widget.testDetails['sample_type'],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Can collect sample from home : ',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                            children: [
                              TextSpan(
                                text: widget.testDetails['sample_from_home']
                                    ? 'Yes'
                                    : 'No',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color:
                                          widget.testDetails['sample_from_home']
                                              ? Colors.green[700]
                                              : Colors.red[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
