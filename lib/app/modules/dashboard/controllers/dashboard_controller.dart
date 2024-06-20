import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthrecord/app/modules/antrianpasien/controllers/antrianpasien_controller.dart';

class DashboardController extends GetxController {
  var sudahTerdaftarCount = '0 Pasien'.obs;
  var belumDilayaniCount = '0 Pasien'.obs;
  var sudahDilayaniCount = '0 Pasien'.obs;
  var name = ''.obs;
  var profileImageUrl = ''.obs; // Menambahkan variabel profileImageUrl
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatientStatus();
    fetchProfileData();
    ; // Tambahkan ini
    updateCounts();
  }

  void fetchProfileData() async {
    try {
      isLoading(true);
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('profile')
          .doc('38NjyRltFiX0ezjiFMUe') // ganti dengan user ID yang sesuai
          .get();

      name.value = userProfile['nama'];
      profileImageUrl.value =
          userProfile['profileImageUrl']; // Mengambil URL gambar profil
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void fetchPatientStatus() async {
    var jakartaTime = DateTime.now().toUtc().add(Duration(hours: 7));
    var startOfDay =
        DateTime(jakartaTime.year, jakartaTime.month, jakartaTime.day, 0, 0, 0);
    var endOfDay = DateTime(
        jakartaTime.year, jakartaTime.month, jakartaTime.day, 23, 59, 59);

    try {
      var antrianCollection = FirebaseFirestore.instance.collection('antrian');

      var belumDilayaniQuery = await antrianCollection
          .where('status', isEqualTo: 'Belum Dilayani')
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .orderBy('timestamp')
          .get();
      belumDilayaniCount.value = '${belumDilayaniQuery.size} Pasien';

      var sudahDilayaniQuery = await antrianCollection
          .where('status', isEqualTo: 'Sudah Dilayani')
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .orderBy('timestamp')
          .get();
      sudahDilayaniCount.value = '${sudahDilayaniQuery.size} Pasien';

      var pasienTerdaftarHariIni = <String>{};
      var antrianQuery = await antrianCollection
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .get();

      antrianQuery.docs.forEach((antrianDoc) {
        var pasienId = antrianDoc['pasien_id'];
        if (pasienId != null) {
          pasienTerdaftarHariIni.add(pasienId);
        }
      });

      sudahTerdaftarCount.value = '${pasienTerdaftarHariIni.length} Pasien';
    } catch (e) {
      print('Error fetching patient status: $e');
    }
  }

  void updateCounts() {
    final AntrianpasienController antrianpasienController =
        Get.find<AntrianpasienController>();

    ever(antrianpasienController.antrianList, (antrianList) {
      int belumDilayani = 0;
      int sudahDilayani = 0;

      for (var antrian in antrianList) {
        var status = antrian['status'];
        if (status == 'Belum Dilayani') {
          belumDilayani++;
        } else if (status == 'Sudah Dilayani') {
          sudahDilayani++;
        }
      }

      belumDilayaniCount.value = '$belumDilayani Pasien';
      sudahDilayaniCount.value = '$sudahDilayani Pasien';
    });
  }
}
