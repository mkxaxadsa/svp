import 'package:flutter/material.dart';

import '../../../core/widgets/texts/text_r.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextR(
          'Settings',
          fontSize: 16,
        ),
      ],
    );
  }
}
