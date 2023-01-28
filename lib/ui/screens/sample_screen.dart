import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            height: double.infinity,
            width: 400,
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
                Text('User Management'),
                Text('Test Management'),
                Text('Order Management'),
                Text('Nurse Management'),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SampleCard(title: 'John'),
              SampleCard(title: 'Tiya'),
              SampleCard(title: 'Leena'),
              SampleCard(title: 'Lena')
            ],
          ),
        ],
      ),
    );
  }
}

class SampleCard extends StatelessWidget {
  final String title;

  const SampleCard({
    Key? key,
    required this.title,
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
                children: [
                  Row(
                    children: [
                      Text(title),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(title),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title),
                          ),
                        ],
                      ),
                    ],
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
