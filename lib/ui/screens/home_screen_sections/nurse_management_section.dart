import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_button.dart';

class NurseManagmentSection extends StatelessWidget {
  const NurseManagmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              label: 'Add Nurse',
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: const [
                  NurseCard(
                    name: 'John',
                    age: 'Age-35',
                    id: '45',
                    phoneno: '9586321458',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NurseCard(
                    name: 'Rani',
                    age: 'Age-28',
                    id: '34',
                    phoneno: '9581022558',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NurseCard(
                    name: 'Manu',
                    age: 'Age-27',
                    id: '85',
                    phoneno: '8596325458',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NurseCard(
                    name: 'Meera',
                    age: 'Age-23',
                    id: '92',
                    phoneno: '9586321415',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  NurseCard(
                    name: 'Janvi',
                    age: 'Age-22',
                    id: '98',
                    phoneno: '9859621458',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NurseCard extends StatelessWidget {
  final String name, age, id, phoneno;
  const NurseCard({
    Key? key,
    required this.name,
    required this.age,
    required this.id,
    required this.phoneno,
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
                  Text(age),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(id),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(phoneno),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomButton(
                  label: 'Edit',
                  onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  label: 'Delete',
                  onTap: () {},
                  buttonColor: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
