import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.arrow_circle_right_rounded),
            Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(hintText: "Email"),
                )),
            SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(hintText: "Password"),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text('Forgot Password ?  '),
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[400],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text('            or login with   '),
                Row(
                  children: [
                    Icon(Icons.circle),
                    Text('google'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle),
                    Text('facebook'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
