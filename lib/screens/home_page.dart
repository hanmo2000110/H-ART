import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_art/controller/song_controller.dart';
import 'package:h_art/controller/user_controller.dart';
import 'package:h_art/model/song_model.dart';
import 'package:h_art/model/user_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SongController sc = Get.find<SongController>();
  UserController uc = Get.find<UserController>();

  List<ListTile> _buildListViews(BuildContext context) {
    List<SongModel> songList = sc.songList;
    UserModel usermodel = uc.user;
    return songList.map((song) {
      return ListTile(
        title: Text(song.title),
        leading: Container(
          width: 50,
          child: Image.network(
            song.image,
            fit: BoxFit.fitWidth,
          ),
        ),
        subtitle: Text(song.desc),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('add');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.new_label_rounded),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await sc.getSongs();
              setState(() {});
            },
            child: Text('Get Songs'),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ..._buildListViews(context),
                ],
              ),
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
