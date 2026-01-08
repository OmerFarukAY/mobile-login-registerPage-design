import 'dart:convert';
import 'package:http/http.dart' as http;

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
          'fullName': fullName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print("✅ Kayıt Başarılı: ${response.body}");
        return true; // Başarılı
      } else {
        print("❌ Hata: ${response.body}");
        return false; // Başarısız
      }
    } catch (e) {
      print("Bağlantı Hatası: $e");
      return false;
    }
  }

  // --- GİRİŞ YAP ---
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
        print("✅ Giriş Başarılı: ${response.body}");
        // İleride token'ı burada kaydedebilirsin
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
}