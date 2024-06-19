import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthrecord/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahPemeriksaanController extends GetxController {
  // Form field controllers
  final namaPasienController = TextEditingController();
  final nikController = TextEditingController();
  final tanggalLahirController = Rx<DateTime?>(null);
  final jenisKelaminController = RxString('');
  final tanggalWaktuPemeriksaanController = Rx<DateTime?>(null);
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

  // Fungsi untuk validasi field
  bool validateFields() {
    if (namaPasienController.text.isEmpty ||
        nikController.text.isEmpty ||
        tanggalLahirController.value == null ||
        jenisKelaminController.value.isEmpty ||
        tanggalWaktuPemeriksaanController.value == null ||
        kunjunganTypeController.value.isEmpty ||
        keluhanUtamaController.text.isEmpty ||
        riwayatPenyakitController.text.isEmpty ||
        tekananDarahController.text.isEmpty ||
        denyutNadiController.text.isEmpty ||
        suhuTubuhController.text.isEmpty ||
        pernafasanController.text.isEmpty ||
        tinggiBadanController.text.isEmpty ||
        beratBadanController.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }

    if (!RegExp(r"^\d{16}$").hasMatch(nikController.text)) {
      Get.snackbar('Error', 'NIK harus berisi 16 angka');
      return false;
    }

    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(namaPasienController.text)) {
      Get.snackbar('Error', 'Nama pasien hanya boleh berisi huruf');
      return false;
    }

    if (!RegExp(r"^\d{1,3}/\d{1,3}$").hasMatch(tekananDarahController.text)) {
      Get.snackbar(
          'Error', 'Tekanan darah harus berformat angka/angka (misal 120/80)');
      return false;
    }

    if (!RegExp(r"^\d+$").hasMatch(denyutNadiController.text)) {
      Get.snackbar('Error', 'Denyut nadi hanya boleh berisi angka');
      return false;
    }

    int denyutNadi = int.tryParse(denyutNadiController.text) ?? -1;
    if (denyutNadi < 0 || denyutNadi > 1000) {
      Get.snackbar('Error', 'Denyut nadi maksimal 1000 kali');
      return false;
    }

    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(suhuTubuhController.text)) {
      Get.snackbar('Error',
          'Suhu tubuh hanya boleh berisi angka dan boleh menggunakan desimal');
      return false;
    }

    double suhuTubuh = double.tryParse(suhuTubuhController.text) ?? -1;
    if (suhuTubuh < 0 || suhuTubuh > 100) {
      Get.snackbar('Error', 'Suhu tubuh maksimal 100 celcius');
      return false;
    }

    if (!RegExp(r"^\d+$").hasMatch(pernafasanController.text)) {
      Get.snackbar('Error', 'Pernafasan hanya boleh berisi angka');
      return false;
    }

    int pernafasan = int.tryParse(pernafasanController.text) ?? -1;
    if (pernafasan < 0 || pernafasan > 1000) {
      Get.snackbar('Error', 'Pernafasan maksimal 1000 kali');
      return false;
    }

    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(tinggiBadanController.text)) {
      Get.snackbar('Error',
          'Tinggi badan hanya boleh berisi angka dan boleh menggunakan desimal');
      return false;
    }

    double tinggiBadan = double.tryParse(tinggiBadanController.text) ?? -1;
    if (tinggiBadan < 0 || tinggiBadan > 500) {
      Get.snackbar('Error', 'Tinggi badan maksimal 500 cm');
      return false;
    }

    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(beratBadanController.text)) {
      Get.snackbar('Error',
          'Berat badan hanya boleh berisi angka dan boleh menggunakan desimal');
      return false;
    }

    double beratBadan = double.tryParse(beratBadanController.text) ?? -1;
    if (beratBadan < 0 || beratBadan > 1000) {
      Get.snackbar('Error', 'Berat badan maksimal 1000 kg');
      return false;
    }

    return true;
  }

  // Menyimpan data ke Firestore
  void saveData() async {
    if (!validateFields()) {
      return;
    }

    CollectionReference pemeriksaan =
        FirebaseFirestore.instance.collection('pemeriksaan');
    await pemeriksaan.add({
      'nama_pasien': namaPasienController.text,
      'nik': nikController.text,
      'tanggal_lahir': tanggalLahirController.value,
      'jenis_kelamin': jenisKelaminController.value,
      'tanggal_waktu_pemeriksaan': tanggalWaktuPemeriksaanController.value,
      'kunjungan_type': kunjunganTypeController.value,
      'keluhan_utama': keluhanUtamaController.text,
      'riwayat_penyakit': riwayatPenyakitController.text,
      'riwayat_penyakit_sebelumnya': riwayatpenyakitsebelumnyaController.text,
      'riwayat_alergi': riwayatAlergiController.text,
      'riwayat_obat': riwayatObatController.text,
      'tekanan_darah': tekananDarahController.text,
      'denyut_nadi': denyutNadiController.text,
      'suhu_tubuh': suhuTubuhController.text,
      'pernafasan': pernafasanController.text,
      'tinggi_badan': tinggiBadanController.text,
      'berat_badan': beratBadanController.text,
    }).then((value) {
      Get.snackbar('Sukses', 'Data berhasil disimpan');
      Get.offNamed(Routes.REKAM_MEDIS);
    }).catchError((error) {
      Get.snackbar('Error', 'Gagal menyimpan data: $error');
    });
  }

  //mengosongkan field
  void batal() {
    namaPasienController.clear();
    nikController.clear();
    tanggalLahirController.value = null;
    jenisKelaminController.value = '';
    tanggalWaktuPemeriksaanController.value = null;
    kunjunganTypeController.value = '';
    keluhanUtamaController.clear();
    riwayatPenyakitController.clear();
    riwayatpenyakitsebelumnyaController.clear();
    riwayatAlergiController.clear();
    riwayatObatController.clear();
    tekananDarahController.clear();
    denyutNadiController.clear();
    suhuTubuhController.clear();
    pernafasanController.clear();
    tinggiBadanController.clear();
    beratBadanController.clear();
  }
}
