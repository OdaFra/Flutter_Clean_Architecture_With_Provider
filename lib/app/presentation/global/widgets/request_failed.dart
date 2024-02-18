import 'package:flutter/material.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({super.key, required this.onRetry, this.text});
  final VoidCallback onRetry;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text ?? 'Request Failed'),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blue,
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}
