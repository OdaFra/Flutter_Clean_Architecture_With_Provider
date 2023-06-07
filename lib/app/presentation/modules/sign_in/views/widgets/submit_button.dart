import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/enums/enum.dart';
import '../../../../../domain/repositories/repositories.dart';
import '../../../../router/router.dart';
import '../../controllers/signIn_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SigInController>(context);
    if (controller.fetching) {
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

    controller.onFetchingChanged(true);

    final result = await context.read<AuthenticationRepository>().signIn(
          controller.username,
          controller.password,
        );
    if (!controller.mounted) {
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
