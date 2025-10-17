import 'package:flutter/material.dart';

class GamingCenters extends StatelessWidget {
  const GamingCenters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaming Centers', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xff081427),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff081427),
      body: const Column(
          children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Gaming Centers',
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )
    );
  }
}