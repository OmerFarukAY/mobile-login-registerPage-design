import 'package:flutter/material.dart';
import 'package:task1/ana_sayfa.dart';
import 'package:task1/register_page.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Geçişin yönü: Yukarıdan aşağıya (veya topLeft -> bottomRight yapılabilir)
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,

            // Renkler: Görseldeki koyu bordodan canlı kırmızıya
            colors: [
              Color(0xFF560027), // En üstteki koyu (bordo/siyahımsı kırmızı)
              Color(0xFF880E4F), // Orta ton
              Color(0xFFC2185B), // En alttaki biraz daha açık/canlı ton
            ],
            // Renklerin kaplayacağı alan oranları (isteğe bağlı)
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 150,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.purple[100],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.purple[100],
                ),
              ),
            ),
            SizedBox(height: 24,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF560027),
                padding: EdgeInsets.symmetric(horizontal: 64, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              onPressed: (){
                _girisYap(context);
              },
              child: Text("Sign In",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            SizedBox(height: 24,),
            Text("Hesabınız yok mu"),
            SizedBox(height: 16,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF560027),
                padding: EdgeInsets.symmetric(horizontal: 64, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
              onPressed: (){
                _register(context);
              },
              child: Text("Sign Up",
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
