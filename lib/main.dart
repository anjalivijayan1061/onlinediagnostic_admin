import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nqgmuqmfbhqqbavijyzq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xZ211cW1mYmhxcWJhdmlqeXpxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODA3OTc3MSwiZXhwIjoxOTkzNjU1NzcxfQ.NtTvGsbaD3ZonuktBauJaxkb9ci5Xu3nj44e1MtzwWE',
  );

  dynamic schema = await Supabase.instance.client.rpc(
    'get_table_info',
    params: {
      'schema_name': 'public',
    },
  );

  print(schema.toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
              ),
            ),
      ),
      home: const LoginScreen(),
    );
  }
}
