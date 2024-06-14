import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/ubahprofile_controller.dart';

class UbahprofileView extends GetView<UbahprofileController> {
  const UbahprofileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.back(); // Menggunakan GetX untuk navigasi kembali
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF01CBEF),
              ),
              padding: EdgeInsets.fromLTRB(24, 33, 24, 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text(
                    'Ubah Profil',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 25, height: 20),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(21, 0, 21, 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 270.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 44, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFC4C4C4),
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
                    GestureDetector(
                      onTap: () {
                        // Tambahkan aksi ketika tombol diubah diklik
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 34, 0, 34),
                        decoration: BoxDecoration(
                          color: Color(0xFF01CBEF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            XFile? pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            // Lakukan sesuatu dengan gambar yang dipilih
                          },
                          child: Container(
                            width: 126.1,
                            padding: EdgeInsets.fromLTRB(0, 8, 0.6, 8),
                            alignment: Alignment
                                .center, // Meletakkan teks di tengah secara horizontal
                            decoration: BoxDecoration(
                              color: Color(0xFF01CBEF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Ambil Foto',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _infoRow('Nama'),
          _infoRow('Nomor Telepon'),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  // Tambahkan aksi ketika tombol simpan diklik
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF01CBEF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                    child: Container(
                      width: 170,
                      padding: EdgeInsets.fromLTRB(0, 7, 0.8, 7),
                      alignment: Alignment
                          .center, // Meletakkan teks di tengah secara horizontal
                      decoration: BoxDecoration(
                        color: Color(0xFF01CBEF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label) {
    return Container(
      margin: EdgeInsets.fromLTRB(21, 0, 21, 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
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
            decoration: BoxDecoration(
              color: Color(0xFF000000),
            ),
            child: Container(
              width: 316,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
