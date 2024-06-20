import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/jadwalpraktik_controller.dart';

class JadwalPraktikView extends GetView<JadwalpraktikController> {
  const JadwalPraktikView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Praktik'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Doctor Info Widget
            Obx(
              () => Container(
                margin: EdgeInsets.fromLTRB(1, 0, 0, 29),
                decoration: BoxDecoration(
                  color: Color(0xFF01CBEF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 13, 0),
                      decoration: BoxDecoration(
                        color: Color(0xFF807D7D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: controller.profileImageUrl.value.isNotEmpty
                            ? Image.network(
                                controller.profileImageUrl.value,
                                width: 104,
                                height: 113,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 104,
                                height: 113,
                                color: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 18, 0, 47),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.name.value,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Header
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Jadwal Praktik',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // List of Schedules
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.jadwalPraktik.length,
                  itemBuilder: (context, hariIndex) {
                    var jadwal = controller.jadwalPraktik[hariIndex];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF01CBEF),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: jadwal.waktuPraktik
                                .asMap()
                                .entries
                                .map((entry) {
                              int waktuIndex = entry.key;
                              var waktu = entry.value;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    jadwal.hari,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(waktu.jamPraktik),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _showEditDialog(context, hariIndex,
                                              waktuIndex, waktu.jamPraktik);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, int hariIndex, int waktuIndex, String jamPraktik) {
    TextEditingController jamController = TextEditingController();
    jamController.text = jamPraktik;

    Get.defaultDialog(
      title: 'Edit Jam Praktik',
      content: Column(
        children: [
          TextField(
            controller: jamController,
            decoration: InputDecoration(labelText: 'Jam Praktik'),
          ),
        ],
      ),
      textConfirm: 'Simpan',
      textCancel: 'Batal',
      onConfirm: () {
        if (jamController.text.isNotEmpty) {
          controller.updateJamPraktik(
              hariIndex, waktuIndex, jamController.text);
          Get.back();
        }
      },
    );
  }
}
