
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:fithub_home_test/app/common/routes/app_pages.dart';
import 'package:fithub_home_test/app/common/routes/app_routes.dart' show AppRoutes;
import 'package:fithub_home_test/app/common/theme/daycode_theme.dart';
import 'package:fithub_home_test/app/network_flavor/network_flavor.dart';
import 'package:fithub_home_test/core/network/network.dart';
import 'package:fithub_home_test/core/storage/storage.dart';
import 'package:fithub_home_test/data/data.dart';
import 'package:fithub_home_test/app/hive_adapter/hive_registrar.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapters();
  registerNetworkFlavor();
  registerDioService();
  await registerStorageModule(keySecureStorage: "mykey");
  await registerDataModule();

  runApp(DioRequestInspectorMain(
    inspector: GetIt.I<DioRequestInspector>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(useMaterial3: true);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fithub',
          darkTheme: DaycodeTheme.dark(theme, context),
          themeMode: ThemeMode.dark,
          home: child,
          builder: (context, child) {
            DaycodeTheme.instance.init(context);
            return child!;
          },
          navigatorObservers: [
            DioRequestInspector.navigatorObserver,
          ],
          initialRoute: AppRoutes.dashboard,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
