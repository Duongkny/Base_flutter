import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../logger/logger.dart';

class DeviceId {
  static String _uniqueDeviceId = "";

  static Future<String> getUniqueDeviceId() async {
    if (_uniqueDeviceId.isEmpty) {
      logger.d("uniqueDeviceId is empty");
      await setupUniqueDeviceId();
    }

    return _uniqueDeviceId;
  }

  static String _readAndroidDeviceInfo(AndroidDeviceInfo data) {
    return data.version.release +
        data.version.previewSdkInt.toString() +
        data.version.incremental +
        data.version.codename +
        data.brand +
        data.device +
        data.host +
        data.id +
        data.model +
        data.supportedAbis.toString();
  }

  static String _readIosDeviceInfo(IosDeviceInfo data) {
    return data.name +
        data.systemName +
        data.systemVersion +
        data.model +
        data.localizedModel +
        data.identifierForVendor.toString() +
        data.isPhysicalDevice.toString() +
        data.utsname.sysname +
        data.utsname.nodename +
        data.utsname.release +
        data.utsname.version +
        data.utsname.machine;
  }

  static Future<void> setupUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    var uniqueDeviceId = "";

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId = _readIosDeviceInfo(
        iosDeviceInfo,
      ).toString(); // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId = _readAndroidDeviceInfo(androidDeviceInfo);
    }

    _uniqueDeviceId = uniqueDeviceId;

    logger.d("uniqueDeviceId: $_uniqueDeviceId");
  }
}
