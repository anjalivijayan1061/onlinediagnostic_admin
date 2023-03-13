import 'package:flutter/material.dart';

class TestManagementSection extends StatelessWidget {
  const TestManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: ListView(
          children: [
            TestCard(
              id: '#id',
              testname: 'Testname',
              sample: 'Sample:',
              cancollectedfrom: 'Can Collected From Home: Yes /No',
              testduration: 'Test Duration :',
              amount: "Amount",
            ),
            TestCard(
              id: '#id',
              testname: 'Testname',
              sample: 'Sample:',
              cancollectedfrom: 'Can Collected From Home: Yes /No',
              testduration: 'Test Duration :',
              amount: "Amount",
            ),
            TestCard(
              id: '#id',
              testname: 'Testname',
              sample: 'Sample:',
              cancollectedfrom: 'Can Collected From Home: Yes /No',
              testduration: 'Test Duration :',
              amount: "Amount",
            ),
            TestCard(
              id: '#id',
              testname: 'Testname',
              sample: 'Sample:',
              cancollectedfrom: 'Can Collected From Home: Yes /No',
              testduration: 'Test Duration :',
              amount: "Amount",
            ),
            TestCard(
              id: '#id',
              testname: 'Testname',
              sample: 'Sample:',
              cancollectedfrom: 'Can Collected From Home: Yes /No',
              testduration: 'Test Duration :',
              amount: "Amount",
            ),
          ],
        ),
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  final String id, testname, sample, cancollectedfrom, testduration, amount;
  const TestCard({
    Key? key,
    required this.id,
    required this.testname,
    required this.sample,
    required this.cancollectedfrom,
    required this.testduration,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black26,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        id,
                      ),
                    ],
                  ),
                  Text(
                    testname,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(sample),
                  Text(cancollectedfrom),
                  Text(testduration),
                  Wrap(
                    children: [],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
