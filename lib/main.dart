import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_flutter/background_service/back_service.dart';
import 'package:map_flutter/di/injection_container.dart';
import 'package:map_flutter/global_cubit/global_cubit.dart';
import 'package:map_flutter/home/manager/home_cubit.dart';
import 'package:map_flutter/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  initializeService();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => serviceLocator<GlobalCubit>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<HomeCubit>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MapScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
