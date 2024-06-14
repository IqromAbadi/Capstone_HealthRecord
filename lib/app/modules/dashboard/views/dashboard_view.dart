import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
          child: Column(
            children: [
              headerSection(context),
              imageSection(),
              menuSection(context),
              patientStatusSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerSection(BuildContext context) {
    return Container(
      color: Color(0xFF01CBEF),
      padding: EdgeInsets.fromLTRB(20, 20, 28.1, 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/vector.png',
                  width: 16,
                  height: 18.7,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Dr.Viandini',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Profil Saya'),
                  value: 'Profil Saya',
                ),
                PopupMenuItem(
                  child: Text('Faq'),
                  value: 'Faq',
                ),
                PopupMenuItem(
                  child: Text('Keluar'),
                  value: 'Keluar',
                ),
              ];
            },
            onSelected: (value) {
              // Handle ketika salah satu pilihan dipilih
              switch (value) {
                case 'Profil Saya':
                  Navigator.pushNamed(
                      context, '/profile'); // Navigasi ke halaman Profil
                  break;
                case 'Faq':
                  Navigator.pushNamed(
                      context, '/faq'); // Navigasi ke halaman FAQ
                  break;
                case 'Keluar':
                  Navigator.pushNamed(
                      context, '/faq'); // Navigasi ke halaman Keluar
                  break;
                default:
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: const Color.fromARGB(255, 241, 90, 90),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(19, 0, 19, 22),
      height: 136,
      child: PageView(
        children: [
          Image.asset(
            'assets/images/ruang1.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/ruang2.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/ruang3.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget menuSection(context) {
    return Container(
      margin: EdgeInsets.fromLTRB(19, 0, 19, 18),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0x9901CBEF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman pasien
                  Navigator.pushNamed(context, '/jadwalpraktik');
                },
                child: menuItem('Pasien', 'assets/images/pasienn.png'),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman rekam medis
                  Navigator.pushNamed(context, '/rekam_medis');
                },
                child: menuItem('Rekam Medis', 'assets/images/rekammediss.png'),
              ),
            ],
          ),
          SizedBox(height: 22.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman jadwal praktek
                  Navigator.pushNamed(context, '/jadwalpraktik');
                },
                child: menuItem('Jadwal Praktek', 'assets/images/jadwall.png'),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman antrian pasien
                  Navigator.pushNamed(context, '/antrian_pa');
                },
                child: menuItem('Antrian Pasien', 'assets/images/antriann.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14.2),
          width: 121.4,
          height: 117.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFC4C4C4),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(imagePath),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget patientStatusSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(19, 0, 19, 18),
      child: Column(
        children: [
          patientStatusItem(
              'Sudah Terdaftar', '0 Pasien', 'assets/images/vector.png'),
          patientStatusItem(
              'Belum Dilayani', '0 Pasien', 'assets/images/vector.png'),
          patientStatusItem(
              'Sudah Dilayani', '0 Pasien', 'assets/images/vector.png'),
        ],
      ),
    );
  }

  Widget patientStatusItem(String status, String count, String iconPath) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF01CBEF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 14.7),
            width: 46.5,
            height: 46,
            child: Image.asset(iconPath),
          ),
          Text(
            '$status :',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 15.5),
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
