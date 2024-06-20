import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PasienlistController extends GetxController {
  var pasienList = <Map<String, dynamic>>[].obs;
  var filteredPasienList = <Map<String, dynamic>>[].obs;
  var searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPasienList();
    searchTextController.addListener(_searchPasien);
  }

  void fetchPasienList() async {
    var result = await FirebaseFirestore.instance.collection('pasien').get();
    var list = result.docs.map((doc) {
      var data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
    pasienList.value = list;
    filteredPasienList.value = list;
  }

  void _searchPasien() {
    String query = searchTextController.text.toLowerCase();
    filteredPasienList.value = pasienList.where((pasien) {
      return pasien['nama'].toString().toLowerCase().contains(query) ||
          pasien['alamat'].toString().toLowerCase().contains(query) ||
          pasien['telpon'].toString().toLowerCase().contains(query) ||
          pasien['tanggal_lahir'].toString().toLowerCase().contains(query) ||
          pasien['jenis_kelamin'].toString().toLowerCase().contains(query) ||
          pasien['nik'].toString().toLowerCase().contains(query);
    }).toList();
  }

  void deletePasien(String id) async {
    await FirebaseFirestore.instance.collection('pasien').doc(id).delete();
    fetchPasienList();
  }

  void openWhatsApp(String phone) async {
    String url = "https://wa.me/$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
