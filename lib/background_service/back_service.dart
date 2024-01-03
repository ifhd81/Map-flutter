import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      onBackground: onIosBackground,
      onForeground: onStart,
      autoStart: true,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  if(service is AndroidServiceInstance){
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  else {
    service.on('setAsForeground').listen((event) {
      Timer.periodic(const Duration(seconds: 10), (timer)async {
        print('background service running10');
      });
    });
    service.on('setAsBackground').listen((event) {
      Timer.periodic(const Duration(seconds: 10), (timer)async {
        print('background service running11');
      });
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(seconds: 10), (timer)async {
    if(service is AndroidServiceInstance){
      if(await service.isForegroundService()){
        service.setForegroundNotificationInfo(title: 'background service', content: '');
      }
      print('background service running1');
      service.invoke('update');
    }
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground (ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);
  return true ;
}