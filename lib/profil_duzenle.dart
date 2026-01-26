import 'dart:convert'; // Base64 işlemleri için gerekli
import 'dart:io';      // Dosya işlemleri için gerekli
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Telefon formatı için gerekli
import 'package:image_picker/image_picker.dart'; // Fotoğraf seçmek için gerekli
import 'package:task1/auth_service.dart'; // Senin auth servisin

class ProfilDuzenle extends StatefulWidget {
  const ProfilDuzenle({Key? key}) : super(key: key);

  @override
  State<ProfilDuzenle> createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  // Servis ve Araçlar
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();

  // Renkler
  final Color gradientStart = const Color(0xFFC2185B);
  final Color gradientEnd = const Color(0xFF880E4F);

  // Form Kontrolcüleri
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Durum Değişkenleri
  File? _selectedImage;        // Galeriden yeni seçilen fotoğraf
  String? _currentBase64Image; // Backend'den gelen mevcut fotoğraf
  bool _isPasswordVisible = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentData(); // Sayfa açılınca verileri çek
  }

  // --- 1. MEVCUT VERİLERİ ÇEKME ---
  Future<void> _loadCurrentData() async {
    final data = await _authService.getProfile();

    if (mounted) {
      setState(() {
        if (data != null) {
          _nameController.text = data['fullName'] ?? "";
          _emailController.text = data['email'] ?? "";
          _phoneController.text = data['phone'] ?? "";

          // Backend'den 'profileImage' anahtarıyla base64 string geldiğini varsayıyoruz
          _currentBase64Image = data['profileImage'];
        }
        _isLoading = false;
      });
    }
  }

  // --- 2. GALERİDEN FOTOĞRAF SEÇME ---
  // --- 2. GALERİDEN FOTOĞRAF SEÇME (Sıkıştırılmış) ---
  Future<void> _pickImage() async {
    try {
      // imageQuality: 50 -> Kaliteyi %50 düşür (Gözle görülür fark az olur ama dosya boyutu çok düşer)
      // maxWidth: 800 -> Fotoğrafın genişliğini maksimum 800 piksel yap
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Fotoğraf seçimi hatası: $e");
    }
  }

  // --- 3. VERİLERİ KAYDETME ---
  Future<void> _saveData() async {
    if (_isLoading) return; // Çift tıklamayı önle

    setState(() { _isLoading = true; });

    // Fotoğraf seçildiyse Base64 formatına çevir
    String? base64ImageToSend;
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      base64ImageToSend = base64Encode(imageBytes);
    }

    // Servise gönder
    bool success = await _authService.updateProfile(
      fullName: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text, // Boşsa backend değiştirmez
      base64Image: base64ImageToSend,     // Yeni fotoğraf varsa gönderilir
    );

    if (mounted) {
      setState(() { _isLoading = false; });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil başarıyla güncellendi!")),
        );
        Navigator.pop(context); // Sayfayı kapat
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Güncelleme sırasında bir hata oluştu.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Yükleniyor durumunda dönen çember göster
    if (_isLoading && _nameController.text.isEmpty) {
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

            // --- PROFİL FOTOĞRAFI ALANI ---
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: Colors.grey[300], // Boşken görünecek gri zemin
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: _getImageWidget(), // Hangi resmin görüneceğine karar veren fonksiyon
                    ),
                  ),
                  // Kamera İkonu
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage, // Tıklayınca galeri açılır
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
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- FORM ALANLARI ---
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

                  // Telefon (Sadece sayı ve max 11 karakter)
                  _buildTextField(
                    controller: _phoneController,
                    label: "Telefon Numarası",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Sadece rakam
                      LengthLimitingTextInputFormatter(11),   // Max 11 hane
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Şifre (Göz ikonlu)
                  _buildTextField(
                    controller: _passwordController,
                    label: "Yeni Şifre (Opsiyonel)",
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- KAYDET BUTONU ---
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
                  onPressed: _saveData,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
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

  // --- YARDIMCI: Hangi Resim Gösterilecek? ---
  Widget _getImageWidget() {
    // 1. Yeni fotoğraf seçildiyse onu göster
    if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      );
    }
    // 2. Backend'den gelen bir fotoğraf varsa (Base64) onu göster
    else if (_currentBase64Image != null && _currentBase64Image!.isNotEmpty) {
      try {
        return Image.memory(
          base64Decode(_currentBase64Image!),
          fit: BoxFit.cover,
          width: 120,
          height: 120,
          errorBuilder: (context, error, stackTrace) => _defaultAvatar(), // Hata olursa default
        );
      } catch (e) {
        return _defaultAvatar();
      }
    }
    // 3. Hiçbiri yoksa varsayılan boş avatarı göster
    else {
      return _defaultAvatar();
    }
  }

  // Varsayılan boş avatar (Instagram tarzı)
  Widget _defaultAvatar() {
    return Icon(
      Icons.person,
      size: 80,
      color: Colors.grey[500],
    );
  }

  // --- YARDIMCI: TextField Tasarımı ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
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
        inputFormatters: inputFormatters, // Formatlayıcılar buraya eklendi
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