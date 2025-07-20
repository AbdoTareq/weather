import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:weather/core/router/app_router.dart';
import 'package:weather/core/sl/injection_container.dart' as sl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(
    RequestsInspector(
      navigatorKey: null,
      enabled: kDebugMode,
      showInspectorOn: ShowInspectorOn.LongPress,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routes,
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
