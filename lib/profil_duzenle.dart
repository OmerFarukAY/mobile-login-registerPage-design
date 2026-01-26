import 'package:flutter/material.dart';
import 'package:task1/auth_service.dart'; // DİKKAT: AuthService import edildi
import 'package:flutter/services.dart'; // Bu kütüphane input formatters için gerekli

class ProfilDuzenle extends StatefulWidget {
  const ProfilDuzenle({Key? key}) : super(key: key);

  @override
  State<ProfilDuzenle> createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  // UserService yerine AuthService tanımladık
  final AuthService _authService = AuthService();

  final Color gradientStart = const Color(0xFFC2185B);
  final Color gradientEnd = const Color(0xFF880E4F);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  // --- 1. HATA DÜZELTME: Verileri Çekme ---
  Future<void> _loadCurrentData() async {
    // getUserData() -> getProfile() oldu
    final data = await _authService.getProfile();

    if (mounted) {
      setState(() {
        if (data != null) {
          // Backend field isimlerine dikkat (fullName)
          _nameController.text = data['fullName'] ?? "";
          _emailController.text = data['email'] ?? "";
          _phoneController.text = data['phone'] ?? "";
          // Şifre güvenlik gereği genelde backend'den boş gelir veya gelmez
          _passwordController.text = "";
        }
        _isLoading = false;
      });
    }
  }

  // --- 2. HATA DÜZELTME: Verileri Kaydetme ---
  Future<void> _saveData() async {
    setState(() {
      _isLoading = true;
    });

    // saveUserData() -> updateProfile() oldu
    bool success = await _authService.updateProfile(
      fullName: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text, // Şifre boşsa backend işlemeyebilir (AuthService mantığına göre)
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil başarıyla güncellendi!")),
        );
        Navigator.pop(context); // Başarılıysa sayfayı kapat
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Güncelleme başarısız oldu.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Veriler yüklenene kadar loading göster
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Profili Düzenle"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [gradientStart, gradientEnd],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: gradientStart,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: "Ad Soyad",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    label: "E-Posta",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _phoneController,
                    label: "Telefon Numarası",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone, // Klavye sadece sayıları açar
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Sadece rakam girilsin
                      LengthLimitingTextInputFormatter(11),   // Maksimum 11 karakter (05XXXXXXXXX)
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    label: "Şifre",
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [gradientStart, gradientEnd],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gradientStart.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _saveData, // Kaydet fonksiyonunu çağır
                  child: const Text(
                    "Değişiklikleri Kaydet",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters, // <-- YENİ EKLENEN PARAMETRE
  }) {
    return Container(
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
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters, // <-- BURAYA EKLENDİ
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [gradientStart, gradientEnd],
              ).createShader(bounds);
            },
            child: Icon(icon, color: Colors.white),
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}