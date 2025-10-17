import 'package:flutter/material.dart';
import 'package:project_escapism/page_2/drawer.dart';
import 'package:project_escapism/page_2/home.dart';

void main(){
  runApp(const MaterialApp(home: Home(),));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen()
        ],
      ),
    );
  }
}