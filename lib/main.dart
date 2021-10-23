import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innovers_exam/pages/home_page.dart';
import 'package:innovers_exam/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(InnoversExam());
}

class InnoversExam extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovers Exam',
      theme: DefaultTheme.standard,
      home: HomePage(),
    );
  }
}
