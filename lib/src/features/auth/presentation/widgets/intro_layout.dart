import 'package:flutter/material.dart';

import 'background.dart';

class IntroLayout extends StatelessWidget {
  const IntroLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background dùng chung của HomeLove
          const Background(),

          // Nội dung màn hình
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}