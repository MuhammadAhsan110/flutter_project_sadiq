import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_io/io.dart';
import 'package:http/http.dart' as http;
import 'package:imei/imei.dart';
// import 'package:imei_plugin/imei_plugin.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final databaseReference = FirebaseDatabase.instance.ref('Device Info');
  //String _imei = 'Unknown';
  String _ipAddress = 'Unknown';
  String _deviceType = 'Unknown';
  String _osVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  void getDeviceInfo() async {
    //   String imei = await ImeiPlugin.getImei();
    //   setState(() {
    //     _imei = imei;
    //   });

    try {
      String ipAddress = await _getIPAddress();
      setState(() {
        _ipAddress = ipAddress;
      });
    } catch (e) {
      setState(() {
        _ipAddress = 'Failed to get IP address';
      });
    }

    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          _deviceType = 'Android';
          _osVersion = androidInfo.version.release;
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          _deviceType = 'iOS';
          _osVersion = iosInfo.systemVersion!;
        });
      } else if (kIsWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        setState(() {
          _deviceType = 'Web';
          _osVersion = webInfo.userAgent!;
        });
      }
    } catch (e) {
      setState(() {
        _deviceType = 'Failed to get device type';
        _osVersion = 'Failed to get OS version';
      });
    }
    databaseReference.child('1').set({
      // 'Imei Number': _imei,
      'Ip Address': _ipAddress,
      'Device Type': _deviceType,
      'OS Version': _osVersion,
    });
  }

  Future<String> _getIPAddress() async {
    final response = await http.get(Uri.parse('https://api.ipify.org'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get IP address');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Device Info'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("Device Info updated on firebase"),
            ],
          ),
        ),
      );
}
