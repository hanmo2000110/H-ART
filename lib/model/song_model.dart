import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum weatherType { SUNNY, WINDY, RAINY, CLOUDY, SNOWY }

class SongModel {
  String post_id;
  String creator;
  String? creatorName;
  String? creatorProfilePhotoURL;
  Timestamp createdTime;
  int wheather;
  String lookType;
  String? content;
  List<String> image_links;
  RxInt? likes = 0.obs;
  bool? iLiked;
  bool? iSaved;
  //TODO: 이거 커멘트 타입 정해야함 !!!!!!

  SongModel({
    required this.post_id,
    required this.creator,
    this.creatorName,
    required this.createdTime,
    required this.lookType,
    required this.image_links,
    this.content,
    required this.wheather,
  });

  set setCreatorProfilePhotoURL(String url) => creatorProfilePhotoURL = url;

  SongModel.fromJson(Map<String, dynamic> json)
      : post_id = json['post_id'],
        creator = json['creator'],
        createdTime = json['createdtime'],
        image_links = json['image_links'],
        content = json['content'],
        lookType = json['looktype'],
        wheather = json['wheather'].toList();

  Map<String, dynamic> toJson() => {
        'post_id': post_id,
        'creator': creator,
        'createdtime': createdTime,
        'image_links': image_links,
        'content': content,
        'looktype': lookType,
        'wheather': wheather,
        //TODO: 이거 커멘트 타입 정해야함 !!!!!!
      };

  @override
  String toString() => "$creator (post_id=$post_id)";
}
