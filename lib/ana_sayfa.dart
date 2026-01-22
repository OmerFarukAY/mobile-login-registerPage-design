import 'package:flutter/material.dart';
import 'package:task1/ayarlar_sayfasi.dart';
import 'package:task1/bildirimler_sayfasi.dart';
import 'package:task1/favoriler_sayfasi.dart';
import 'package:task1/hakkimizda_sayfasi.dart';
import 'package:task1/iletisim_sayfasi.dart';
import 'package:task1/login_page.dart';
import 'package:task1/profil_sayfasi.dart';
import 'package:task1/sepet_Sayfasi.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnaSayfa(),
  ));
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);
  // Gradyan renklerini tanımlayalım
  final Color gradientStart = const Color(0xFF560027); // Koyu Pembe
  final Color gradientEnd = const Color(0xFFC2185B);   // Koyu Mor

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // Ana gövde rengi açık gri/beyaz
      backgroundColor: Colors.grey[100],
      // Drawer Menu
      drawer: Drawer(
          child:
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Opsiyonel: Menü Başlığı (Profil vs.)
                    UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                      accountName: Text("Ömer Faruk"),
                      accountEmail: Text("omer@ornek.com"),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text("ÖF", style: TextStyle(fontSize: 24.0)),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [gradientStart, gradientEnd],
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    ListTile(
                      leading: _buildIconsColor(Icons.shopping_cart, "Sepet"),
                      title: Text('Sepet'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SepetSayfasi()),
                        );
                      },
                    ),
                    ListTile(
                      leading: _buildIconsColor(Icons.favorite, "Favoriler"),
                      title: Text('Favoriler'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavorilerSayfasi()),
                        );
                      },
                    ),
                    ListTile(
                      leading: _buildIconsColor(Icons.notifications, "Bildirimler"),
                      title: Text('Bildirimler'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BildirimlerSayfasi()),
                        );
                      },
                    ),
                    ListTile(
                      leading: _buildIconsColor(Icons.person, "Profil"),
                      title: Text('Profil'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilSayfasi()),
                        );
                      },
                    ),
                    ListTile(
                      leading: _buildIconsColor(Icons.info, "Hakkımızda"),
                      title: Text('Hakkımızda'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HakkimizdaSayfasi()),
                        );
                      },
                    ),
                    ListTile(
                      leading: _buildIconsColor(Icons.headset_mic, "İletişim"),
                      title: Text('İletişim'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => IletisimSayfasi()),
                        );
                      },
                    ),
                    ListTile(
                      leading:_buildIconsColor(Icons.settings, "Ayarlar"),
                      title: Text('Ayarlar'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AyarlarSayfasi()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey),
              ListTile(
                leading:_buildIconsColor(Icons.exit_to_app,"Çıkış Yap"),
                title: Text("Çıkış Yap"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              SizedBox(height: 25),
            ],
          ),
      ),
      body: Stack(
        children: [
          //ARKADAKİ GRADYAN ALANI
          Container(
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [gradientStart, gradientEnd],
              ),
              //Alt köşeleri yuvarlatma
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // --- KATMAN 2: ÖN PLANDAKİ İÇERİK ---
          SafeArea(
            child: Column(
              children: [
                // 1. Özel AppBar (Gradyanın üzerinde)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menü İkonu (Drawer'ı açar)
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.white, size: 28),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      // Logo (Buraya kendi logonuzu koyun)
                      Image.asset(
                        'assets/beyaz_yazisiz_logo_arkaplansiz.png',
                        width: 100,
                        height: 100,
                      ),
                      // Arama İkonu
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SepetSayfasi()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconsColor(IconData icon, String title) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // İkon için gradyan efekti
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [gradientStart, gradientEnd],
              ).createShader(bounds);
            },
            child: Icon(icon, size: 24, color: Colors.white),
          ),

        ],
      ),
    );
  }
}