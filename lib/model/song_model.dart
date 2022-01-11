import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum weatherType { SUNNY, WINDY, RAINY, CLOUDY, SNOWY }

class SongModel {
  String post_id;
  String creator;
  String title;
  String genre;
  String? creatorName;
  String? creatorProfilePhotoURL;
  Timestamp createdTime;
  String desc;
  String image;
  String song;
  String? youtube;
  RxInt likes = 0.obs;
  // bool? iLiked;
  // bool? iSaved;
  //TODO: 이거 커멘트 타입 정해야함 !!!!!!

  SongModel({
    required this.post_id,
    required this.title,
    required this.creator,
    required this.createdTime,
    required this.image,
    required this.song,
    required this.genre,
    required this.desc,
  });

  set setCreatorProfilePhotoURL(String url) => creatorProfilePhotoURL = url;
}
