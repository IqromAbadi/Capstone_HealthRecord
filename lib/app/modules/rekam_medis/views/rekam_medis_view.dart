import 'package:healthrecord/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../controllers/rekam_medis_controller.dart';

class RekamMedisView extends GetView<RekamMedisController> {
  const RekamMedisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01CBEF),
        title: const Text(
          'Rekam Medis',
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                cursorColor: Colors.black,
                controller: controller.searchTextController,
                decoration: const InputDecoration(
                  labelText: 'Cari pasien',
                  suffixIcon: Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.filteredPasien.isEmpty) {
                  return const Center(
                    child: Text('Tidak Ada Data'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.filteredPasien.length,
                    itemBuilder: (context, index) {
                      var pasien = controller.filteredPasien[index];

                      return Slidable(
                        key: Key(pasien['id']),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Get.toNamed(Routes.UBAH_PEMERIKSAAN,
                                    arguments: pasien);
                              },
                              icon: Icons.edit_outlined,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                _confirmDeletePasien(pasien['id']);
                              },
                              icon: Icons.delete_outline,
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF01CBEF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(
                              'ID Pemeriksaan : ${pasien['id']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'poppins',
                                fontSize: 13,
                              ),
                            ),
                            subtitle: Text(
                              'Nama Pasien : ${pasien['nama_pasien']}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_PEMERIKSAAN,
                                  arguments: pasien);
                            },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.TAMBAH_PEMERIKSAAN);
        },
        backgroundColor: const Color(0xFF343FF9),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _confirmDeletePasien(String idPasien) {
    Get.defaultDialog(
      title: 'Konfirmasi',
      titleStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      middleText: 'Apakah Anda yakin ingin menghapus data pasien ini?',
      middleTextStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF01CBEF),
            minimumSize: const Size(100, 10),
          ),
          onPressed: () {
            controller.deletePasien(idPasien);
            Get.back();
          },
          child: const Text(
            'Hapus',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF01CBEF),
            minimumSize: const Size(100, 10),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Batal',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
