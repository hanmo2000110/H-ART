// import 'dart:async';
// import 'dart:collection';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_art/controller/user_controller.dart';
import 'package:h_art/model/song_model.dart';
import 'package:image_picker/image_picker.dart';

class SongController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _postListener;
  UserController uc = Get.find<UserController>();
  String sfile = "";
  PickedFile? imageFile;

  @override
  onInit() async {
    await getSongs();
    super.onInit();
  }

  List<SongModel> _songList = [];
  List<SongModel> get songList => _songList;

  Future getSongs() async {
    UserController uc = Get.find<UserController>();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    _songList.clear();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    // print(uid);
    var result = await firestore.collection('songs').get();
    print("now testing my postcontroller");

    result.docs.forEach((element) async {
      print(element.data()['title']);
      // String creatorName = await getCreatorInfo(uid);
      SongModel post = SongModel(
        createdTime: element.data()['createdTime'],
        creator: element.data()['creator'],
        title: element.data()['title'],
        post_id: element.data()['post_id'],
        genre: element.data()['genre'],
        desc: element.data()['desc'],
        song: element.data()['song'],
        image: element.data()['image'],
      );
      // var creator = await firestore.collection('user').doc(post.creator).get();
      // post.setCreatorProfilePhotoURL = creator['profile_image_url'];
      // post.likes!.value = await countLike(post.post_id);
      // post.iLiked = await iLiked(post.post_id);
      // post.iSaved = await iSaved(post.post_id);
      _songList.add(post);
      // print(element.data()['image_links'].cast<String>()[0]);
    });
    // print(_myPosts.length);
  }

  Future<void> addPost({
    required String title,
    required String desc,
    required String genre,
    String? youtube,
    required File song,
    required PickedFile image,
  }) async {
    CollectionReference posts = FirebaseFirestore.instance.collection("songs");
    int id = 0;
    var docid;
    final now = FieldValue.serverTimestamp();

    await posts
        .add(
      ({
        'creator': uc.user.uid,
        'title': title,
        "desc": desc,
        'createdTime': now,
        'genre': genre,
        "song": youtube,
        // "ilink": ilink,
        // "slink": slink
      }),
    )
        .then((value) async {
      print(value.id);
      docid = value.id;
      var imageDownloadLink = await uploadImageToStorage(image.path, docid);
      var audioDownloadLink = await uploadAudioToStorage(song, docid);
      posts.doc(docid).update({
        "image": imageDownloadLink,
        "song": audioDownloadLink,
        "post_id": docid,
      });
      // await pc.getMyPosts();
    });
    // appstate.loadProducts(ddp.sortingway);
  }

  Future<String> uploadImageToStorage(String iPath, String docid) async {
    String downloadLink = "";
    try {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('image/$docid') //'post'라는 folder를 만들고
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      // 파일 업로드
      final uploadTask =
          firebaseStorageRef.putData(File(iPath).readAsBytesSync());

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      downloadLink = await (await uploadTask).ref.getDownloadURL();
      print(downloadLink);
      return downloadLink;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
    return downloadLink;
  }

  Future pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp3']);

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      // User canceled the picker
    }
    return null;
  }

  Future<String> uploadAudioToStorage(File file, String docid) async {
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

  Future getImageFromGallery() async {
    return await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  }
}
