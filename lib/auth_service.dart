import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Backend URL
  final String baseUrl = "https://phyllocladous-obstetrically-kathryn.ngrok-free.dev";

  // --- KAYIT OL (REGISTER) ---
  Future<bool> register(String fullName, String email, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName, // Backend'in beklediği parametre adı
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print("✅ Kayıt Başarılı");
        return true;
      } else {
        print("❌ Kayıt Hatası: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Bağlantı Hatası: $e");
      return false;
    }
  }

  // --- GİRİŞ YAP (LOGIN) ---
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // ÖNEMLİ: Backend'den gelen Token'ı ve ID'yi kaydediyoruz.
        // Backend yanıt yapına göre burayı düzenle (örn: data['token'] veya data['accessToken'])
        String token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setBool('isLoggedIn', true);

        print("✅ Giriş Başarılı. Token Kaydedildi.");
        return true;
      } else {
        print("❌ Giriş Başarısız: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Bağlantı Hatası: $e");
      return false;
    }
  }

  // --- PROFİL BİLGİLERİNİ GETİR ---
  Future<Map<String, dynamic>?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return null;

    // Backend endpoint'in '/api/user/profile' veya '/api/auth/me' olabilir.
    // Bunu backend dokümantasyonuna göre kontrol etmelisin.
    final url = Uri.parse('$baseUrl/api/user/me');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token'ı gönderiyoruz
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ Profil Çekilemedi: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Profil Hatası: $e");
      return null;
    }
  }

  // --- PROFİL GÜNCELLE ---
  // --- PROFİL GÜNCELLE (FOTOĞRAF DESTEKLİ) ---
  Future<bool> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    String? password,
    String? base64Image, // YENİ: Fotoğraf verisi (Base64 string olarak)
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return false;

    final url = Uri.parse('$baseUrl/api/user/update');

    Map<String, dynamic> bodyData = {
      'fullName': fullName,
      'email': email,
      'phone': phone,
    };

    if (password != null && password.isNotEmpty) {
      bodyData['password'] = password;
    }

    // YENİ: Eğer fotoğraf seçildiyse body'ye ekle
    if (base64Image != null) {
      bodyData['profileImage'] = base64Image;
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("❌ Güncelleme Hatası: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Hata: $e");
      return false;
    }
  }

  // --- ÇIKIŞ YAP ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Token ve diğer verileri siler
  }
}