import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_guide_app/pages/home_page.dart';
import 'package:new_guide_app/components/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        } 
         if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: kPrimaryColor,
          ),
          home: HomePage(),
        );
      },
    );
  }
}
