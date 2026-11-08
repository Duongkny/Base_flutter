import 'package:flutter/material.dart';

import '../widgets/auth_top_bar.dart';
import '../widgets/background.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background chung cho Authentication
          const Background(),

          // Nội dung màn hình
          Positioned.fill(
            child: child,
          ),

          // Thanh công cụ trên cùng: Nút quay lại + Chọn ngôn ngữ + Đổi theme
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AuthTopBar(),
          ),
        ],
      ),
    );
  }
}
