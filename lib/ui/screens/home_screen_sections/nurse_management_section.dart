import 'package:flutter/material.dart';

class NurseManagmentSection extends StatelessWidget {
  const NurseManagmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: ListView(
          children: [
            NurseCard(
              Name: 'John',
              age: 'Age-35',
              id: '45',
              phoneno: '9586321458',
            ),
            NurseCard(
              Name: 'Rani',
              age: 'Age-28',
              id: '34',
              phoneno: '9581022558',
            ),
            NurseCard(
              Name: 'Manu',
              age: 'Age-27',
              id: '85',
              phoneno: '8596325458',
            ),
            NurseCard(
              Name: 'Meera',
              age: 'Age-23',
              id: '92',
              phoneno: '9586321415',
            ),
            NurseCard(
              Name: 'Janvi',
              age: 'Age-22',
              id: '98',
              phoneno: '9859621458',
            ),
          ],
        ),
      ),
    );
  }
}

class NurseCard extends StatelessWidget {
  final String Name, age, id, phoneno;
  const NurseCard({
    Key? key,
    required this.Name,
    required this.age,
    required this.id,
    required this.phoneno,
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
                        Name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  Text(age),
                  Text(id),
                  Text(phoneno),
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
