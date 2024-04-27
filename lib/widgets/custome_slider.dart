// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider({
    required this.value,
    required this.onChanged,
    super.key,
  });

  double value;
  void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      max: 0.9,
      divisions: 9,
      label: value.toStringAsFixed(1),
      onChanged: onChanged,
    );
  }
}
