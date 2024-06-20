import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';

class AddpasienController extends GetxController {
  final namaLengkapController = TextEditingController();
  final nikController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final alamatLengkapController = TextEditingController();
  final nomorTelephoneController = TextEditingController();
  var jenisKelamin = ''.obs;

  void clearForm() {
    namaLengkapController.clear();
    nikController.clear();
    tanggalLahirController.clear();
    tempatLahirController.clear();
    alamatLengkapController.clear();
    nomorTelephoneController.clear();
    jenisKelamin.value = '';
  }

  Future<bool> checkNIKExists(String nik) async {
    var result = await FirebaseFirestore.instance
        .collection('pasien')
        .where('nik', isEqualTo: nik)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<String> getNextPatientId() async {
    // Query the collection to get the current count of documents
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('pasien')
        .orderBy(FieldPath.documentId, descending: true)
        .limit(1)
        .get();

    int nextId = 1; // Default next ID to start with

    // If documents exist, determine the next ID based on the last document
    if (querySnapshot.docs.isNotEmpty) {
      String lastDocId = querySnapshot.docs.first.id;
      List<String> parts = lastDocId.split('-');
      int lastId = int.tryParse(parts.last) ?? 0;
      nextId = lastId + 1;
    }

    // Format the next ID to PSN-000001 style
    String formattedId = 'PSN-${nextId.toString().padLeft(6, '0')}';

    return formattedId;
  }

  Future<void> savePasien() async {
    String nik = nikController.text;

    if (namaLengkapController.text.isEmpty ||
        nik.isEmpty ||
        tanggalLahirController.text.isEmpty ||
        tempatLahirController.text.isEmpty ||
        alamatLengkapController.text.isEmpty ||
        nomorTelephoneController.text.isEmpty ||
        jenisKelamin.value.isEmpty) {
      Get.snackbar('Error', 'Semua data harus diisi');
      return;
    }

    if (!RegExp(r'^\d+$').hasMatch(nik)) {
      Get.snackbar('Error', 'NIK harus berupa angka');
      return;
    }

    bool nikExists = await checkNIKExists(nik);

    if (nikExists) {
      Get.snackbar('Error', 'NIK sudah terdaftar');
      return;
    }

    String patientId = await getNextPatientId();

    await FirebaseFirestore.instance.collection('pasien').doc(patientId).set({
      'nama': namaLengkapController.text,
      'nik': nik,
      'tanggal_lahir': tanggalLahirController.text,
      'tempat_lahir': tempatLahirController.text,
      'alamat': alamatLengkapController.text,
      'telpon': nomorTelephoneController.text,
      'jenis_kelamin': jenisKelamin.value,
    });

    clearForm();
    Get.snackbar('Success', 'Data pasien berhasil ditambahkan');

    Get.offNamed(Routes.PASIENLIST);
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      tanggalLahirController.text =
          "${picked.day}-${picked.month}-${picked.year}";
    }
  }
}
