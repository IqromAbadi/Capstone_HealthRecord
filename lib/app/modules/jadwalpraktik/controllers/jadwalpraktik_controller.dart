import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalpraktikController extends GetxController {
  RxList<JadwalPraktik> jadwalPraktik = <JadwalPraktik>[].obs;
  final box = GetStorage();
  var name = ''.obs;
  var profileImageUrl = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadJadwalPraktik();
    fetchProfileData();
  }

  void loadJadwalPraktik() {
    var storedJadwal = box.read<List>('jadwalPraktik');
    if (storedJadwal != null) {
      jadwalPraktik.value = storedJadwal
          .map((e) => JadwalPraktik.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      getJadwalPraktikFromFirestore(); // Ganti dengan panggilan Firestore
    }
  }

  void fetchProfileData() {
    isLoading(true);
    FirebaseFirestore.instance
        .collection('profile')
        .doc('38NjyRltFiX0ezjiFMUe') // Ganti dengan user ID yang sesuai
        .snapshots()
        .listen((userProfile) {
      if (userProfile.exists) {
        name.value = userProfile['nama'];
        profileImageUrl.value = userProfile['profileImageUrl'];
      }
      isLoading(false);
    });
  }

  void getJadwalPraktikFromFirestore() {
    FirebaseFirestore.instance
        .collection('jadwal_praktik')
        .snapshots()
        .listen((querySnapshot) {
      List<JadwalPraktik> jadwalList = [];
      querySnapshot.docs.forEach((doc) {
        var jadwal = JadwalPraktik.fromJson(doc.data());
        jadwalList.add(jadwal);
      });
      jadwalPraktik.value = jadwalList;
      saveJadwalPraktik(); // Simpan di GetStorage setelah mendapatkan dari Firestore
    });
  }

  void saveJadwalPraktik() {
    var jadwalList = jadwalPraktik.map((e) => e.toJson()).toList();
    box.write('jadwalPraktik', jadwalList);
  }

  void updateJamPraktik(int hariIndex, int waktuIndex, String jamPraktik) {
    if (hariIndex < jadwalPraktik.length &&
        waktuIndex < jadwalPraktik[hariIndex].waktuPraktik.length) {
      jadwalPraktik[hariIndex].waktuPraktik[waktuIndex].jamPraktik = jamPraktik;
      jadwalPraktik.refresh();
      saveJadwalPraktik();
    }
  }
}

class JadwalPraktik {
  final String hari;
  final List<WaktuPraktik> waktuPraktik;

  JadwalPraktik({required this.hari, required this.waktuPraktik});

  factory JadwalPraktik.fromJson(Map<String, dynamic> json) => JadwalPraktik(
        hari: json['hari'],
        waktuPraktik: (json['waktuPraktik'] as List)
            .map((e) => WaktuPraktik.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'hari': hari,
        'waktuPraktik': waktuPraktik.map((e) => e.toJson()).toList(),
      };
}

class WaktuPraktik {
  String jamPraktik;

  WaktuPraktik({required this.jamPraktik});

  factory WaktuPraktik.fromJson(Map<String, dynamic> json) => WaktuPraktik(
        jamPraktik: json['jamPraktik'],
      );

  Map<String, dynamic> toJson() => {
        'jamPraktik': jamPraktik,
      };
}
