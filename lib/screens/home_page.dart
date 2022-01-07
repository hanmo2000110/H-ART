import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('song');
            },
            child: Container(
              width: Get.width,
              height: 70,
              color: Colors.blue,
              child: Center(
                child: Text('music bar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
