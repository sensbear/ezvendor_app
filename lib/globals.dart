library globals;

import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class Globals {
  static final Globals _globals = new Globals._internal();
  Globals._internal();
  static Globals get instance => _globals;

  static const double _screenWidth = 393.0;
  static const double _screenHeight = 781;

  var _screenXScale = 1.0;
  var _screenYScale = 1.0;
  var _screenAspectRatio = 1.0;
  LocalStorage _storage;
  BuildContext _reservedContext;

  BuildContext getContext() {
    return _reservedContext;
  }

  void setContext(BuildContext context) {
    _reservedContext = context;
  }

  // 螢幕X軸縮放比率 geter
  double get screenXScale {
    return _screenXScale;
  }

  // 螢幕Y軸縮放比率 geter
  double get screenYScale {
    return _screenYScale;
  }

  // 螢幕縮放比率 geter
  double get screenAspectRatio {
    return _screenAspectRatio;
  }

  // 取得 內部儲存體
  LocalStorage get storage {
    return _storage;
  }

  // ignore: unused_field
  var _isAndroid = true;

  // 應用程式內部儲存體初始化
  void initLocalStorage() {
    if (_storage == null) {
      debugPrint("[訊息] 規劃內部資訊儲存區.");
      _storage = new LocalStorage('ezvendor');
    }
  }

  bool isJson(String data) {
    try {
      json.decode(data);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 呼叫 WEB API 傳遞方式, 參數使用 JSON 格式
  Future<String> postRequest(String action, String data) async {
    if (!isJson(data)) {
      debugPrint("[錯誤] data 沒有經過JSON編碼, 無法POST!!");
      return '';
    }

    http.Response response = await http.post(
      action,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: data,
    );
    // response successful
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return ''; // Failed to post action !!
    }
  }

  // 計算螢幕長寬縮放比率, 及 整體壓縮比率
  void initScreenAspect(final BuildContext context) {
    print(sprintf("[訊息] 螢幕X軸寬度 = %.4f", [MediaQuery.of(context).size.width]));
    print(sprintf("[訊息] 螢幕Y軸高度 = %.4f", [MediaQuery.of(context).size.height]));
    _screenXScale = (MediaQuery.of(context).size.width / _screenWidth);
    print(sprintf("[訊息] 螢幕X軸縮放比率 = %.4f", [_screenXScale]));
    _screenYScale = (MediaQuery.of(context).size.height / _screenHeight);
    print(sprintf("[訊息] 螢幕Y軸縮放比率 = %.4f", [_screenYScale]));
    _screenAspectRatio = (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height) / (_screenWidth / _screenHeight);
    print(sprintf("[訊息] 螢幕縮放比率 = %.4f", [_screenAspectRatio]));
  }

  // Android 裝置資訊對照表
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId
    };
  }

  // Ios 裝置資訊對照表
  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  // 取得目前支援的平台是屬於 ANDROID or IOS
  void getPlatformSupport() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      print('[訊息] 使用Android系統設置');
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(_readAndroidBuildData(androidInfo).toString());
      _isAndroid = true;
    } else if (Platform.isIOS) {
      print('[訊息] 使用Ios系統設置');
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(_readIosDeviceInfo(iosInfo).toString());
      _isAndroid = false;
    }
  }

  void showMessage(BuildContext context, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ezVendor"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
