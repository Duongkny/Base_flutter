import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_en.dart';
import 'app_localization_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'output/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'BaseFlutter'**
  String get appName;

  /// No description provided for @getStartedTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng đến với HomeLove'**
  String get getStartedTitle;

  /// No description provided for @getStartedDescription.
  ///
  /// In vi, this message translates to:
  /// **'Nơi lưu giữ những khoảnh khắc yêu thương'**
  String get getStartedDescription;

  /// No description provided for @appDescription.
  ///
  /// In vi, this message translates to:
  /// **'Cùng nhau lưu giữ\nnhững khoảnh khắc đẹp nhất'**
  String get appDescription;

  /// No description provided for @getStartedButton.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get getStartedButton;

  /// No description provided for @getStartedSignIn.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản? Đăng nhập'**
  String get getStartedSignIn;

  /// No description provided for @onboardingMemoryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lưu giữ khoảnh khắc'**
  String get onboardingMemoryTitle;

  /// No description provided for @onboardingMemoryDescription.
  ///
  /// In vi, this message translates to:
  /// **'Ghi lại những kỷ niệm đáng nhớ trong hành trình của hai bạn'**
  String get onboardingMemoryDescription;

  /// No description provided for @onboardingHabitsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cùng nhau tạo những thói quen tốt'**
  String get onboardingHabitsTitle;

  /// No description provided for @onboardingHabitsDescription.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc nhở, lên kế hoạch và trải nghiệm nhiều điều ý nghĩa hơn mỗi ngày'**
  String get onboardingHabitsDescription;

  /// No description provided for @onboardingConnectionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kết nối sâu hơn'**
  String get onboardingConnectionTitle;

  /// No description provided for @onboardingConnectionDescription.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ cảm xúc, hiểu nhau hơn và cùng xây dựng hành trình riêng'**
  String get onboardingConnectionDescription;

  /// No description provided for @skip.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get skip;

  /// No description provided for @createAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản'**
  String get createAccount;

  /// No description provided for @signIn.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get signIn;

  /// No description provided for @signInTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng bạn quay trở lại'**
  String get signInTitle;

  /// No description provided for @signInWithGoogle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập với Google'**
  String get signInWithGoogle;

  /// No description provided for @dontHaveAccount.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản?'**
  String get dontHaveAccount;

  /// No description provided for @signUpNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký ngay'**
  String get signUpNow;

  /// No description provided for @signUp.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get signUp;

  /// No description provided for @signUpTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản HomeLove'**
  String get signUpTitle;

  /// No description provided for @startLoveJourney.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu hành trình yêu thương của bạn'**
  String get startLoveJourney;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản?'**
  String get alreadyHaveAccount;

  /// No description provided for @signInNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập ngay'**
  String get signInNow;

  /// No description provided for @agreeWith.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đồng ý với '**
  String get agreeWith;

  /// No description provided for @termsAndPrivacyPolicy.
  ///
  /// In vi, this message translates to:
  /// **'Điều khoản và Chính sách bảo mật'**
  String get termsAndPrivacyPolicy;

  /// No description provided for @email.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email của bạn'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get confirmPasswordHint;

  /// No description provided for @or.
  ///
  /// In vi, this message translates to:
  /// **'hoặc'**
  String get or;

  /// No description provided for @forgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khôi phục mật khẩu'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu'**
  String get forgotPasswordDescription;

  /// No description provided for @sendResetLink.
  ///
  /// In vi, this message translates to:
  /// **'Gửi liên kết đặt lại mật khẩu'**
  String get sendResetLink;

  /// No description provided for @backToSignIn.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại đăng nhập'**
  String get backToSignIn;

  /// No description provided for @resetEmailSent.
  ///
  /// In vi, this message translates to:
  /// **'Hướng dẫn đặt lại mật khẩu đã được gửi nếu email tồn tại trong hệ thống'**
  String get resetEmailSent;

  /// No description provided for @otpTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã xác thực'**
  String get otpTitle;

  /// No description provided for @otpDescription.
  ///
  /// In vi, this message translates to:
  /// **'Chúng tôi đã gửi mã 6 số đến email của bạn.'**
  String get otpDescription;

  /// No description provided for @otpNotReceived.
  ///
  /// In vi, this message translates to:
  /// **'Không nhận được mã?'**
  String get otpNotReceived;

  /// No description provided for @verifyOtp.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get verifyOtp;

  /// No description provided for @resendOtp.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã'**
  String get resendOtp;

  /// No description provided for @otpExpireMessage.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã'**
  String get otpExpireMessage;

  /// No description provided for @theCodeWill.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại sau {time}'**
  String theCodeWill(String time);

  /// No description provided for @otpInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Mã xác thực không hợp lệ'**
  String get otpInvalid;

  /// No description provided for @otpExpired.
  ///
  /// In vi, this message translates to:
  /// **'Mã xác thực đã hết hạn'**
  String get otpExpired;

  /// No description provided for @otpVerifySuccess.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực thành công'**
  String get otpVerifySuccess;

  /// No description provided for @otpResendSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi mã xác thực mới'**
  String get otpResendSuccess;

  /// No description provided for @invalidOtpLength.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP phải gồm đúng 6 chữ số'**
  String get invalidOtpLength;

  /// No description provided for @otpResending.
  ///
  /// In vi, this message translates to:
  /// **'Đang gửi lại...'**
  String get otpResending;

  /// No description provided for @invalidNumber.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập số hợp lệ'**
  String get invalidNumber;

  /// No description provided for @profileInformation.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cá nhân'**
  String get profileInformation;

  /// No description provided for @profileInformationDescription.
  ///
  /// In vi, this message translates to:
  /// **'Hãy cho chúng mình biết thêm về bạn'**
  String get profileInformationDescription;

  /// No description provided for @fullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ và tên'**
  String get fullNameHint;

  /// No description provided for @dateOfBirth.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get dateOfBirth;

  /// No description provided for @dateOfBirthHint.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngày sinh'**
  String get dateOfBirthHint;

  /// No description provided for @gender.
  ///
  /// In vi, this message translates to:
  /// **'Giới tính'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In vi, this message translates to:
  /// **'Nam'**
  String get male;

  /// No description provided for @female.
  ///
  /// In vi, this message translates to:
  /// **'Nữ'**
  String get female;

  /// No description provided for @other.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get other;

  /// No description provided for @nickname.
  ///
  /// In vi, this message translates to:
  /// **'Biệt danh'**
  String get nickname;

  /// No description provided for @nicknameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập biệt danh'**
  String get nicknameHint;

  /// No description provided for @address.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ'**
  String get address;

  /// No description provided for @addressHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập địa chỉ'**
  String get addressHint;

  /// No description provided for @phoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số điện thoại'**
  String get phoneNumberHint;

  /// No description provided for @avatar.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh đại diện'**
  String get avatar;

  /// No description provided for @chooseAvatar.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ảnh đại diện'**
  String get chooseAvatar;

  /// No description provided for @avatarTooLarge.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh đại diện không được vượt quá 5 MB'**
  String get avatarTooLarge;

  /// No description provided for @next.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get next;

  /// No description provided for @back.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get back;

  /// No description provided for @complete.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get complete;

  /// No description provided for @save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @loading.
  ///
  /// In vi, this message translates to:
  /// **'Đang xử lý...'**
  String get loading;

  /// No description provided for @requiredField.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập thông tin này'**
  String get requiredField;

  /// No description provided for @invalidEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email không hợp lệ'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải có ít nhất 8 ký tự'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu xác nhận không khớp'**
  String get passwordsDoNotMatch;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không hợp lệ'**
  String get invalidPhoneNumber;

  /// No description provided for @termsRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng đồng ý với điều khoản sử dụng'**
  String get termsRequired;

  /// No description provided for @signInSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thành công'**
  String get signInSuccess;

  /// No description provided for @signUpSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thành công'**
  String get signUpSuccess;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thông tin thành công'**
  String get profileUpdateSuccess;

  /// No description provided for @somethingWentWrong.
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi. Vui lòng thử lại'**
  String get somethingWentWrong;

  /// No description provided for @featureUnderDevelopment.
  ///
  /// In vi, this message translates to:
  /// **'Chức năng đang được phát triển'**
  String get featureUnderDevelopment;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại mật khẩu'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới cho tài khoản của bạn'**
  String get resetPasswordDescription;

  /// No description provided for @newPassword.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu mới'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu mới (tối thiểu 8 ký tự)'**
  String get newPasswordHint;

  /// No description provided for @resetPasswordButton.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật mật khẩu'**
  String get resetPasswordButton;

  /// No description provided for @resetPasswordSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.'**
  String get resetPasswordSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
