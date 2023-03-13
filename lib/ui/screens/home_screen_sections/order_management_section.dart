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
          children: [
            OrderCard(
              name: 'John',
              age: '35',
              gender: 'Male',
              date: '1/03/2022',
              time: '8.00 Am - 10.00 Am',
              status: 'pending',
            ),
            OrderCard(
              name: 'Rani',
              age: '29',
              gender: 'Female',
              date: '1/03/2022',
              time: '8.00 Am - 10.00 Am',
              status: 'pending',
            ),
            OrderCard(
              name: 'Lena',
              age: '15',
              gender: 'Female',
              date: '2/03/2022',
              time: '10.00 Am - 12.00 Pm',
              status: 'pending',
            ),
            OrderCard(
              name: 'Roshan',
              age: '35',
              gender: 'Male',
              date: '2/03/2022',
              time: '12.00 Pm - 4.00 Pm',
              status: 'completed',
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
    return Padding(
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
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        age,
                      ),
                      Text(gender),
                    ],
                  ),
                  Row(
                    children: [
                      Text(date),
                      Text(time),
                    ],
                  ),
                  Text(status),
                ],
              ),
              Wrap(
                children: [
                  CustomButton(label: 'prescription', onTap: () {}),
                  CustomButton(label: 'prescription', onTap: () {}),
                  CustomButton(label: 'prescription', onTap: () {}),
                  CustomButton(label: 'prescription', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
