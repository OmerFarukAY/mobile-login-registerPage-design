import 'dart:convert'; // <--- 1. BU EKLENDİ (Base64 için şart)
import 'package:flutter/material.dart';
import 'package:task1/ayarlar_sayfasi.dart';
import 'package:task1/bildirimler_sayfasi.dart';
import 'package:task1/login_page.dart';
import 'package:task1/profil_duzenle.dart';
import 'package:task1/auth_service.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  final AuthService _authService = AuthService();

  String name = "Yükleniyor...";
  String email = "";
  String? profileImage; // <--- 2. BU DEĞİŞKEN EKLENDİ

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await _authService.getProfile();

    if (mounted) {
      setState(() {
        if (data != null) {
          name = data['fullName'] ?? "Kullanıcı";
          email = data['email'] ?? "";
          // Backend'den gelen 'profileImage' verisini alıyoruz
          profileImage = data['profileImage']; // <--- 3. VERİ ÇEKİLDİ
        } else {
          name = "Giriş Yapılmadı";
          email = "";
        }
      });
    }
  }

  final Color gradientEnd = const Color(0xFF880E4F);
  final Color gradientStart = const Color(0xFFC2185B);
  final Color scaffoldBg = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: _HeaderCurveClipper(),
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [gradientEnd, gradientStart],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 20,
                  child: Image.asset(
                    'assets/beyaz_yazisiz_logo_arkaplansiz.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                Positioned(
                  bottom: -60,
                  // Değişkeni fonksiyona gönderiyoruz
                  child: _buildProfileImage(profileImage),
                ),
              ],
            ),
            const SizedBox(height: 70),

            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilDuzenle()),
                  );
                  _loadUserData(); // Dönüşte sayfayı yenile
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: gradientStart, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(
                  "Profili Düzenle",
                  style: TextStyle(
                    color: gradientStart,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            // ... Menü kodları (Aynı) ...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuCard(context, icon: Icons.settings, title: "Ayarlar",onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AyarlarSayfasi()),
                    );
                  },),
                  _buildMenuCard(context, icon: Icons.notifications, title: "Bildirimler", onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BildirimlerSayfasi()),
                    );
                  }),
                  _buildMenuCard(context, icon: Icons.security, title: "Güvenlik", onTap: () {}),
                  _buildMenuCard(context, icon: Icons.help, title: "Yardım ve Destek", onTap: () {}),
                ],
              ),
            ),

            // ... Çıkış butonu kodları (Aynı) ...
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFC2185B),
                      Color(0xFF880E4F),
                      Color(0xFF560027),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Çıkış Yap",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // --- 4. GÜNCELLENMİŞ PROFİL FOTOĞRAFI WIDGET'I ---
  Widget _buildProfileImage(String? base64String) {
    ImageProvider? imageProvider;

    // Fotoğraf verisi varsa decode et
    if (base64String != null && base64String.isNotEmpty) {
      try {
        imageProvider = MemoryImage(base64Decode(base64String));
      } catch (e) {
        print("Resim decode hatası: $e");
        imageProvider = null;
      }
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        color: Colors.grey[300], // Boşken gri zemin
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[300],
        // Resim varsa göster, yoksa null
        backgroundImage: imageProvider,
        // Resim yoksa ikon göster
        child: (imageProvider == null)
            ? Icon(Icons.person, size: 80, color: Colors.grey[500])
            : null,
      ),
    );
  }

  // _buildMenuCard ve _HeaderCurveClipper kodları aynı kalacak...
  Widget _buildMenuCard(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [gradientStart, gradientEnd],
            ).createShader(bounds);
          },
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }
}

class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}