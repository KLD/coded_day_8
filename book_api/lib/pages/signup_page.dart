import 'package:book_api/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-up"),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(hintText: "Username"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required field";
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required field";
                }

                return null;
              },
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Confirm Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required field";
                }

                if (passwordController.text != value) {
                  return "Password doesn't match";
                }

                return null;
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var didSignup = await context.read<AuthProvider>().signup(
                      username: usernameController.text,
                      password: passwordController.text);
                  if (didSignup) {
                    context.go("/list");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Sign up not successful")));
                  }
                } else {
                  print("form not valid");
                }
              },
              child: Text("Signup"),
            ),
          ]),
        ),
      ),
    );
  }
}
