import 'package:flutter/material.dart';

Future<T> showLoader<T>(BuildContext context, Future<T> future) async {
  final overlayState = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (_) => Container(
      color: Colors.black54,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey.shade400,
        ),
      ),
    ),
  );
  overlayState.insert(entry);

  await Future.delayed(const Duration(milliseconds: 600));

  final result = await future;
  entry.remove();
  return result;
}
