import 'package:flutter/material.dart';
import 'package:task1/ana_sayfa.dart';
import 'auth_service.dart'; // AuthService dosyanı import etmeyi unutma!
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Giriş Yap  İçin
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  // Kayıt Ol  İçin
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _registerConfirmPasswordController = TextEditingController();

  // Servis
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(context),
      extendBodyBehindAppBar: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFF560027),
              Color(0xFF880E4F),
              Color(0xFFC2185B),
            ],
          ),
        ),
        child: SingleChildScrollView( // Klavye açılınca taşma olmasın diye
          child: Column(
            children: [
              SizedBox(height: 170),
              Image.asset(
                'assets/beyaz_yazisiz_logo_arkaplansiz.png',
                width: 150,
                height: 150,
                color: Colors.white,
              ),
              SizedBox(height: 100),
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 40),

              // --- ANA EKRAN SIGN IN BUTONU ---
              Container(
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
                  onPressed: () {
                    _showSignInModal(context); // Giriş Modalını Aç
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 14),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(color: Colors.white, width: 1.0),
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

              SizedBox(height: 24),

              // --- ANA EKRAN SIGN UP BUTONU ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 14),
                ),
                onPressed: () {
                  _showSignUpModal(context); // Kayıt Modalını Aç
                },
                child: Text(
                  "SIGN UP",
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
      ),
    );
  }

  //           GİRİŞ YAP MODALI
  void _showSignInModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(0, -5))
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Sign in!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBE2235),
                ),
              ),
              SizedBox(height: 30),

              // --- Login E-mail ---
              TextField(
                controller: _loginEmailController, // Controller Bağlandı
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  floatingLabelStyle: TextStyle(
                      color: Color(0xFFBE2235),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                ),
              ),
              SizedBox(height: 20),

              // --- Login Password ---
              TextField(
                controller: _loginPasswordController, // Controller Bağlandı
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.lock, color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  floatingLabelStyle: TextStyle(
                      color: Color(0xFFBE2235),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                ),
              ),
              SizedBox(height: 30),

              // --- SIGN IN BUTONU ---
              Container(
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
                  onPressed: () async {
                    print("1. Butona basıldı, servise gidiliyor...");

                    // Servise Git
                    bool success = await _authService.login(
                      _loginEmailController.text,
                      _loginPasswordController.text,
                    );

                    print("2. Servisten cevap geldi. Sonuç: $success");

                    if (!context.mounted) {
                      print("3. HATA: Ekran (Context) artık yok, işlem iptal.");
                      return;
                    }

                    if (success) {
                      print("4. Giriş Başarılı! Hafızaya kaydediliyor ve panel kapatılıyor...");

                      // Giriş başarılı olduğu an, telefon hafızasına "Bu kullanıcı giriş yaptı" diye not düşüyoruz.
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);

                      Navigator.of(context).pop();

                      print("5. Panel kapandı, Ana Sayfaya gidiliyor.");
                      _anaSayfayaGit(context);

                    } else {
                      print("4. Giriş BAŞARISIZ olduğu için panel KAPANMADI.");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Giriş başarısız. Bilgileri kontrol edin.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 160, vertical: 14), // Padding biraz ayarlandı taşmasın diye
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(color: Colors.white, width: 1.0),
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
            ],
          ),
        );
      },
    );
  }
  //           KAYIT OL (REGISTER) MODAL
  void _showSignUpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.70, // Biraz yükselttim sığsın diye
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(0, -5))
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView( // Klavye açılınca taşmasın
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBE2235),
                  ),
                ),
                SizedBox(height: 30),

                // --- Register Full Name ---
                TextField(
                  controller: _registerNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    suffixIcon: Icon(Icons.check, color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                  ),
                ),
                SizedBox(height: 20),

                // --- Register E-mail ---
                TextField(
                  controller: _registerEmailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    suffixIcon: Icon(Icons.check, color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                  ),
                ),
                SizedBox(height: 20),

                // --- Register Password ---
                TextField(
                  controller: _registerPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.lock, color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                  ),
                ),
                SizedBox(height: 20),

                // --- Register Confirm Password ---
                TextField(
                  controller: _registerConfirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: Icon(Icons.lock, color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                  ),
                ),
                SizedBox(height: 30),

                // --- REGISTER BUTONU (BACKEND BAĞLANTILI) ---
                Container(
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
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 14), // Padding ayarlandı
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      side: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    onPressed: () async {
                      // Şifreler Eşleşiyor mu Kontrolü
                      if (_registerPasswordController.text != _registerConfirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifreler uyuşmuyor!")));
                        return;
                      }

                      // Servise Git
                      bool success = await _authService.register(
                        _registerNameController.text,
                        _registerEmailController.text,
                        _registerPasswordController.text,
                      );

                      if (success) {
                        if (context.mounted) {
                          Navigator.pop(context); // Paneli kapat
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Hesap başarıyla oluşturuldu!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Kayıt başarısız."), backgroundColor: Colors.red),
                          );
                        }
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _anaSayfayaGit(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AnaSayfa()),
    );
  }
}