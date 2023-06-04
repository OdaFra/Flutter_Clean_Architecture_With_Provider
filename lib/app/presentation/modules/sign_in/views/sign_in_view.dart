import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/enum.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../router/router.dart';
import '../controllers/signIn_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SigInController>(
      create: (context) => SigInController(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Builder(builder: (context) {
                  final controller =
                      Provider.of<SigInController>(context, listen: true);
                  return AbsorbPointer(
                    absorbing: controller.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) =>
                              controller.onUsernameChanged(value),
                          validator: (value) {
                            value = value?.trim().toLowerCase();
                            if (value!.isEmpty) {
                              return 'Invalid username';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'username'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) =>
                              controller.onPasswordChanged(value),
                          validator: (value) {
                            value = value?.replaceAll(' ', '') ?? '';
                            if (value.length < 4) {
                              return 'Invalid password';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'password'),
                        ),
                        const SizedBox(height: 20),
                        if (controller.fetching)
                          const CircularProgressIndicator()
                        else
                          MaterialButton(
                            onPressed: () {
                              final isValid = Form.of(context).validate();
                              if (isValid) {
                                _submit(context);
                              }
                            },
                            color: Colors.indigo,
                            child: const Text('Sign In'),
                          )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<SigInController>();

    controller.onFetchingChanged(true);

    final result = await context.read<AuthenticationRepository>().signIn(
          controller.username,
          controller.password,
        );
    if (!mounted) {
      return;
    }
    result.when(
      (failure) {
        controller.onFetchingChanged(false);
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
