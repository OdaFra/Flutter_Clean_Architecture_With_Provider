import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/failures/sign_in_failure.dart';
import '../../../../global/controllers/session_controller.dart';
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
      (failure) {
        final message = () {
          if (failure is Network) {
            return 'Network error';
          }
          if (failure is NotFound) {
            return 'Not Found';
          }
          if (failure is Unauthorized) {
            return 'Invalid password';
          }
          return 'Error';
        }();
        // final message = {
        //   SignInFailure.notFound: 'Not Found',
        //   SignInFailure.unauthorized: 'Invalid password',
        //   SignInFailure.unknown: 'Internal error',
        //   SignInFailure.network: 'Network error'
        // }[failure];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
      (user) {
        final sessionController = context.read<SessionController>();
        sessionController.setUser(user!);
        Navigator.pushReplacementNamed(
          context,
          Routes.home,
        );
      },
    );
  }
}
