import 'package:flutter/material.dart';
import 'package:task1/ana_sayfa.dart';
import 'package:task1/register_page.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildBody(context),
      extendBodyBehindAppBar: true,
    );
  }
  Widget _buildBody(BuildContext context){
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            // Geçişin yönü: Yukarıdan aşağıya (veya topLeft -> bottomRight yapılabilir)
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,

            // Renkler: Görseldeki koyu bordodan canlı kırmızıya
            colors: [
              Color(0xFF560027), // En üstteki koyu (bordo/siyahımsı kırmızı)
              Color(0xFF880E4F), // Orta ton
              Color(0xFFC2185B),

              // En alttaki biraz daha açık/canlı ton
            ],
            // Renklerin kaplayacağı alan oranları (isteğe bağlı)

          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 170,),
            Image.asset(
              'assets/beyaz_yazisiz_logo_arkaplansiz.png', // Dosya ismin neyse onu yaz
              width: 100,        // Genişlik
              height: 100,       // Yükseklik
              color: Colors.white, // İPUCU: Eğer resmin siyahsa, bu kodla onu beyaza boyayabilirsin!
            ),
            SizedBox(height: 100,),
            Text("Welcome",
            style:TextStyle(fontSize: 30,
            fontWeight: FontWeight. bold,
              color: Colors.white
            ),
            ),
            SizedBox(height: 40,),

            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // Kenarları yuvarlatma
                gradient:  LinearGradient(
                  colors: [
                    Color(0xFFC2185B), // Açık ton
                    Color(0xFF880E4F), // Orta ton
                    Color(0xFF560027), // Koyu ton
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  _girisYap(context);
                },

                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 14),
                  backgroundColor: Colors.transparent, // Arka planı şeffaf yapıyoruz ki container görünsün
                  shadowColor: Colors.transparent, // Gölgeyi siliyoruz
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: BorderSide(
                    color: Colors.white, // Çerçevenin rengi
                    width: 1.0,          // Çerçevenin kalınlığı
                  ),
                ),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 14),
              ),
              onPressed: (){
                _register(context);
              },
              child: Text("SIGN UP",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _girisYap(BuildContext context){
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (BuildContext context){
        return AnaSayfa();
      },
    );
    Navigator.pushReplacement(context, sayfaYolu);
  }

  void _register(BuildContext context){
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
        builder: (BuildContext context){
          return RegisterPage();
        }
    );
    Navigator.pushReplacement(context, sayfaYolu);
  }
}
