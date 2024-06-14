import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JadwalpraktikController extends GetxController {
  RxList<JadwalPraktik> jadwalPraktik = <JadwalPraktik>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadJadwalPraktik();
  }

  void loadJadwalPraktik() {
    var storedJadwal = box.read<List>('jadwalPraktik');
    if (storedJadwal != null) {
      jadwalPraktik.value = storedJadwal
          .map((e) => JadwalPraktik.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      getJadwalPraktik();
    }
  }

  void getJadwalPraktik() {
    List<JadwalPraktik> jadwalList = [
      JadwalPraktik(
        hari: 'Senin',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
      JadwalPraktik(
        hari: 'Selasa',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
      JadwalPraktik(
        hari: 'Rabu',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
      JadwalPraktik(
        hari: 'Kamis',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
      JadwalPraktik(
        hari: 'Jumat',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
      JadwalPraktik(
        hari: 'Sabtu',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
      JadwalPraktik(
        hari: 'Minggu',
        waktuPraktik: [
          WaktuPraktik(jamPraktik: '05:30 - 21:30'),
        ],
      ),
    ];

    jadwalPraktik.value = jadwalList;
    saveJadwalPraktik();
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
