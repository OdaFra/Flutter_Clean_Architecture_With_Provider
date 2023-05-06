import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../core/enums/enum.dart';
import '../../../router/router.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';

  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: AbsorbPointer(
                absorbing: _fetching,
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
                      if (_fetching) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return MaterialButton(
                        onPressed: () {
                          final isValid = Form.of(context).validate();
                          if (isValid) {
                            _submit(context);
                          }
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
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });
    final result = await Injector.of(context).authenticationRepository.signIn(
          _username,
          _password,
        );
    if (!mounted) {
      return;
    }
    result.when(
      (failure) {
        setState(() {
          _fetching = false;
        });
        final message = {
          SignInFailure.notFound: 'Not Found',
          SignInFailure.unauthorized: 'Invalid password',
          SignInFailure.unknown: 'Internal error',
          SignInFailure.network: 'Network error'
        }[failure];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!),
          ),
        );
      },
      (user) {
        Navigator.pushReplacementNamed(
          context,
          Routes.home,
        );
      },
    );
  }
}
