import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h_art/controller/user_controller.dart';
import 'package:h_art/model/song_model.dart';

class SongController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _postListener;

  @override
  onInit() async {
    super.onInit();
  }

  List<SongModel> _songList = [];
  List<SongModel> get myposts => _songList;

  // List<SongModel> _uidPosts = [];
  // List<SongModel> get uidposts => _uidPosts;
  // void cleanUidPost() => _uidPosts = [];

  // List<SongModel> _searchPosts = [];
  // List<SongModel> get searchposts => _searchPosts;

  // List<SongModel> _wheatherPosts = [];
  // List<SongModel> get wheatherposts => _wheatherPosts;

  // List<SongModel> _savedPosts = [];
  // List<SongModel> get savedposts => _savedPosts;

  Future getMyPosts() async {
    UserController uc = Get.find<UserController>();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    _songList.clear();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    // print(uid);
    var result = await firestore
        .collection('posts')
        .where("creator", isEqualTo: uid)
        .orderBy('createdTime', descending: true)
        .get();
    // print("now testing my Songcontroller");

    result.docs.forEach((element) async {
      // print(element.data()['creator']);
      String creatorName = await getCreatorInfo(uid);
      SongModel post = SongModel(
        createdTime: element.data()['createdTime'],
        creator: element.data()['creator'],
        creatorName: creatorName,
        post_id: element.data()['post_id'],
        desc: element.data()['desc'],
        ilink: element.data()['ilink'],
      );
      // var creator = await firestore.collection('user').doc(post.creator).get();
      // post.setCreatorProfilePhotoURL = creator['profile_image_url'];
      // post.likes!.value = await countLike(post.post_id);
      // post.iLiked = await iLiked(post.post_id);
      // post.iSaved = await iSaved(post.post_id);
      _songList.add(post);
      // print(element.data()['image_links'].cast<String>()[0]);
    });
    print(_songList.length);
  }

  // Future getPostsUid(String uid) async {
  //   UserController uc = Get.find<UserController>();
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   _myPosts.clear();
  //   // print(uid);
  //   var result = await firestore
  //       .collection('posts')
  //       .where("creator", isEqualTo: uid)
  //       .orderBy('createdTime', descending: true)
  //       .get();
  //   // print("now testing my Songcontroller");

  //   result.docs.forEach((element) async {
  //     // print(element.data()['creator']);
  //     String creatorName = await getCreatorInfo(uid);
  //     SongModel post = SongModel(
  //       createdTime: element.data()['createdTime'],
  //       creator: element.data()['creator'],
  //       creatorName: creatorName,
  //       post_id: element.data()['post_id'],
  //       lookType: element.data()['lookType'],
  //       wheather: element.data()['weather'],
  //       content: element.data()['content'],
  //       image_links: element.data()['image_links'].cast<String>(),
  //     );
  //     var creator = await firestore.collection('user').doc(post.creator).get();
  //     post.setCreatorProfilePhotoURL = creator['profile_image_url'];
  //     post.likes!.value = await countLike(post.post_id);
  //     post.iLiked = await iLiked(post.post_id);
  //     post.iSaved = await iSaved(post.post_id);
  //     _uidPosts.add(post);
  //     // print(element.data()['image_links'].cast<String>()[0]);
  //   });
  //   // print(_myPosts.length);
  // }

  // Future getSavedPosts() async {
  //   UserController uc = Get.find<UserController>();
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   _savedPosts.clear();
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // print(uid);
  //   var result = await firestore
  //       .collection('user')
  //       .doc(uid)
  //       .collection("savedPost")
  //       .get();

  //   // print("now testing my Songcontroller");

  //   result.docs.forEach((element) async {
  //     // print(element.data()['creator']);
  //     String creatorName = await getCreatorInfo(uid);
  //     String docid = element.data()['docid'];
  //     var res = await firestore.collection("posts").doc(docid).get();

  //     SongModel post = SongModel(
  //       createdTime: res.data()!['createdTime'],
  //       creator: res.data()!['creator'],
  //       creatorName: creatorName,
  //       post_id: res.data()!['post_id'],
  //       lookType: res.data()!['lookType'],
  //       wheather: res.data()!['weather'],
  //       content: res.data()!['content'],
  //       image_links: res.data()!['image_links'].cast<String>(),
  //     );
  //     var creator = await firestore.collection('user').doc(post.creator).get();
  //     post.setCreatorProfilePhotoURL = creator['profile_image_url'];
  //     post.likes!.value = await countLike(post.post_id);
  //     post.iLiked = await iLiked(post.post_id);
  //     post.iSaved = await iSaved(post.post_id);
  //     // print(post.image_links[0]);
  //     _savedPosts.add(post);
  //     // print(element.data()['image_links'].cast<String>()[0]);
  //   });
  //   // print(_savedPosts.length);
  // }

  // Future getPosts() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   _searchPosts.clear();
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // print(uid);
  //   var result = await firestore
  //       .collection('posts')
  //       .orderBy('createdTime', descending: true)
  //       .get();
  //   // print("now testing getPosts");

  //   result.docs.forEach((element) async {
  //     // print(element.data()['creator']);
  //     String creatorName = await getCreatorInfo(element.data()['creator']);
  //     SongModel post = SongModel(
  //       createdTime: element.data()['createdTime'],
  //       creator: element.data()['creator'],
  //       creatorName: creatorName,
  //       post_id: element.data()['post_id'],
  //       lookType: element.data()['lookType'],
  //       wheather: element.data()['weather'],
  //       content: element.data()['content'],
  //       image_links: element.data()['image_links'].cast<String>(),
  //     );
  //     var creator = await firestore.collection('user').doc(post.creator).get();
  //     post.setCreatorProfilePhotoURL = creator['profile_image_url'];
  //     post.likes!.value = await countLike(post.post_id);
  //     post.iLiked = await iLiked(post.post_id);
  //     post.iSaved = await iSaved(post.post_id);
  //     _searchPosts.add(post);
  //     // print(element.data()['image_links'].cast<String>()[0]);
  //   });

  //   // print(_searchPosts.length);
  // }

  // Future getWheatherPosts(int search_wheather) async {
  //   UserController uc = Get.find<UserController>();
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   _wheatherPosts.clear();
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   var result = await firestore
  //       .collection('posts')
  //       .where("weather", isEqualTo: search_wheather)
  //       .orderBy('createdTime', descending: true)
  //       .get();

  //   result.docs.forEach((element) async {
  //     String creatorName = await getCreatorInfo(element.data()['creator']);
  //     SongModel post = SongModel(
  //       createdTime: element.data()['createdTime'],
  //       creator: element.data()['creator'],
  //       creatorName: creatorName,
  //       post_id: element.data()['post_id'],
  //       lookType: element.data()['lookType'],
  //       wheather: element.data()['weather'],
  //       content: element.data()['content'],
  //       image_links: element.data()['image_links'].cast<String>(),
  //     );
  //     var creator = await firestore.collection('user').doc(post.creator).get();
  //     post.setCreatorProfilePhotoURL = creator['profile_image_url'];
  //     post.likes!.value = await countLike(post.post_id);
  //     post.iLiked = await iLiked(post.post_id);
  //     post.iSaved = await iSaved(post.post_id);
  //     _wheatherPosts.add(post);
  //   });
  // }

  Future<String> getCreatorInfo(String creator) async {
    var creatorInfo = await firestore.collection('user').doc(creator).get();
    return creatorInfo['name'];
  }

  // Future<bool> like(String docid) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   final usersRef =
  //       firestore.collection('posts').doc(docid).collection("like").doc(uid);
  //   // print(docid);
  //   usersRef.get().then((docSnapshot) async {
  //     if (docSnapshot.exists) {
  //       usersRef.delete();
  //       print("like deleted");
  //       return false;
  //     } else {
  //       usersRef.set({"likedTime": Timestamp.now()});
  //       print("like added");
  //       return true;
  //     }
  //   });
  //   return false;
  // }

  // Future<int> countLike(String docid) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // print("fu");
  //   final usersRef = await firestore
  //       .collection('posts')
  //       .doc(docid)
  //       .collection("like")
  //       .snapshots()
  //       .first;
  //   // print("ck");

  //   return usersRef.docs.length;
  // }

  // Future<bool> iLiked(String docid) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // print(docid);
  //   final usersRef = await firestore
  //       .collection('posts')
  //       .doc(docid)
  //       .collection("like")
  //       .doc(uid)
  //       .get();
  //   // print("ck");

  //   return usersRef.exists;
  // }

  // Future<bool> savePost(String docid) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   final usersRef = firestore
  //       .collection('user')
  //       .doc(uid)
  //       .collection("savedPost")
  //       .doc(docid);

  //   // print(docid);

  //   usersRef.get().then((docSnapshot) async {
  //     if (docSnapshot.exists) {
  //       usersRef.delete();
  //       print("save deleted");
  //       return false;
  //     } else {
  //       usersRef.set({
  //         "savedTime": Timestamp.now(),
  //         "docid": docid,
  //       });
  //       print("save added");
  //       return true;
  //     }
  //   });
  //   return false;
  // }

  // Future<bool> iSaved(String docid) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // print(docid);
  //   final usersRef = await firestore
  //       .collection('user')
  //       .doc(uid)
  //       .collection("savedPost")
  //       .doc(docid)
  //       .get();
  //   // print("ck");

  //   return usersRef.exists;
  // }
}
