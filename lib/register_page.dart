import 'package:flutter/material.dart';
import 'login_page.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 150,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                prefixIcon: Icon(Icons.face),
                filled: true,
                fillColor: Colors.green[100],
              ),
            ),
          ),
          SizedBox(height: 16,),
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
                fillColor: Colors.green[100],
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
                fillColor: Colors.green[100],
              ),
            ),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                prefixIcon: Icon(Icons.lock),
                filled: true,
                fillColor: Colors.green[100],
              ),
            ),
          ),
          SizedBox(height: 24,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[300],
              padding: EdgeInsets.symmetric(horizontal: 64, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            onPressed: (){
              _register(context);
            },
            child: Text("Register",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context){
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
        builder: (BuildContext context){
          return LoginPage();
        }
    );
    Navigator.pushReplacement(context, sayfaYolu);
  }
}
