

import 'package:flutter/material.dart';

class TabTile extends StatelessWidget {
  final String title;
  const TabTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(icon: Text(title));
  }
}