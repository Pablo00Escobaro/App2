import 'package:flutter/material.dart';

class OptionsLoadingWidget extends StatelessWidget {
  const OptionsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
