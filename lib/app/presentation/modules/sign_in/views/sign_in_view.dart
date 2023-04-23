import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      setState(() {
                        _username = value.trim().toLowerCase();
                      });
                    },
                    validator: (value) {
                      value = value?.trim().toLowerCase();
                      if (value!.isEmpty) {
                        return 'Invalid username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'username'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      setState(() {
                        _password = value.replaceAll(' ', '').toLowerCase();
                      });
                    },
                    validator: (value) {
                      value = value?.replaceAll(' ', '').toLowerCase();
                      if (value!.length < 4) {
                        return 'Invalid password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'password'),
                  ),
                  const SizedBox(height: 20),
                  Builder(builder: (context) {
                    return MaterialButton(
                      onPressed: () {
                        final isValid = Form.of(context).validate();
                        if (isValid) {}
                      },
                      color: Colors.indigo,
                      child: const Text('Sign In'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
