import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/local_storage/local_storage_key.dart';
import 'package:base_flutter/src/router/route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ==========================================
  // 1. HỘP THOẠI XÁC NHẬN ĐĂNG XUẤT
  // ==========================================
  Future<void> _showLogoutDialog(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );

    // Nếu người dùng chọn "Đăng xuất"
    if (confirm == true && context.mounted) {
      await _performLogout(context);
    }
  }

  // ==========================================
  // 2. LOGIC THỰC HIỆN XÓA TOKEN & CHUYỂN TRANG
  // ==========================================
  Future<void> _performLogout(BuildContext context) async {
    try {
      final box = Hive.isBoxOpen(LocalStorageKey.token)
          ? Hive.box(LocalStorageKey.token)
          : await Hive.openBox(LocalStorageKey.token);
      
      // Xóa toàn bộ token & trạng thái phiên trong Hive
      await box.clear();

      if (!context.mounted) return;

      // Điều hướng về màn hình Đăng nhập
      AppRoute.signIn.go(context);
    } catch (e) {
      debugPrint('Lỗi xoá token khi đăng xuất: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text(context.loc.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Đăng xuất',
            // 👇 Bây giờ onPressed cực kỳ gọn gàng!
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90.r,
                height: 90.r,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  size: 48.r,
                  color: colors.primary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Chào mừng bạn đến với ${context.loc.appName}!',
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Hồ sơ của bạn đã được cập nhật thành công.\nSẵn sàng cho các tính năng ghép đôi tiếp theo!',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}