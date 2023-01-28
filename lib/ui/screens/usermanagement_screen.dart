import 'package:flutter/material.dart';

class UsermanagementScreen extends StatelessWidget {
  const UsermanagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            height: double.infinity,
            child: Column(
              children: [
                Icon(
                  Icons.ac_unit,
                  size: 100,
                  color: Colors.white,
                ),
                Text(
                  'Online Diagnostic',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 100,
                ),
                Text('User Management'),
                Text('Test Management'),
                Text('Order Management'),
                Text('Nurse Management'),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Material(
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Text("User Management"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    MemberCard(
                      title: 'john',
                      age: '35',
                      address: 'K.V House Ozhakrome,p.o morazha',
                      test: 'Haemoglobin',
                    ),
                    MemberCard(
                        title: 'Rani',
                        age: '29',
                        address: 'Rani Villas Kanul,p.o.Morazha ',
                        test: ' Test 1 Blood Pressure,Test 2 Cholestrol'),
                    MemberCard(
                        title: 'Lena',
                        age: '15',
                        address: 'Kunnul House Vellikeel,p.o.cherukunnu',
                        test: 'Test 1 Blood Count'),
                    MemberCard(
                        title: 'Roshan',
                        age: '24',
                        address: 'Roshni Vilas Keecheri p.o.keecheri',
                        test: 'Test 1 Glucose'),
                    MemberCard(
                        title: 'Joseph',
                        age: '65',
                        address: 'Kalyani Vilas Kuthuparamb p.o.kuthuparamb',
                        test:
                            'Test 1 TSH \nTest 2 Cholostrol \nTest 3 Glucose'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class MemberCard extends StatelessWidget {
  final String title, age, address, test;
  const MemberCard({
    Key? key,
    required this.title,
    required this.age,
    required this.address,
    required this.test,
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
                        title,
                      ),
                    ],
                  ),
                  Text(age),
                  Text(address),
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
