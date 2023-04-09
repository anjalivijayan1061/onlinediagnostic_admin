import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_admin/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(),
              child: BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text("Login Failed"),
                        content: Text(
                          'Please check your email and password and try again.',
                        ),
                      ),
                    );
                  } else if (state is SignInSuccessState) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Branding(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 0,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Enter email and password to login',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter an email";
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isObscure,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter password";
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                isObscure = !isObscure;
                                setState(() {});
                              },
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF719BE1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonColor: Colors.blueAccent.withOpacity(0.6),
                          labelColor: Colors.white,
                          elevation: 5,
                          label: 'Login',
                          isLoading: state is SignInLoadingState,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();

                              BlocProvider.of<SignInBloc>(context).add(
                                SignInEvent(
                                  email: email,
                                  password: password,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Branding extends StatelessWidget {
  const Branding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.biotech,
          color: Colors.black87,
          size: 50,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Online Diagnostics',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
