// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:neighbour_app/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchFunction {
  Future<void> openLink({
    required String link,
    required BuildContext context,
  }) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url)) {
      snackBarComponent(
        context,
        color: Colors.red,
        message: 'Could not launch $url',
      );
    }
  }
}
