import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/media/media.dart';
import '../global/controllers/favorite/favorite_controller.dart';
import '../global/dialogs/show_loader.dart';

Future<void> markAsFavorite({
  required BuildContext context,
  required Media media,
  required bool Function() mounted,
}) async {
  final favoriteController = context.read<FavoriteController>();
  final result =
      await showLoader(context, favoriteController.markAsFavorite(media));
  // final result = await favoriteController.markAsFavorite(media);

  if (!mounted()) {
    return;
  }

  result.whenOrNull(left: (failure) {
    final errorMessage = failure.when(
      notFound: () => 'Resource not found',
      network: () => 'Network error',
      unauthorized: () => 'Unauthorized',
      unknowm: () => 'Unknown error',
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
    ));
  });
}
