import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileHeader(context),
                  _infoAkunSection(),
                  _buttonUbahProfil(),
                ],
              ),
              Positioned(
                right: 64,
                top: 234,
                child: _buttonKembaliKeMenu(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 38),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: Color(0xFF01CBEF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 55, 0, 62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 148, 34, 34),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.fromLTRB(0, 26.2, 0, 35.7),
                    child: SizedBox(
                      width: 38.1,
                      height: 38.1,
                      child: Image.asset(
                        'assets/images/vector.png',
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Dr. Viandini',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoAkunSection() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 11),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Info Akun',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 38),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF01CBEF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 26, 0, 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoAkunItem('Nama', 'Dr. Viandini'),
                  _infoAkunItem('Email', 'Viandinini@gmail.com'),
                  _infoAkunItem('Nomor Telepon', '0874874698746'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoAkunItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonUbahProfil() {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/ubahprofile');
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0.1, 0, 0, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF01CBEF),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 126.1,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Ubah Profil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonKembaliKeMenu() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: 280,
        height: 41,
        decoration: BoxDecoration(
          color: Color(0xFFC4C4C4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Kembali ke menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
