import 'package:complaint_manager/login_page.dart';
import 'package:complaint_manager/main_tabbar.dart';
import 'package:complaint_manager/models/user_details_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return viewModel.currentUser == null ? LoginPage() : MainTabbar();
          }),
    );
  }
}
