import 'package:flutter/material.dart';
import 'package:movie_browser_task/view_modal/dashboard_view_modal.dart';
import 'package:provider/provider.dart';
import 'view/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DashboardViewModal())],
      child: MaterialApp(
        title: 'Movie Browser',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DashboardView(),
      ),
    );
  }
}
