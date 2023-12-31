import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passaros_nordeste/route.dart';

import 'constants.dart';
import 'firebase_options.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const MaterialApp(
      title: 'Pets Garanhuns',
      //theme: lightTheme,
      onGenerateRoute: Rotas.generateRoute,
      initialRoute: initialSplash,
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptionsProvider.getOptions());
  runApp(const App());
}
