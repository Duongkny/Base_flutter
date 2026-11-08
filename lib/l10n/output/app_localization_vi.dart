// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'BaseFlutter';

  @override
  String get getStartedTitle => 'Chào mừng đến với HomeLove';

  @override
  String get getStartedDescription =>
      'Nơi lưu giữ những khoảnh khắc yêu thương';

  @override
  String get appDescription => 'Cùng nhau lưu giữ\nnhững khoảnh khắc đẹp nhất';

  @override
  String get getStartedButton => 'Bắt đầu';

  @override
  String get getStartedSignIn => 'Đã có tài khoản? Đăng nhập';

  @override
  String get onboardingMemoryTitle => 'Lưu giữ khoảnh khắc';

  @override
  String get onboardingMemoryDescription =>
      'Ghi lại những kỷ niệm đáng nhớ trong hành trình của hai bạn';

  @override
  String get onboardingHabitsTitle => 'Cùng nhau tạo những thói quen tốt';

  @override
  String get onboardingHabitsDescription =>
      'Nhắc nhở, lên kế hoạch và trải nghiệm nhiều điều ý nghĩa hơn mỗi ngày';

  @override
  String get onboardingConnectionTitle => 'Kết nối sâu hơn';

  @override
  String get onboardingConnectionDescription =>
      'Chia sẻ cảm xúc, hiểu nhau hơn và cùng xây dựng hành trình riêng';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get signInTitle => 'Chào mừng bạn quay trở lại';

  @override
  String get signInWithGoogle => 'Đăng nhập với Google';

  @override
  String get dontHaveAccount => 'Chưa có tài khoản?';

  @override
  String get signUpNow => 'Đăng ký ngay';

  @override
  String get signUp => 'Đăng ký';

  @override
  String get signUpTitle => 'Tạo tài khoản HomeLove';

  @override
  String get startLoveJourney => 'Bắt đầu hành trình yêu thương của bạn';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản?';

  @override
  String get signInNow => 'Đăng nhập ngay';

  @override
  String get agreeWith => 'Tôi đồng ý với ';

  @override
  String get termsAndPrivacyPolicy => 'Điều khoản và Chính sách bảo mật';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Nhập email của bạn';

  @override
  String get password => 'Mật khẩu';

  @override
  String get passwordHint => 'Nhập mật khẩu';

  @override
  String get confirmPassword => 'Xác nhận mật khẩu';

  @override
  String get confirmPasswordHint => 'Nhập lại mật khẩu';

  @override
  String get or => 'hoặc';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get forgotPasswordTitle => 'Khôi phục mật khẩu';

  @override
  String get forgotPasswordDescription =>
      'Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu';

  @override
  String get sendResetLink => 'Gửi liên kết đặt lại mật khẩu';

  @override
  String get backToSignIn => 'Quay lại đăng nhập';

  @override
  String get resetEmailSent =>
      'Hướng dẫn đặt lại mật khẩu đã được gửi nếu email tồn tại trong hệ thống';

  @override
  String get otpTitle => 'Nhập mã xác thực';

  @override
  String get otpDescription => 'Chúng tôi đã gửi mã 6 số đến email của bạn.';

  @override
  String get otpNotReceived => 'Không nhận được mã?';

  @override
  String get verifyOtp => 'Xác nhận';

  @override
  String get resendOtp => 'Gửi lại mã';

  @override
  String get otpExpireMessage => 'Gửi lại mã';

  @override
  String theCodeWill(String time) {
    return 'Gửi lại sau $time';
  }

  @override
  String get otpInvalid => 'Mã xác thực không hợp lệ';

  @override
  String get otpExpired => 'Mã xác thực đã hết hạn';

  @override
  String get otpVerifySuccess => 'Xác thực thành công';

  @override
  String get otpResendSuccess => 'Đã gửi mã xác thực mới';

  @override
  String get invalidOtpLength => 'Mã OTP phải gồm đúng 6 chữ số';

  @override
  String get otpResending => 'Đang gửi lại...';

  @override
  String get invalidNumber => 'Vui lòng nhập số hợp lệ';

  @override
  String get profileInformation => 'Thông tin cá nhân';

  @override
  String get profileInformationDescription =>
      'Hãy cho chúng mình biết thêm về bạn';

  @override
  String get fullName => 'Họ và tên';

  @override
  String get fullNameHint => 'Nhập họ và tên';

  @override
  String get dateOfBirth => 'Ngày sinh';

  @override
  String get dateOfBirthHint => 'Chọn ngày sinh';

  @override
  String get gender => 'Giới tính';

  @override
  String get male => 'Nam';

  @override
  String get female => 'Nữ';

  @override
  String get other => 'Khác';

  @override
  String get nickname => 'Biệt danh';

  @override
  String get nicknameHint => 'Nhập biệt danh';

  @override
  String get address => 'Địa chỉ';

  @override
  String get addressHint => 'Nhập địa chỉ';

  @override
  String get phoneNumber => 'Số điện thoại';

  @override
  String get phoneNumberHint => 'Nhập số điện thoại';

  @override
  String get avatar => 'Ảnh đại diện';

  @override
  String get chooseAvatar => 'Chọn ảnh đại diện';

  @override
  String get avatarTooLarge => 'Ảnh đại diện không được vượt quá 5 MB';

  @override
  String get next => 'Tiếp tục';

  @override
  String get back => 'Quay lại';

  @override
  String get complete => 'Hoàn thành';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Hủy';

  @override
  String get loading => 'Đang xử lý...';

  @override
  String get requiredField => 'Vui lòng nhập thông tin này';

  @override
  String get invalidEmail => 'Email không hợp lệ';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 8 ký tự';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu xác nhận không khớp';

  @override
  String get invalidPhoneNumber => 'Số điện thoại không hợp lệ';

  @override
  String get termsRequired => 'Vui lòng đồng ý với điều khoản sử dụng';

  @override
  String get signInSuccess => 'Đăng nhập thành công';

  @override
  String get signUpSuccess => 'Đăng ký thành công';

  @override
  String get profileUpdateSuccess => 'Cập nhật thông tin thành công';

  @override
  String get somethingWentWrong => 'Đã xảy ra lỗi. Vui lòng thử lại';

  @override
  String get featureUnderDevelopment => 'Chức năng đang được phát triển';

  @override
  String get resetPasswordTitle => 'Đặt lại mật khẩu';

  @override
  String get resetPasswordDescription =>
      'Nhập mật khẩu mới cho tài khoản của bạn';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get newPasswordHint => 'Nhập mật khẩu mới (tối thiểu 8 ký tự)';

  @override
  String get resetPasswordButton => 'Cập nhật mật khẩu';

  @override
  String get resetPasswordSuccess =>
      'Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.';
}
