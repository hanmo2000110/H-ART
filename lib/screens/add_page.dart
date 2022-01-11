import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_art/controller/music_controller.dart';
import 'package:h_art/controller/song_controller.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  PickedFile? image;
  File? song;
  SongController sc = Get.find<SongController>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final yLinkController = TextEditingController();
  final genreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Page'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              sc.addPost(
                title: titleController.text,
                desc: descController.text,
                genre: genreController.text,
                song: song!,
                image: image!,
                youtube: yLinkController.text,
              );
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              InkWell(
                child: SizedBox(
                    height: Get.width,
                    width: Get.width,
                    child: image != null
                        ? Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 30,
                            ),
                          )),
                onTap: () async {
                  image = await sc.getImageFromGallery();
                  setState(() {});
                },
                splashColor: Colors.transparent,
              ),
              InkWell(
                onTap: () async {
                  song = await sc.pickAudioFile();
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: song != null ? Text(song!.path) : Text("곡 선택"),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "제목을 입력하시오",
                    labelStyle: TextStyle(fontSize: 14),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  onChanged: (value) {},
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: yLinkController,
                  decoration: const InputDecoration(
                    labelText: "유튜브 영상이 있다면 입력하시오",
                    labelStyle: TextStyle(fontSize: 14),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  onChanged: (value) {},
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: genreController,
                  decoration: const InputDecoration(
                    labelText: "장르를 입력하시오",
                    labelStyle: TextStyle(fontSize: 14),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(),
                  ),
                  autocorrect: false,
                  maxLines: 1,
                  onChanged: (value) {},
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "곡의 설명을 입력하시오",
                    labelStyle: TextStyle(fontSize: 14),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(),
                  ),
                  // minLines: 3,
                  autocorrect: false,
                  maxLines: null,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
사진
노래 제목
유튜브 링크 



*/
