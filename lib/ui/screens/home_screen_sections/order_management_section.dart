import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_button.dart';

class OrderManagementSection extends StatelessWidget {
  const OrderManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: ListView(
          children: const [
            SizedBox(
              height: 5,
            ),
            OrderCard(
              name: 'John',
              age: '35',
              gender: 'Male',
              date: '1/03/2022',
              time: '8.00 Am - 10.00 Am',
              status: 'pending',
            ),
            SizedBox(
              height: 5,
            ),
            OrderCard(
              name: 'Rani',
              age: '29',
              gender: 'Female',
              date: '1/03/2022',
              time: '8.00 Am - 10.00 Am',
              status: 'pending',
            ),
            SizedBox(
              height: 5,
            ),
            OrderCard(
              name: 'Lena',
              age: '15',
              gender: 'Female',
              date: '2/03/2022',
              time: '10.00 Am - 12.00 Pm',
              status: 'pending',
            ),
            SizedBox(
              height: 5,
            ),
            OrderCard(
              name: 'Roshan',
              age: '35',
              gender: 'Male',
              date: '2/03/2022',
              time: '12.00 Pm - 4.00 Pm',
              status: 'completed',
            ),
            SizedBox(
              height: 5,
            ),
            OrderCard(
              name: 'Joseph',
              age: '65',
              gender: 'Male',
              date: '3/03/2022',
              time: '8.00 Pm - 10.00 Pm',
              status: 'sample collected',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String name, age, gender, date, time, status;
  const OrderCard({
    Key? key,
    required this.name,
    required this.age,
    required this.gender,
    required this.date,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        age,
                      ),
                      Text(gender),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(date),
                      Text(time),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(status),
                ],
              ),
            ),
            Column(
              children: [
                Wrap(
                  spacing: 10,
                  children: [
                    CustomButton(label: 'prescription', onTap: () {}),
                    CustomButton(label: 'prescription', onTap: () {}),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    CustomButton(label: 'prescription', onTap: () {}),
                    CustomButton(label: 'prescription', onTap: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
