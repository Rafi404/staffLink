import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stafflink/app_constants/app_constants.dart';
import 'package:stafflink/view/home_page/home_page.dart';

import '../../controller/app_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final appController = Get.put(AppMainController());

  @override
  void initState() {
    super.initState();
    appController.setDatabase();

    Future.delayed(const Duration(milliseconds: 2500)).then((value) => Get.to(
          const HomePage(),
          transition: Transition.cupertino,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Staff Link +',
          style: robotoNormal.copyWith(
              fontSize: 30, fontWeight: FontWeight.w800, color: primaryColor),
        ),
      ),
    );
  }
}
