import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_mina_gallery/view/screens/gallery_screen.dart';

import 'package:pro_mina_gallery/view/screens/login_screen.dart';
import 'package:pro_mina_gallery/view_model/cubits/auth_cubit/auth_cubit.dart';
import 'package:pro_mina_gallery/view_model/cubits/gallery_cubit/gallery_cubit.dart';
import 'package:pro_mina_gallery/view_model/database/local/cache_helper.dart';
import 'package:pro_mina_gallery/view_model/database/network/dio_helper.dart';

import 'constant/observer.dart';
import 'constant/theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await CacheHelper.init();
  DioHelper.init();
  var token = CacheHelper.getData(key: 'accessToken');
  Widget startWidget;
  if (token != null) {
    startWidget = GalleryScreen();
  } else {
    startWidget = LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => GalleryCubit()),
          ],
          child: MyApp(
            startScreen: startWidget,
          )));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget? startScreen;

  MyApp({super.key, this.startScreen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My-Gallery',
          theme: lightTheme,
          home: startScreen,
        );
      },
    );
  }
}
