import 'package:flutter/material.dart';
import 'package:task1/auth_service.dart';
import 'package:task1/ayarlar_sayfasi.dart';
import 'package:task1/bildirimler_sayfasi.dart';
import 'package:task1/favoriler_sayfasi.dart';
import 'package:task1/hakkimizda_sayfasi.dart';
import 'package:task1/iletisim_sayfasi.dart';
import 'package:task1/login_page.dart';
import 'package:task1/profil_sayfasi.dart';
import 'package:task1/sepet_Sayfasi.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnaSayfa(),
  ));
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);
  // Gradyan renklerini tanımlayalım
  final Color gradientStart = const Color(0xFF560027); // Koyu Pembe
  final Color gradientEnd = const Color(0xFFC2185B);   // Koyu Mor

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // Ana gövde rengi açık gri/beyaz
      backgroundColor: Colors.grey[100],
      // Drawer Menu
      drawer: Drawer(
        child:
        Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Opsiyonel: Menü Başlığı (Profil vs.)
                  // FutureBuilder tipini <Map<String, dynamic>?> olarak düzelttik
                  // Drawer Başlığı
                  FutureBuilder<Map<String, dynamic>?>(
                    future: AuthService().getProfile(),
                    builder: (context, snapshot) {
                      String name = "Misafir";
                      String email = "misafir@ornek.com";

                      if (snapshot.hasData && snapshot.data != null) {
                        name = snapshot.data!['fullName'] ?? "Kullanıcı";
                        email = snapshot.data!['email'] ?? "";
                      }

                      // UserAccountsDrawerHeader YERİNE DrawerHeader kullanıyoruz
                      return DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero, // İç boşluğu sıfırladık ki gradyan tam dolsun
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [gradientStart, gradientEnd],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Dikeyde Ortala
                            crossAxisAlignment: CrossAxisAlignment.center, // Yatayda Ortala
                            children: [
                              // 1. Profil Fotoğrafı
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 3), // Beyaz çerçeve
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      )
                                    ]
                                ),
                                child: const CircleAvatar(
                                  radius: 40, // Fotoğraf büyüklüğü
                                  backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                                  backgroundColor: Colors.white,
                                ),
                              ),

                              // 2. İsim
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // 3. E-posta (Biraz boşluk bırakarak)
                              const SizedBox(height: 5),
                              Text(
                                email,
                                style: const TextStyle(
                                  color: Colors.white70, // Hafif şeffaf beyaz
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 25,),
                  ListTile(
                    leading: _buildIconsColor(Icons.shopping_cart, "Sepet"),
                    title: Text('Sepet'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SepetSayfasi()),
                      );
                    },
                  ),
                  ListTile(
                    leading: _buildIconsColor(Icons.favorite, "Favoriler"),
                    title: Text('Favoriler'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavorilerSayfasi()),
                      );
                    },
                  ),
                  ListTile(
                    leading: _buildIconsColor(Icons.notifications, "Bildirimler"),
                    title: Text('Bildirimler'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BildirimlerSayfasi()),
                      );
                    },
                  ),
                  ListTile(
                    leading: _buildIconsColor(Icons.person, "Profil"),
                    title: Text('Profil'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilSayfasi()),
                      );
                    },
                  ),
                  ListTile(
                    leading: _buildIconsColor(Icons.info, "Hakkımızda"),
                    title: Text('Hakkımızda'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HakkimizdaSayfasi()),
                      );
                    },
                  ),
                  ListTile(
                    leading: _buildIconsColor(Icons.help, "Yardım ve Destek"),
                    title: Text('Yardım ve Destek'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IletisimSayfasi()),
                      );
                    },
                  ),
                  ListTile(
                    leading:_buildIconsColor(Icons.settings, "Ayarlar"),
                    title: Text('Ayarlar'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AyarlarSayfasi()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              leading:_buildIconsColor(Icons.exit_to_app,"Çıkış Yap"),
              title: Text("Çıkış Yap"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [gradientStart, gradientEnd],
              ),

            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.white, size: 28),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      Image.asset(
                        'assets/beyaz_yazisiz_logo_arkaplansiz.png',
                        width: 80,
                        height: 80,
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SepetSayfasi()),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                //HOŞ GELDİN YAZISI
                // --- HOŞ GELDİN YAZISI (BACKEND ENTEGRASYONU) ---
                FutureBuilder<Map<String, dynamic>?>(
                  future: AuthService().getProfile(), // Backend'den bilgiyi iste
                  builder: (context, snapshot) {
                    String isim = "Misafir"; // Veri gelene kadar görünecek varsayılan isim

                    if (snapshot.hasData && snapshot.data != null) {
                      String fullName = snapshot.data!['fullName'] ?? "Kullanıcı";

                      // Sadece ilk ismini göstermek istersen (Örn: Ömer Faruk -> Ömer):
                      // isim = fullName.split(' ')[0];

                      // Tam ismini göstermek istersen:
                      isim = fullName;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'Hoş Geldin, ',
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                            children: [
                              TextSpan(
                                text: isim, // Backend'den gelen isim burada yazacak
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // --- ARAMA ÇUBUĞU ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Ürün ara...",
                        hintStyle: TextStyle(color: Colors.white60),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.white60),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1548036328-c9fa89d128fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Yeni Sezon",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Koleksiyonu Keşfet",
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      children: [
                        // Kategoriler
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildCategoryItem(Icons.shopping_bag, "Giyim"),
                            _buildCategoryItem(Icons.menu_book, "Kırtasiye"),
                            _buildCategoryItem(Icons.computer, "Elektronik"),
                            _buildCategoryItem(Icons.diamond, "Aksesuar"),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Ürün Grid Yapısı
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return _buildProductCard(products[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconsColor(IconData icon, String title) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // İkon için gradyan efekti
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [gradientStart, gradientEnd],
              ).createShader(bounds);
            },
            child: Icon(icon, size: 24, color: Colors.white),
          ),

        ],
      ),
    );
  }
  Widget _buildCategoryItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC), // Hafif pembe arka plan
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: gradientEnd),
        ),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ürün Resmi
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite_border, color: gradientEnd, size: 18),
                  ),
                ),
              ],
            ),
          ),
          // Ürün Bilgileri
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  product.price,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Product {
  final String title;
  final String price;
  final String imageUrl;

  Product({required this.title, required this.price, required this.imageUrl});
}

// Örnek Veri
List<Product> products = [
  Product(
    title: "MonsterXXXL PC",
    price: "₺ 1,231",
    imageUrl: "https://cdn.britannica.com/77/170477-050-1C747EE3/Laptop-computer.jpg",
  ),
  Product(
    title: "Aurora Çanta",
    price: "₺ 2,450",
    imageUrl: "https://images.unsplash.com/photo-1591561954557-26941169b49e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
  ),
  Product(
    title: "Klasik Saat",
    price: "₺ 1,400",
    imageUrl: "https://images.unsplash.com/photo-1524592094714-0f0654e20314?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
  ),
  Product(
    title: "Deri Çanta",
    price: "₺ 3,100",
    imageUrl: "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
  ),
];