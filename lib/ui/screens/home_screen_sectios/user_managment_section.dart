import 'package:flutter/material.dart';

class UserManagmentSection extends StatelessWidget {
  const UserManagmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
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
                test: 'Test 1 TSH \nTest 2 Cholostrol \nTest 3 Glucose'),
          ],
        ),
      ),
    );
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
