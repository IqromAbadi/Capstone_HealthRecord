import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';
import '../controllers/pasienlist_controller.dart';

class PasienlistView extends GetView<PasienlistController> {
  const PasienlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pasien'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.DASHBOARD);
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
                      controller: controller.searchTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Cari Pasien",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.filteredPasienList.isEmpty) {
                  return Center(child: Text("No data found"));
                }

                return ListView.builder(
                  itemCount: controller.filteredPasienList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var pasien = controller.filteredPasienList[index];
                    return Slidable(
                      key: ValueKey(pasien['id']),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Get.dialog(
                                AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content: Text(
                                      'Apakah Anda yakin ingin menghapus data pasien ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.deletePasien(pasien['id']);
                                        Get.back();
                                      },
                                      child: Text('Ya'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              Get.toNamed(Routes.EDITPASIEN,
                                  arguments: {'pasienId': pasien['id']});
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAILPASIEN,
                                arguments: {'pasienId': pasien['id']});
                          },
                          child: MyCard(
                            name: pasien['nama'],
                            title: pasien['alamat'],
                            phoneNumber: pasien['telpon'],
                            controller: controller,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed(Routes.ADDPASIEN);
          if (result == true) {
            controller.fetchPasienList();
          }
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String name;
  final String title;
  final String phoneNumber;
  final PasienlistController controller;

  MyCard({
    required this.name,
    required this.title,
    required this.phoneNumber,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: ShapeDecoration(
        color: Color.fromARGB(255, 1, 203, 239),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFEFEFEF)),
          borderRadius: BorderRadius.circular(15),
        ),
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
              onTap: () {
                controller.openWhatsApp(phoneNumber);
              },
              child: Container(
                width: 78,
                height: 26,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFF6F1F1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Chat',
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
