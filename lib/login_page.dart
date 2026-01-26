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

  bool _isLoginPasswordVisible = false;
  bool _isRegisterPasswordVisible = false;
  bool _isRegisterConfirmVisible = false;

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
  //           GİRİŞ YAP MODALI (GÜNCELLENMİŞ)
  void _showSignInModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // StatefulBuilder: Modal içindeki anlık değişimleri (göz ikonunu) algılamak için gerekli
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -5))
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
                    controller: _loginEmailController,
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

                  // --- Login Password (GÜNCELLENDİ) ---
                  TextField(
                    controller: _loginPasswordController,
                    obscureText: !_isLoginPasswordVisible, // Şifre gizli mi açık mı?
                    decoration: InputDecoration(
                      labelText: 'Password',
                      // Göz İkonu Butonu
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isLoginPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // setModalState: Sadece modalı yeniler
                          setModalState(() {
                            _isLoginPasswordVisible = !_isLoginPasswordVisible;
                          });
                        },
                      ),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
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
                        colors: [Color(0xFFC2185B), Color(0xFF880E4F), Color(0xFF560027)],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        // ... (Eski giriş kodların aynen buraya gelecek) ...
                        // Kodu kısaltmak için burayı özet geçiyorum, senin mevcut login fonksiyonun buraya kopyalanmalı.
                        bool success = await _authService.login(
                          _loginEmailController.text,
                          _loginPasswordController.text,
                        );
                        if (!context.mounted) return;
                        if (success) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);
                          Navigator.of(context).pop();
                          _anaSayfayaGit(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Giriş başarısız. Bilgileri kontrol edin.")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 160, vertical: 14),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  //           KAYIT OL (REGISTER) MODAL
  //           KAYIT OL (REGISTER) MODAL (GÜNCELLENMİŞ)
  void _showSignUpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -5))
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Your Account",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFBE2235)),
                    ),
                    SizedBox(height: 30),

                    // Full Name ve Email kısımları aynı...
                    TextField(
                      controller: _registerNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        // ... Diğer decoration ayarları aynı
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _registerEmailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        // ... Diğer decoration ayarları aynı
                      ),
                    ),
                    SizedBox(height: 20),

                    // --- Register Password (GÜNCELLENDİ) ---
                    TextField(
                      controller: _registerPasswordController,
                      obscureText: !_isRegisterPasswordVisible, // Değişken bağlandı
                      decoration: InputDecoration(
                        labelText: 'Password',
                        // Göz İkonu
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isRegisterPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setModalState(() {
                              _isRegisterPasswordVisible = !_isRegisterPasswordVisible;
                            });
                          },
                        ),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                      ),
                    ),
                    SizedBox(height: 20),

                    // --- Register Confirm Password (GÜNCELLENDİ) ---
                    TextField(
                      controller: _registerConfirmPasswordController,
                      obscureText: !_isRegisterConfirmVisible, // Değişken bağlandı
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        // Göz İkonu
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isRegisterConfirmVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setModalState(() {
                              _isRegisterConfirmVisible = !_isRegisterConfirmVisible;
                            });
                          },
                        ),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        floatingLabelStyle: TextStyle(color: Color(0xFFBE2235), fontWeight: FontWeight.bold, fontSize: 16),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFBE2235))),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Register Butonu (Aynı kalacak)
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Color(0xFFC2185B), Color(0xFF880E4F), Color(0xFF560027)],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 160, vertical: 14),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        onPressed: () async {
                          // ... (Senin mevcut register kodların buraya) ...
                          if (_registerPasswordController.text != _registerConfirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Şifreler uyuşmuyor!")));
                            return;
                          }
                          bool success = await _authService.register(
                            _registerNameController.text,
                            _registerEmailController.text,
                            _registerPasswordController.text,
                          );
                          if (success && context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Hesap başarıyla oluşturuldu!"), backgroundColor: Colors.green),
                            );
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Kayıt başarısız."), backgroundColor: Colors.red),
                            );
                          }
                        },
                        child: Text("SIGN UP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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