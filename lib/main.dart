import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/login_page.dart';
import 'package:task1/ana_sayfa.dart';

void main() {
  // Hata riskini sıfırladık.
  runApp(const AnaUygulama());
}

class AnaUygulama extends StatelessWidget {
  const AnaUygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      // Karar Verici
      home: const AcilisKontrolcusu(),
    );
  }
}

class AcilisKontrolcusu extends StatelessWidget {
  const AcilisKontrolcusu({super.key});

  // Hafızayı okuyan fonksiyon
  Future<bool> _girisKontrol() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _girisKontrol(), // Hafızayı okumaya başla
      builder: (context, snapshot) {
        // 1. Durum: Henüz okuma bitmediyse (Yükleniyor...)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF560027)),
            ),
          );
        }

        // 2. Durum: Okuma bitti, sonuç ne?
        if (snapshot.hasData && snapshot.data == true) {
          // Giriş yapılmış -> Ana Sayfaya git
          return const AnaSayfa();
        } else {
          // Giriş yapılmamış -> Login Sayfasına git
          return const AnaSayfa();
        }
      },
    );
  }
}