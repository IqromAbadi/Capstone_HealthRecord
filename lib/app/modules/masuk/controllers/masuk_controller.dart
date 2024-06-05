import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';

class MasukController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordVisible = false.obs;

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void masuk() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Semua Form harus diisi');
      return;
    }

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar('Success', 'User logged in successfully');
      Get.offAllNamed(Routes.DASHBOARD);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Error',
          'Terlalu banyak permintaan. Coba lagi nanti.',
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Password yang anda masukan salah.',
        );
      } else {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat login. Silakan coba lagi nanti.',
        );
        print(e);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat login. Silakan coba lagi nanti.',
      );
      print(e);
    }
  }
  /* Future<void> handleLogin(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Email dan Password harus diisi.');
      return;
    }

    Masuk(emailController.text, passwordController.text);

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 700),
        child: const DashboardView(),
      ),
    );
  }*/

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
