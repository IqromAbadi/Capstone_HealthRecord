import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/faq_controller.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        centerTitle: true,
        backgroundColor: Color(0xFF01CBEF),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            faqItem(
              'Cara Menambahkan Pasien',
              'Ini adalah penjelasan tentang cara menambahkan pasien.',
            ),
            faqItem(
              'Prosedur Pendaftaran Pasien',
              'Ini adalah penjelasan tentang prosedur pendaftaran pasien.',
            ),
            faqItem(
              'Cara Mengupdate Data Pasien',
              'Ini adalah penjelasan tentang cara mengupdate data pasien.',
            ),
            faqItem(
              'Cara Menghapus Data Pasien',
              'Ini adalah penjelasan tentang cara menghapus data pasien.',
            ),
            faqItem(
              'Cara Mengakses Riwayat Medis Pasien',
              'Ini adalah penjelasan tentang cara mengakses riwayat medis pasien.',
            ),
          ],
        ),
      ),
    );
  }

  Widget faqItem(String title, String content) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xFF000000),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            content,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FaqView(),
  ));
}
