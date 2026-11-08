# Base Flutter Project

Dự án Flutter Base chuẩn được xây dựng theo kiến trúc **Clean Architecture** kết hợp với **BLoC pattern**, **Hive CE (Local Storage)**, **Injectable & GetIt (Dependency Injection)**, hỗ trợ đa môi trường (**Development / Production**), đa ngôn ngữ (**Localization**) và hệ thống giao diện tối giản sang trọng (**Minimalist Monotone Theme**).

---

## 📋 Mục lục

1. [Yêu cầu hệ thống](#1-yêu-cầu-hệ-thống)
2. [Cài đặt dự án & Biến môi trường](#2-cài-đặt-dự-án--biến-môi-trường)
3. [Hướng dẫn cài đặt & Sử dụng Hive (Hive CE)](#3-hướng-dẫn-cài-đặt--sử-dụng-hive-hive-ce)
4. [Hướng dẫn cài đặt & Sử dụng Dependency Injection (GetIt + Injectable)](#4-hướng-dẫn-cài-đặt--sử-dụng-dependency-injection-getit--injectable)
5. [Lệnh sinh mã tự động (Build Runner)](#5-lệnh-sinh-mã-tự-động-build-runner)
6. [Hướng dẫn chạy chương trình](#6-hướng-dẫn-chạy-chương-trình)
7. [Cấu trúc thư mục dự án](#7-cấu-trúc-thư-mục-dự-án)

---

## 1. Yêu cầu hệ thống

- **Flutter SDK**: `>= 3.13.7` (khuyên dùng `3.24.x` hoặc mới hơn)
- **Dart SDK**: `>= 3.13.7 < 4.0.0`
- **IDE**: Visual Studio Code hoặc Android Studio

---

## 2. Cài đặt dự án & Biến môi trường

### Bước 1: Cài đặt packages

Mở terminal tại thư mục gốc của dự án và chạy lệnh:

```bash
flutter pub get
```

### Bước 2: Tạo file cấu hình môi trường (.env)

Dự án sử dụng `flutter_dotenv` để quản lý cấu hình theo môi trường. Hãy nhân bản từ `.env.sample`:

Tạo 2 file tại thư mục gốc:
- `.env.development`
- `.env.production`

Nội dung mẫu:

```env
API_URL=https://api-dev.yourdomain.com
IV_UTF8=your_iv_utf8_key_here
```

---

## 3. Hướng dẫn cài đặt & Sử dụng Hive (Hive CE)

Dự án sử dụng **Hive Community Edition (`hive_ce`)**, phiên bản tối ưu và hiện đại cho Flutter.

### 3.1. Các package liên quan trong `pubspec.yaml`

```yaml
dependencies:
  hive_ce: ^2.22.0
  hive_ce_flutter: ^2.5.0

dev_dependencies:
  hive_ce_generator: ^1.12.0
  build_runner: ^2.16.1
```

### 3.2. Đăng ký Adapter cho Model mới

Để lưu trữ một Model phức tạp vào Hive, bạn đăng ký Model trong file `lib/hive/hive_adapters.dart`:

```dart
import 'package:hive_ce/hive.dart';
import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<UserToken>(),
  // Thêm AdapterSpec cho Model của bạn ở đây:
  // AdapterSpec<YourModel>(),
])
void _() {}
```

Sau đó chạy lệnh sinh mã Adapter (xem [Mục 5](#5-lệnh-sinh-mã-tự-động-build-runner)).

### 3.3. Khởi tạo Hive trong ứng dụng

Hive đã được đóng gói sẵn trong `AppLocalStorage`. Tại `lib/main.dart`, Hive được khởi tạo và mở các Box cần thiết trước khi khởi chạy UI:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo Hive CE, đăng ký TypeAdapter và mở các Box
  await AppLocalStorage().initLocalStorage();
  
  runApp(const MyApp());
}
```

### 3.4. Thao tác Đọc / Ghi dữ liệu với `AppLocalStorage`

Các khóa lưu trữ được định nghĩa tập trung tại `lib/src/core/local_storage/local_storage_key.dart`.

```dart
import 'package:base_flutter/src/core/local_storage/app_local_storage.dart';
import 'package:base_flutter/src/core/local_storage/local_storage_key.dart';

// Ghi dữ liệu
AppLocalStorage.update(LocalStorageKey.themePrefs, 'dark');

// Đọc dữ liệu
final theme = AppLocalStorage.get(LocalStorageKey.themePrefs);

// Xóa dữ liệu
await AppLocalStorage.delete(LocalStorageKey.themePrefs);
```

---

## 4. Hướng dẫn cài đặt & Sử dụng Dependency Injection (GetIt + Injectable)

Dự án kết hợp **`get_it`** (Service Locator) và **`injectable`** (Code Generator tự động tạo liên kết DI).

### 4.1. Các package trong `pubspec.yaml`

```yaml
dependencies:
  get_it: ^9.3.0
  injectable: ^3.0.0

dev_dependencies:
  injectable_generator: ^3.1.3
  build_runner: ^2.16.1
```

### 4.2. Cấu hình gốc của Injectable

File cấu hình chính nằm tại `lib/src/core/injections/injections.dart`:

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injections.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}
```

### 4.3. Đăng ký Dependency mới

#### A. Đăng ký class thông thường (Repository, UseCase, DataSource, BLoC):

Sử dụng annotation `@injectable` hoặc `@lazySingleton`:

```dart
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  
  AuthRepoImpl(this._remoteDataSource);
  // ...
}

@injectable
class SignInUseCase {
  final AuthRepo _repo;
  SignInUseCase(this._repo);
  // ...
}
```

#### B. Đăng ký các thư viện bên thứ 3 (Module):

Nếu class không thể sửa code (như `Dio`, `Logger`, thư viện ngoài), đăng ký tại `lib/src/core/injections/module.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  @LazySingleton()
  Logger get logger => Logger();
  
  @lazySingleton
  Dio dio(DioClient client) => client.dio;
}
```

### 4.4. Sử dụng Dependency trong Code

Bạn có thể lấy bất kỳ instance nào đã đăng ký thông qua `getIt<T>()`:

```dart
import 'package:base_flutter/src/core/injections/injections.dart';

final authRepo = getIt<AuthRepo>();
final signInUseCase = getIt<SignInUseCase>();
```

---

## 5. Lệnh sinh mã tự động (Build Runner)

Mỗi khi bạn:
- Thêm hoặc sửa model Hive Adapter
- Thêm hoặc thay đổi `@injectable`, `@lazySingleton`, `@module`

Hãy chạy lệnh build runner để cập nhật code:

```bash
# Chạy 1 lần (Khuyên dùng)
dart run build_runner build --delete-conflicting-outputs

# Hoặc chế độ tự động theo dõi thay đổi khi lưu file (Watch mode)
dart run build_runner watch --delete-conflicting-outputs
```

---

## 6. Hướng dẫn chạy chương trình

Dự án hỗ trợ 2 môi trường thông qua cờ `--dart-define=ENV`:

### 6.1. Chạy từ Command Line

#### Môi trường Development:
```bash
flutter run --dart-define=ENV=development
```

#### Môi trường Production:
```bash
flutter run --dart-define=ENV=production
```

#### Build file APK phát hành:
```bash
flutter build apk --release --dart-define=ENV=production
```

### 6.2. Chạy từ VS Code (Run & Debug)

Dự án đã cấu hình sẵn 3 profile trong `.vscode/launch.json`:
1. Mở tab **Run & Debug** (phím tắt `Ctrl + Shift + D` trên Windows hoặc `Cmd + Shift + D` trên macOS).
2. Chọn một trong các cấu hình:
   - **`BaseFlutter Development`**: Chạy debug với môi trường Dev.
   - **`BaseFlutter Production`**: Chạy release với môi trường Prod.
   - **`BaseFlutter Debug`**: Chạy chế độ mặc định.
3. Nhấn **F5** để khởi chạy ứng dụng.

---

## 7. Cấu trúc thư mục dự án

```text
lib/
├── hive/                         # Cấu hình TypeAdapters của Hive CE
│   ├── hive_adapters.dart
│   └── hive_registrar.g.dart
├── l10n/                         # Đa ngôn ngữ (Localization)
│   ├── app_en.arb               # Tiếng Anh
│   └── app_vi.arb               # Tiếng Việt
├── src/
│   ├── constant/                # Hằng số, Theme, Biến môi trường, Endpoint
│   │   ├── app_theme.dart       # Cấu hình Minimalist Monotone Theme (Light/Dark)
│   │   └── enviroment.dart
│   ├── core/                    # Mã nguồn dùng chung toàn ứng dụng
│   │   ├── api/                 # Cấu hình Dio Client, Interceptor, Error handler
│   │   ├── app/                 # Root widget (MyApp), Providers
│   │   ├── extension/           # Context extensions, helpers
│   │   ├── injections/          # Dependency Injection (GetIt & Injectable)
│   │   ├── local_storage/       # Quản lý Hive Local Storage
│   │   ├── localization/        # BLoC chuyển đổi ngôn ngữ động
│   │   └── theme/               # BLoC chuyển đổi Theme Sáng/Tối động
│   ├── features/                # Các tính năng theo Clean Architecture
│   │   ├── auth/                # Đăng nhập, Đăng ký, Quên mật khẩu, OTP
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── home/
│   └── router/                  # Điều hướng với GoRouter
└── main.dart                    # Điểm khởi chạy chính của ứng dụng
```
