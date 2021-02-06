import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/ui/landingpage.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ViewModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fire Code',
          theme: ThemeData(
              scaffoldBackgroundColor: Color.fromRGBO(252, 242, 239, 1.0),
              textTheme:
                  TextTheme(headline6: TextStyle(color: Colors.green[700])),
              primaryColor: Colors.green[700],
              primarySwatch: Colors.green),
          home: LandingPage()),
    );
  }
}
