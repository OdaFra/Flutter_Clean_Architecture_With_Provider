import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/signIn_controller.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

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
                    absorbing: controller.state.fetching,
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
                        const SubmitButton()
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
}
