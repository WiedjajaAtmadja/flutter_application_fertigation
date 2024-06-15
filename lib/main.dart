import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/schedule_provider.dart';
import 'screens/home_page.dart';
import 'screens/input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleProvider(),
      child: MaterialApp(
        title: 'Scheduler',
        theme: ThemeData(
          primaryColor: Colors.green,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green,
          ),
          textTheme: TextTheme(
            headlineSmall: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.green,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
            brightness: Brightness.dark,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green,
          ),
          textTheme: TextTheme(
            headlineSmall: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        themeMode: ThemeMode.system,
        home: HomePage(),
        routes: {
          '/input': (context) => InputPage(),
        },
      ),
    );
  }
}
