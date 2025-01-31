import 'package:flutter/material.dart';

import '../atoms/responsive_padding.dart';
import '../tokens/tokens.dart';

class MainTemplate extends StatelessWidget {
  const MainTemplate(
      {super.key,
      required this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation});
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: ResponsivePadding(
          mobilePadding:
              EdgeInsets.symmetric(horizontal: Spacing.SPACE_RESPONSIVE_XS),
          webPadding:
              EdgeInsets.symmetric(horizontal: Spacing.SPACE_RESPONSIVE_XL),
          child: body),
    );
  }
}
