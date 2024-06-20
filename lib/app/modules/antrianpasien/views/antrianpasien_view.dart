import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';
import '../controllers/antrianpasien_controller.dart';

class AntrianpasienView extends StatelessWidget {
  final AntrianpasienController controller = Get.put(AntrianpasienController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrian Pasien'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.PASIENLIST);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.search),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.searchPasien(value);
                        } else {
                          controller.clearSearch();
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari Pasien",
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.antrianList.isEmpty) {
                  return Center(child: Text("Tidak ada antrian hari ini"));
                } else {
                  return ListView.builder(
                    itemCount: controller.antrianList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var antrian = controller.antrianList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            controller.showStatusDialog(
                                antrian['id'].toString(), antrian['status']);
                          },
                          child: MyCard(
                            name: antrian['pasien_id'],
                            title:
                                antrian['nama_pasien'] ?? 'Nama tidak tersedia',
                            nomor: antrian['no_antrian'].toString(),
                            status: antrian['status'].toString(),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String name;
  final String title;
  final String nomor;
  final String status;

  MyCard({
    required this.name,
    required this.title,
    required this.nomor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool belumDilayani = status == 'Belum Dilayani';

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: belumDilayani
            ? Color.fromARGB(
                128, 1, 203, 239) // Warna transparan jika Belum Dilayani
            : Color.fromARGB(
                255, 1, 203, 239), // Warna utama jika sudah dilayani
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Color(0xFFEFEFEF)),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Color(0xFFF6F1F1)),
                ),
                child: Center(
                  child: Text(
                    "No Antrian : $nomor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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
}
