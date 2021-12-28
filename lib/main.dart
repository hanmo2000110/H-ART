import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:h_art/screens/add_page.dart';
import 'package:h_art/screens/detail_page.dart';
import 'package:h_art/screens/home_page.dart';
import 'package:h_art/screens/home_page.dart';
import 'package:h_art/screens/login_page.dart';
import 'auth/auth_middleware.dart';
import 'binding/binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(const Hart());
}

class Hart extends StatelessWidget {
  const Hart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // darkTheme: ThemeData.dark(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      title: 'H-ART',
      initialRoute: '/',
      getPages: [
        GetPage(
            name: "/",
            middlewares: [AuthMiddleware()],
            page: () => HomePage(),
            transition: Transition.fadeIn),
        GetPage(
            name: "/detail",
            page: () => DetailPage(),
            transition: Transition.noTransition),
        GetPage(
            name: "/login",
            page: () => LoginPage(),
            transition: Transition.fade),
        GetPage(
            name: "/add",
            page: () => AddPage(),
            transition: Transition.noTransition),
      ],
    );
  }
}
