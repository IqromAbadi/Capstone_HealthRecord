import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/modules/onboarding/views/onboarding_view.dart';
import 'package:page_transition/page_transition.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: OnboardingView(),
          type: PageTransitionType.fade,
          duration: const Duration(seconds: 3),
        ),
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/image.png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Image.asset("assets/images/Logo.png"),
          )
        ],
      ),
    );
  }
}
