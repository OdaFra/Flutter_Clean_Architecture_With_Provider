import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../router/router.dart';
import '../../controllers/signIn_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SigInController>(context);
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
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
  }

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<SigInController>();

    final result = await controller.submit();

    if (!controller.mounted) {
      return;
    }
    result.when(
      left: (failure) {
        final message = failure.when(
          notFound: () => 'Not Found',
          network: () => 'Network error',
          notVerified: () => 'Email not verified',
          unauthorized: () => 'Invalid password',
          unkonwn: () => 'Internal error',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
      right: (_) => Navigator.pushReplacementNamed(
        context,
        Routes.home,
      ),
    );
  }
}
