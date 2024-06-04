import 'package:get/get.dart';

import '../modules/detail_pemeriksaan/bindings/detail_pemeriksaan_binding.dart';
import '../modules/detail_pemeriksaan/views/detail_pemeriksaan_view.dart';
import '../modules/rekam_medis/bindings/rekam_medis_binding.dart';
import '../modules/rekam_medis/views/rekam_medis_view.dart';
import '../modules/slice_rekam_medis/bindings/slice_rekam_medis_binding.dart';
import '../modules/slice_rekam_medis/views/slice_rekam_medis_view.dart';
import '../modules/tambah_pemeriksaan/bindings/tambah_pemeriksaan_binding.dart';
import '../modules/tambah_pemeriksaan/views/tambah_pemeriksaan_view.dart';
import '../modules/ubah_pemeriksaan/bindings/ubah_pemeriksaan_binding.dart';
import '../modules/ubah_pemeriksaan/views/ubah_pemeriksaan_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.REKAM_MEDIS;

  static final routes = [
    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () => const RekamMedisView(),
      binding: RekamMedisBinding(),
    ),
    GetPage(
      name: _Paths.SLICE_REKAM_MEDIS,
      page: () => const SliceRekamMedisView(),
      binding: SliceRekamMedisBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMERIKSAAN,
      page: () => const DetailPemeriksaanView(),
      binding: DetailPemeriksaanBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_PEMERIKSAAN,
      page: () => const UbahPemeriksaanView(),
      binding: UbahPemeriksaanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PEMERIKSAAN,
      page: () => const TambahPemeriksaanView(),
      binding: TambahPemeriksaanBinding(),
    ),
  ];
}
