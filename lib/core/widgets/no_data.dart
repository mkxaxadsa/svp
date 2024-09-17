import 'package:flutter/material.dart';

import 'texts/text_r.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    this.expanded = false,
  });

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return expanded
        ? const Expanded(
            child: Center(
              child: TextR(
                'No data',
                fontSize: 14,
              ),
            ),
          )
        : const Center(
            child: TextR(
              'No data',
              fontSize: 14,
            ),
          );
  }
}
