import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPemeriksaanController extends GetxController {
  final namaPasienController = TextEditingController();
  final nikController = TextEditingController();
  final tanggalLahirController = Rxn<DateTime>();
  final jenisKelaminController = RxString('');
  final tanggalWaktuPemeriksaanController = Rxn<DateTime>();
  final kunjunganTypeController = RxString('');
  final keluhanUtamaController = TextEditingController();
  final riwayatPenyakitController = TextEditingController();
  final riwayatpenyakitsebelumnyaController = TextEditingController();
  final riwayatAlergiController = TextEditingController();
  final riwayatObatController = TextEditingController();
  final tekananDarahController = TextEditingController();
  final denyutNadiController = TextEditingController();
  final suhuTubuhController = TextEditingController();
  final pernafasanController = TextEditingController();
  final tinggiBadanController = TextEditingController();
  final beratBadanController = TextEditingController();

  // Document ID of the record to be edited
  String documentId = '';

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['id'] != null) {
      documentId = Get.arguments['id'];
      fetchData(documentId);
    }
  }

  void fetchData(String documentId) async {
    CollectionReference pemeriksaan =
        FirebaseFirestore.instance.collection('pemeriksaan');
    DocumentSnapshot docSnapshot = await pemeriksaan.doc(documentId).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      loadData(data);
    } else {
      Get.snackbar('Error', 'Data tidak ditemukan');
      Get.back();
    }
  }

  void loadData(Map<String, dynamic> data) {
    namaPasienController.text = data['nama_pasien'];
    nikController.text = data['nik'];
    tanggalLahirController.value =
        (data['tanggal_lahir'] as Timestamp).toDate();
    jenisKelaminController.value = data['jenis_kelamin'];
    tanggalWaktuPemeriksaanController.value =
        (data['tanggal_waktu_pemeriksaan'] as Timestamp).toDate();
    kunjunganTypeController.value = data['kunjungan_type'];
    keluhanUtamaController.text = data['keluhan_utama'];
    riwayatPenyakitController.text = data['riwayat_penyakit'];
    riwayatpenyakitsebelumnyaController.text =
        data['riwayat_penyakit_sebelumnya'];
    riwayatAlergiController.text = data['riwayat_alergi'];
    riwayatObatController.text = data['riwayat_obat'];
    tekananDarahController.text = data['tekanan_darah'];
    denyutNadiController.text = data['denyut_nadi'];
    suhuTubuhController.text = data['suhu_tubuh'];
    pernafasanController.text = data['pernafasan'];
    tinggiBadanController.text = data['tinggi_badan'];
    beratBadanController.text = data['berat_badan'];
  }
}
