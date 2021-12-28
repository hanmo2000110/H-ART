import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:h_art/model/user_model.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends GetxController {
  String url = "";
  Future<int> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp3']);

    if (result != null) {
      File file = File(result.files.single.path!);
      url = await post_audio(file);
    } else {
      // User canceled the picker
    }
    return 0;
  }



  Future<String> post_audio(File file) async {
    var downloadURL;
    try {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('music/') //'post'라는 folder를 만들고
          .child('${DateTime.now().millisecondsSinceEpoch}');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putData(file.readAsBytesSync());

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      downloadURL = await (await uploadTask).ref.getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
    return downloadURL;
  }
}
