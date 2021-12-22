import 'package:get/get.dart';
import 'package:h_art/controller/auth_controller.dart';
import 'package:h_art/controller/music_controller.dart';
import 'package:h_art/controller/song_controller.dart';
import 'package:h_art/controller/user_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<SongController>(SongController(), permanent: true);
    Get.put<MusicController>(MusicController(), permanent: true);
    // Get.put<PredictController>(PredictController(), permanent: true);
  }
}
