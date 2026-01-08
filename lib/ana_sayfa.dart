import 'package:flutter/material.dart';
import 'package:task1/login_page.dart';
class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ana Sayfa"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24,
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body:Column(
        children: [
          Text("Hoş geldiniz"),
          Center(
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[300],
                padding: EdgeInsets.symmetric(horizontal: 64, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
              onPressed: (){
                _cikisYap(context);
              },
              child: Text("Log Out",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _cikisYap(BuildContext context){
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (BuildContext context){
        return LoginPage();
      },
    );
    Navigator.pushReplacement(context, sayfaYolu);
  }
}