import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xffF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff4F46E5),
          primary: const Color(0xff4F46E5),
          secondary: const Color(0xff06B6D4),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// =========================================
// 0. SPLASH SCREEN
// =========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4F46E5), Color(0xff3730A3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.menu_book_rounded, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'Book Store App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Temukan jendela dunia melalui buku favoritmu',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.cyanAccent),
          ],
        ),
      ),
    );
  }
}

// =========================================
// 0.1. LOGIN PAGE
// =========================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan Password tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xff4F46E5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock_person_rounded, size: 55, color: Color(0xff4F46E5)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Selamat Datang Kembali!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff1E293B)),
              ),
              const SizedBox(height: 6),
              const Text(
                'Masuk untuk melanjutkan petualangan membaca',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined, color: Color(0xff4F46E5)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xff4F46E5)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4F46E5),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _login,
                  child: const Text('Masuk Sekarang', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================
// 1. SCREEN UTAMA DENGAN BOTTOM NAVIGATION
// =========================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> bookmarkItems = [];

  final List<Map<String, String>> orderList = [
    {
      'orderId': 'INV-20260625',
      'book': 'Flutter',
      'status': 'Selesai',
      'date': '20 Juni 2026',
      'payment': 'Transfer Bank',
      'shippingName': 'Azkia',
      'shippingAddress': 'Jl. Datu Kandang Haji RT. 03 Desa Halong Kec. Halong',
      'shippingStatus': 'Paket telah diterima oleh pembeli',
    },
  ];

  final List<Map<String, String>> notificationList = [
    {
      'title': 'Promo Literasi Nasional',
      'message': 'Diskon hingga 30% untuk pembelian novel pilihan!',
      'time': 'Kemarin',
      'type': 'promo',
    },
    {
      'title': 'Pesanan Selesai',
      'message': 'Pesanan INV-20260625 telah selesai.',
      'time': '20 Juni 2026',
      'type': 'order',
    },
  ];

  int unreadNotificationsCount = 2;

  Map<String, String> userProfile = {
    'name': 'Y/N',
    'email': 'azkiayaa09@email.com',
    'phone': '081234567890',
    'address': 'Jl. Datu Kandang Haji RT. 03 Desa Halong Kec. Halong',
    'member_tier': 'Gold Member',
    'balance': 'Rp 250.000',
    'coins': '1.500 Koin',
  };

  final List<Map<String, dynamic>> bookProducts = [
    {
      'title': 'Janji',
      'price': 'Rp 110.000',
      'image': 'assets/images/buku (1).jpeg',
      'author': 'Tere Liye',
      'rating': '4.8',
      'reviews': '124 ulasan',
      'pages': '360 halaman',
      'year': '2021',
      'synopsis': 'Sebuah perjalanan penuh makna tentang pencarian jati diri, janji masa lalu, dan pengorbanan hidup yang menggetarkan hati pembaca.'
    },
    {
      'title': 'Cantik Itu Luka',
      'price': 'Rp 110.000',
      'image': 'assets/images/buku (2).jpeg',
      'author': 'Eka Kurniawan',
      'rating': '4.9',
      'reviews': '310 ulasan',
      'pages': '504 halaman',
      'year': '2002',
      'synopsis': 'Kisah epik yang memadukan sejarah keluarga, tragedi kemanusiaan, dan unsur realisme magis di pesisir pulau Jawa.'
    },
    {
      'title': 'Laut Bercerita',
      'price': 'Rp 130.000',
      'image': 'assets/images/buku (3).jpeg',
      'author': 'Leila S. Chudori',
      'rating': '4.9',
      'reviews': '540 ulasan',
      'pages': '394 halaman',
      'year': '2017',
      'synopsis': 'Novel yang menceritakan perihnya masa Orde Baru, hilangnya para aktivis, serta keluarga yang ditinggalkan tanpa kepastian.'
    },
    {
      'title': 'Namaku Alam',
      'price': 'Rp 105.000',
      'image': 'assets/images/buku (4).jpeg',
      'author': 'Leila S. Chudori',
      'rating': '4.7',
      'reviews': '95 ulasan',
      'pages': '380 halaman',
      'year': '2023',
      'synopsis': 'Kelanjutan kisah dari semesta novel sebelumnya, menyoroti sudut pandang seorang anak dengan latar belakang masa lalu yang kelam.'
    },
    {
      'title': 'Tentang Kamu',
      'price': 'Rp 120.000',
      'image': 'assets/images/buku (5).jpeg',
      'author': 'Tere Liye',
      'rating': '4.8',
      'reviews': '215 ulasan',
      'pages': '524 halaman',
      'year': '2016',
      'synopsis': 'Pencarian warisan seorang wanita tua misterius di Paris, London, hingga pedesaan di Indonesia yang mengungkap lembaran hidup luar biasa.'
    },
    {
      'title': 'One Piece 02',
      'price': 'Rp 29.000',
      'image': 'assets/images/one piece 02.jpeg',
      'author': 'Eiichiro Oda',
      'rating': '4.9',
      'reviews': '430 ulasan',
      'pages': '200 halaman',
      'year': '2001',
      'synopsis': 'Petualangan Luffy dalam merekrut kru pertamanya, Zoro, serta pertarungan seru melawan bajak laut kapten Morgan.'
    },
    {
      'title': 'One Piece 04 (2023)',
      'price': 'Rp 33.000',
      'image': 'assets/images/one piece.jpeg',
      'author': 'Eiichiro Oda',
      'rating': '4.9',
      'reviews': '180 ulasan',
      'pages': '192 halaman',
      'year': '2023',
      'synopsis': 'Kelanjutan perjalanan kelompok Topi Jerami menghadapi musuh-musuh tangguh di East Blue demi menggapai impian besar.'
    },
    {
      'title': 'Psikologi Pendidikan',
      'price': 'Rp 99.000',
      'image': 'assets/images/psikologi.jpeg',
      'author': 'Dr. M. Ngalim Purwanto',
      'rating': '4.6',
      'reviews': '88 ulasan',
      'pages': '280 halaman',
      'year': '2019',
      'synopsis': 'Buku referensi penting bagi para pendidik untuk memahami teori belajar, perkembangan anak, serta pendekatan psikologis di kelas.'
    },
    {
      'title': 'Flutter',
      'price': 'Rp 90.000',
      'image': 'assets/images/flutter.jpeg',
      'author': 'Tim Developer Indonesia',
      'rating': '4.8',
      'reviews': '160 ulasan',
      'pages': '310 halaman',
      'year': '2022',
      'synopsis': 'Panduan praktis membangun aplikasi multi-platform menggunakan framework Flutter dan bahasa pemrograman Dart.'
    },
    {
      'title': 'Gizi dan Kesehatan Anak',
      'price': 'Rp 101.000',
      'image': 'assets/images/gizi dan kesehatan.jpeg',
      'author': 'Prof. Dr. Soekirman',
      'rating': '4.7',
      'reviews': '72 ulasan',
      'pages': '245 halaman',
      'year': '2020',
      'synopsis': 'Ulasan mendalam mengenai pentingnya pemenuhan nutrisi seimbang untuk pencegahan stunting dan tumbuh kembang optimal anak.'
    },
  ];

  void _toggleBookmark(Map<String, dynamic> product) {
    setState(() {
      int index = bookmarkItems.indexWhere((item) => item['title'] == product['title']);
      if (index >= 0) {
        bookmarkItems.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product['title']} dihapus dari bookmark ❌'),
            duration: const Duration(milliseconds: 1200),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        bookmarkItems.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product['title']} disimpan ke bookmark! 🔖'),
            duration: const Duration(milliseconds: 1200),
            backgroundColor: const Color(0xff4F46E5),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  bool _isBookmarked(Map<String, dynamic> product) {
    return bookmarkItems.any((item) => item['title'] == product['title']);
  }

  void _updateProfile(String newName, String newEmail, String newPhone, String newAddress) {
    setState(() {
      userProfile['name'] = newName;
      userProfile['email'] = newEmail;
      userProfile['phone'] = newPhone;
      userProfile['address'] = newAddress;
    });
  }

  void _addToCart(String title, String price, String image) {
    setState(() {
      int index = cartItems.indexWhere((item) => item['title'] == title);
      if (index >= 0) {
        cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) + 1;
      } else {
        cartItems.add({
          'title': title,
          'price': price,
          'image': image,
          'quantity': 1,
          'isSelected': true,
        });
      }

      notificationList.insert(0, {
        'title': 'Berhasil Masuk Keranjang',
        'message': '$title telah ditambahkan ke keranjang belanja Anda.',
        'time': 'Baru saja',
        'type': 'cart',
      });

      unreadNotificationsCount++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title berhasil dimasukkan ke keranjang! 📚'),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: const Color(0xff4F46E5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _processDirectCheckout(Map<String, dynamic> product) {
    _showDirectCheckoutDialog(context, product, userProfile['name']!, userProfile['address']!);
  }

  void _showDirectCheckoutDialog(BuildContext context, Map<String, dynamic> product, String defaultName, String defaultAddress) {
    String selectedPaymentMethod = 'Transfer Bank';
    final TextEditingController nameController = TextEditingController(text: defaultName);
    final TextEditingController addressController = TextEditingController(text: defaultAddress);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Konfirmasi Pembelian Langsung', style: TextStyle(fontWeight: FontWeight.bold)),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Produk: ${product['title']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff4F46E5))),
                    Text('Harga: ${product['price']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(height: 20),
                    const Text('Nama Penerima:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.person_outline, color: Color(0xff4F46E5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Alamat Pengiriman:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: addressController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xff4F46E5)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Metode Pembayaran:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    RadioListTile<String>(
                      title: const Text('Transfer Bank', style: TextStyle(fontSize: 13)),
                      value: 'Transfer Bank',
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => setStateDialog(() => selectedPaymentMethod = v!),
                    ),
                    RadioListTile<String>(
                      title: const Text('E-Wallet (GoPay/OVO)', style: TextStyle(fontSize: 13)),
                      value: 'E-Wallet',
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => setStateDialog(() => selectedPaymentMethod = v!),
                    ),
                    RadioListTile<String>(
                      title: const Text('COD (Bayar di Tempat)', style: TextStyle(fontSize: 13)),
                      value: 'COD',
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => setStateDialog(() => selectedPaymentMethod = v!),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4F46E5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (nameController.text.trim().isEmpty || addressController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama dan Alamat pengiriman tidak boleh kosong!'), backgroundColor: Colors.redAccent),
                  );
                  return;
                }
                Navigator.pop(context);

                setState(() {
                  String newId = 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
                  orderList.insert(0, {
                    'orderId': newId,
                    'book': "${product['title']} (1x)",
                    'status': 'Sedang Dikemas',
                    'date': '26 Juli 2026',
                    'payment': selectedPaymentMethod,
                    'shippingName': nameController.text,
                    'shippingAddress': addressController.text,
                    'shippingStatus': 'Kurir sedang menyiapkan penjemputan paket',
                  });

                  notificationList.insert(0, {
                    'title': 'Pembayaran Berhasil / Pesanan Dikemas',
                    'message': 'Pesanan $newId via $selectedPaymentMethod sedang disiapkan untuk dikirim.',
                    'time': 'Baru saja',
                    'type': 'order',
                  });

                  unreadNotificationsCount++;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pembelian berhasil! Pesanan sedang diproses. 📦"), backgroundColor: Colors.green),
                );
              },
              child: const Text('Bayar Sekarang', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _processCheckout(String selectedPayment, String shippingName, String shippingAddress) {
    setState(() {
      String newId = 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
      List<Map<String, dynamic>> itemsToCheckout = cartItems.where((item) => item['isSelected'] == true).toList();

      for (var item in itemsToCheckout) {
        orderList.insert(0, {
          'orderId': newId,
          'book': "${item['title']} (${item['quantity']}x)",
          'status': 'Sedang Dikemas',
          'date': '26 Juli 2026',
          'payment': selectedPayment,
          'shippingName': shippingName,
          'shippingAddress': shippingAddress,
          'shippingStatus': 'Kurir sedang menyiapkan penjemputan paket',
        });
      }

      notificationList.insert(0, {
        'title': 'Pembayaran Berhasil / Pesanan Dikemas',
        'message': 'Pesanan $newId via $selectedPayment sedang disiapkan untuk dikirim.',
        'time': 'Baru saja',
        'type': 'order',
      });

      unreadNotificationsCount++;
      cartItems.removeWhere((item) => item['isSelected'] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        cartItems: cartItems,
        orderList: orderList,
        bookProducts: bookProducts,
        bookmarkItems: bookmarkItems,
        onAddToCart: _addToCart,
        onBuyNow: _processDirectCheckout,
        onToggleBookmark: _toggleBookmark,
        isBookmarked: _isBookmarked,
      ),
      CategoryTabScreen(
        cartItems: cartItems,
        bookProducts: bookProducts,
        bookmarkItems: bookmarkItems,
        onAddToCart: _addToCart,
        onBuyNow: _processDirectCheckout,
        onToggleBookmark: _toggleBookmark,
        isBookmarked: _isBookmarked,
      ),
      CartPage(
        cartItems: cartItems,
        defaultName: userProfile['name']!,
        defaultAddress: userProfile['address']!,
        onCheckout: _processCheckout,
      ),
      NotificationPage(
        notificationList: notificationList,
        onNotificationOpened: () {
          setState(() {
            unreadNotificationsCount = 0;
          });
        },
      ),
      ProfilePage(
        userProfile: userProfile,
        onUpdateProfile: _updateProfile,
        orderList: orderList,
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -3)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                if (index == 3) {
                  unreadNotificationsCount = 0;
                }
              });
            },
            selectedItemColor: const Color(0xff4F46E5),
            unselectedItemColor: Colors.grey.shade400,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
              const BottomNavigationBarItem(icon: Icon(Icons.category_rounded), label: 'Kategori'),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_rounded),
                    if (cartItems.isNotEmpty)
                      Positioned(
                        right: -6,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartItems.fold(0, (sum, item) => sum + ((item['quantity'] as int?) ?? 1))}',
                            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Keranjang',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications_rounded),
                    if (unreadNotificationsCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$unreadNotificationsCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Notif',
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================
// 2. HALAMAN UTAMA (HOME PAGE)
// =========================================
class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, String>> orderList;
  final List<Map<String, dynamic>> bookProducts;
  final List<Map<String, dynamic>> bookmarkItems;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const HomePage({
    super.key,
    required this.cartItems,
    required this.orderList,
    required this.bookProducts,
    required this.bookmarkItems,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.onToggleBookmark,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff4F46E5), Color(0xff3730A3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Halo, Pembaca! 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          SizedBox(height: 2),
                          Text('Mau baca apa hari ini?', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.bookmark_rounded, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookmarkPage(
                                  bookmarkItems: bookmarkItems,
                                  onAddToCart: onAddToCart,
                                  onBuyNow: onBuyNow,
                                  onToggleBookmark: onToggleBookmark,
                                  isBookmarked: isBookmarked,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchPage(
                            bookProducts: bookProducts,
                            onAddToCart: onAddToCart,
                            onBuyNow: onBuyNow,
                            onToggleBookmark: onToggleBookmark,
                            isBookmarked: isBookmarked,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search_rounded, color: Color(0xff4F46E5)),
                          SizedBox(width: 12),
                          Text(
                            'Cari buku atau penulis favorit...',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
                children: [
                  MenuItem(
                    icon: Icons.auto_stories_rounded,
                    title: 'Novel',
                    bgColor: const Color(0xffEEF2FF),
                    iconColor: const Color(0xff4F46E5),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NovelCategoryPage(cartItems: cartItems, bookProducts: bookProducts, bookmarkItems: bookmarkItems, onAddToCart: onAddToCart, onBuyNow: onBuyNow, onToggleBookmark: onToggleBookmark, isBookmarked: isBookmarked))),
                  ),
                  MenuItem(
                    icon: Icons.menu_book_rounded,
                    title: 'Komik',
                    bgColor: const Color(0xffFEF3C7),
                    iconColor: const Color(0xffD97706),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ComicCategoryPage(cartItems: cartItems, bookProducts: bookProducts, bookmarkItems: bookmarkItems, onAddToCart: onAddToCart, onBuyNow: onBuyNow, onToggleBookmark: onToggleBookmark, isBookmarked: isBookmarked))),
                  ),
                  MenuItem(
                    icon: Icons.school_rounded,
                    title: 'Edukasi',
                    bgColor: const Color(0xffECFDF5),
                    iconColor: const Color(0xff059669),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EducationCategoryPage(cartItems: cartItems, bookProducts: bookProducts, bookmarkItems: bookmarkItems, onAddToCart: onAddToCart, onBuyNow: onBuyNow, onToggleBookmark: onToggleBookmark, isBookmarked: isBookmarked))),
                  ),
                  MenuItem(
                    icon: Icons.receipt_long_rounded,
                    title: 'Pesanan',
                    bgColor: const Color(0xffFCE7F3),
                    iconColor: const Color(0xffDB2777),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderStatusPage(orderList: orderList))),
                  ),
                  MenuItem(
                    icon: Icons.local_shipping_rounded,
                    title: 'Lacak',
                    bgColor: const Color(0xffE0F2FE),
                    iconColor: const Color(0xff0284C7),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShippingTrackingPage(orderList: orderList))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff06B6D4), Color(0xff3B82F6)],
                  ),
                  boxShadow: [
                    BoxShadow(color: const Color(0xff3B82F6).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(8)),
                        child: const Text('PROMO SPESIAL', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Diskon Literasi hingga 30%',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Potongan harga menarik untuk buku pilihan hari ini!',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rekomendasi Untukmu 📚',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1E293B)),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemCount: bookProducts.length,
                itemBuilder: (context, index) {
                  final item = bookProducts[index];
                  return ProductCard(
                    product: item,
                    isBookmarked: isBookmarked(item),
                    onToggleBookmark: () => onToggleBookmark(item),
                    onAddToCart: () => onAddToCart(
                      item['title']!,
                      item['price']!,
                      item['image']!,
                    ),
                    onBuyNow: () => onBuyNow(item),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// =========================================
// 2.0.1 HALAMAN BOOKMARK (WISHLIST BUKU) - DENGAN TOMBOL HAPUS
// =========================================
class BookmarkPage extends StatefulWidget {
  final List<Map<String, dynamic>> bookmarkItems;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const BookmarkPage({
    super.key,
    required this.bookmarkItems,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.onToggleBookmark,
    required this.isBookmarked,
  });

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  // Fungsi untuk menghapus semua atau memunculkan konfirmasi hapus bookmark
  void _clearAllBookmarks() {
    if (widget.bookmarkItems.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Hapus Semua Bookmark?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Semua buku yang tersimpan di bookmark akan dihapus.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                setState(() {
                  widget.bookmarkItems.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Semua bookmark berhasil dihapus 🗑️'),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Tersimpan 🔖', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff4F46E5),
        foregroundColor: Colors.white,
        actions: [
          if (widget.bookmarkItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              tooltip: 'Hapus Semua Bookmark',
              onPressed: _clearAllBookmarks,
            ),
        ],
      ),
      body: widget.bookmarkItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bookmark_border_rounded, size: 70, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'Belum ada buku yang disimpan.',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tekan ikon bookmark pada buku favoritmu!',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: widget.bookmarkItems.length,
          itemBuilder: (context, index) {
            final item = widget.bookmarkItems[index];
            return ProductCard(
              product: item,
              isBookmarked: widget.isBookmarked(item),
              onToggleBookmark: () {
                widget.onToggleBookmark(item);
                setState(() {}); // Memperbarui tampilan grid saat item dihapus
              },
              onAddToCart: () => widget.onAddToCart(
                item['title']!,
                item['price']!,
                item['image']!,
              ),
              onBuyNow: () => widget.onBuyNow(item),
            );
          },
        ),
      ),
    );
  }
}

// =========================================
// 2.1. HALAMAN PENCARIAN BUKU
// =========================================
class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> bookProducts;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const SearchPage({
    super.key,
    required this.bookProducts,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.onToggleBookmark,
    required this.isBookmarked,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = widget.bookProducts.where((book) {
      final title = book['title'].toString().toLowerCase();
      final author = book['author'].toString().toLowerCase();
      final searchLower = _query.toLowerCase();
      return title.contains(searchLower) || author.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: const InputDecoration(
            hintText: 'Cari judul buku atau penulis...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        backgroundColor: const Color(0xff4F46E5),
        foregroundColor: Colors.white,
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
        ],
      ),
      body: filteredBooks.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off_rounded, size: 70, color: Colors.grey),
            const SizedBox(height: 14),
            Text(
              'Buku "$_query" tidak ditemukan',
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
            final item = filteredBooks[index];
            return ProductCard(
              product: item,
              isBookmarked: widget.isBookmarked(item),
              onToggleBookmark: () => widget.onToggleBookmark(item),
              onAddToCart: () => widget.onAddToCart(
                item['title']!,
                item['price']!,
                item['image']!,
              ),
              onBuyNow: () => widget.onBuyNow(item),
            );
          },
        ),
      ),
    );
  }
}

// =========================================
// 3. TAB KATEGORI
// =========================================
class CategoryTabScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> bookProducts;
  final List<Map<String, dynamic>> bookmarkItems;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const CategoryTabScreen({
    super.key,
    required this.cartItems,
    required this.bookProducts,
    required this.bookmarkItems,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.onToggleBookmark,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Buku 📖', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff4F46E5),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategoryItem(
            context,
            'Novel',
            'Kumpulan novel fiksi, sastra, dan best seller',
            Icons.auto_stories_rounded,
            const Color(0xffEEF2FF),
            const Color(0xff4F46E5),
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NovelCategoryPage(cartItems: cartItems, bookProducts: bookProducts, bookmarkItems: bookmarkItems, onAddToCart: onAddToCart, onBuyNow: onBuyNow, onToggleBookmark: onToggleBookmark, isBookmarked: isBookmarked)),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildCategoryItem(
            context,
            'Komik',
            'Komik seru dan manga populer',
            Icons.menu_book_rounded,
            const Color(0xffFEF3C7),
            const Color(0xffD97706),
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ComicCategoryPage(cartItems: cartItems, bookProducts: bookProducts, bookmarkItems: bookmarkItems, onAddToCart: onAddToCart, onBuyNow: onBuyNow, onToggleBookmark: onToggleBookmark, isBookmarked: isBookmarked)),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildCategoryItem(
            context,
            'Pendidikan / Edukasi',
            'Buku pelajaran, psikologi, dan pengembangan diri',
            Icons.school_rounded,
            const Color(0xffECFDF5),
            const Color(0xff059669),
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EducationCategoryPage(cartItems: cartItems, bookProducts: bookProducts, bookmarkItems: bookmarkItems, onAddToCart: onAddToCart, onBuyNow: onBuyNow, onToggleBookmark: onToggleBookmark, isBookmarked: isBookmarked)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color bgColor,
      Color iconColor,
      VoidCallback onTap,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

// =========================================
// 4. HALAMAN DETAIL PRODUK
// =========================================
class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(String, String, String) onAddToCart;
  final VoidCallback onBuyNow;
  final VoidCallback onToggleBookmark;
  final bool isBookmarked;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.onToggleBookmark,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff4F46E5),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isBookmarked ? Colors.amber : Colors.white,
            ),
            onPressed: onToggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              color: Colors.grey.shade100,
              child: Image.asset(
                product['image'],
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.book, size: 80, color: Color(0xff4F46E5)),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1E293B)),
                        ),
                      ),
                      Text(
                        product['price'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff4F46E5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Penulis: ${product['author']}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        product['rating'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '(${product['reviews']})',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(product['year'], style: const TextStyle(fontSize: 11)),
                        backgroundColor: const Color(0xff4F46E5).withOpacity(0.1),
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: 6),
                      Chip(
                        label: Text(product['pages'], style: const TextStyle(fontSize: 11)),
                        backgroundColor: const Color(0xff4F46E5).withOpacity(0.1),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  const Text(
                    'Sinopsis Buku',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff1E293B)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['synopsis'],
                    style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff4F46E5)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  onAddToCart(product['title'], product['price'], product['image']);
                },
                icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xff4F46E5), size: 18),
                label: const Text('+ Keranjang', style: TextStyle(color: Color(0xff4F46E5), fontSize: 14)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4F46E5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onBuyNow();
                },
                child: const Text('Beli Sekarang', style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================
// 5. HALAMAN KERANJANG
// =========================================
class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String defaultName;
  final String defaultAddress;
  final Function(String, String, String) onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.defaultName,
    required this.defaultAddress,
    required this.onCheckout,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selectedPaymentMethod = 'Transfer Bank';
  late TextEditingController nameController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.defaultName);
    addressController = TextEditingController(text: widget.defaultAddress);
  }

  @override
  void didUpdateWidget(covariant CartPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultName != widget.defaultName) {
      nameController.text = widget.defaultName;
    }
    if (oldWidget.defaultAddress != widget.defaultAddress) {
      addressController.text = widget.defaultAddress;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  int getTotalHarga() {
    int total = 0;
    for (var item in widget.cartItems) {
      if (item['isSelected'] == true) {
        String hargaStr = item['price']!.replaceAll('Rp', '').replaceAll('.', '').replaceAll(' ', '');
        int harga = int.tryParse(hargaStr) ?? 0;
        int qty = item['quantity'] ?? 1;
        total += harga * qty;
      }
    }
    return total;
  }

  void _deleteSelectedItems() {
    setState(() {
      widget.cartItems.removeWhere((item) => item['isSelected'] == true);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produk terpilih berhasil dihapus 🗑️'), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    bool hasSelected = widget.cartItems.any((item) => item['isSelected'] == true);
    if (!hasSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih minimal 1 produk untuk checkout!'), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Konfirmasi Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama Penerima:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.person_outline, color: Color(0xff4F46E5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Alamat Pengiriman:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: addressController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xff4F46E5)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Metode Pembayaran:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    RadioListTile<String>(
                      title: const Text('Transfer Bank', style: TextStyle(fontSize: 13)),
                      value: 'Transfer Bank',
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => setStateDialog(() => selectedPaymentMethod = v!),
                    ),
                    RadioListTile<String>(
                      title: const Text('E-Wallet (GoPay/OVO)', style: TextStyle(fontSize: 13)),
                      value: 'E-Wallet',
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => setStateDialog(() => selectedPaymentMethod = v!),
                    ),
                    RadioListTile<String>(
                      title: const Text('COD (Bayar di Tempat)', style: TextStyle(fontSize: 13)),
                      value: 'COD',
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => setStateDialog(() => selectedPaymentMethod = v!),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4F46E5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (nameController.text.trim().isEmpty || addressController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama dan Alamat tidak boleh kosong!'), backgroundColor: Colors.redAccent),
                  );
                  return;
                }
                Navigator.pop(context);
                widget.onCheckout(selectedPaymentMethod, nameController.text, addressController.text);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Checkout berhasil! Pesanan diproses. 📦"), backgroundColor: Colors.green),
                );
              },
              child: const Text('Bayar Sekarang', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAllSelected = widget.cartItems.isNotEmpty && widget.cartItems.every((item) => item['isSelected'] == true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Belanja 🛒", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff4F46E5),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          if (widget.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              tooltip: 'Hapus yang dipilih',
              onPressed: _deleteSelectedItems,
            ),
        ],
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 70, color: Colors.grey),
            SizedBox(height: 12),
            Text("Keranjang kamu masih kosong. Yuk belanja!", style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      )
          : Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: isAllSelected,
                  activeColor: const Color(0xff4F46E5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onChanged: (bool? value) {
                    setState(() {
                      for (var item in widget.cartItems) {
                        item['isSelected'] = value ?? false;
                      }
                    });
                  },
                ),
                const Text('Pilih Semua', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: item['isSelected'] ?? false,
                          activeColor: const Color(0xff4F46E5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (bool? value) {
                            setState(() {
                              item['isSelected'] = value ?? false;
                            });
                          },
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(item['image']!, width: 55, height: 55, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.book, color: Color(0xff4F46E5))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(item['price']!, style: const TextStyle(color: Color(0xff4F46E5), fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline_rounded, size: 20, color: Colors.grey),
                              onPressed: () => setState(() {
                                if (item['quantity'] > 1) {
                                  item['quantity']--;
                                } else {
                                  widget.cartItems.removeAt(index);
                                }
                              }),
                            ),
                            Text('${item['quantity'] ?? 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline_rounded, size: 20, color: Color(0xff4F46E5)),
                              onPressed: () => setState(() => item['quantity']++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Terpilih", style: TextStyle(color: Colors.grey, fontSize: 11)),
                Text("Rp ${getTotalHarga()}", style: const TextStyle(fontSize: 16, color: Color(0xff4F46E5), fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4F46E5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: widget.cartItems.isEmpty ? null : () => _showCheckoutDialog(context),
              child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================
// 6. HALAMAN PROFIL
// =========================================
class ProfilePage extends StatefulWidget {
  final Map<String, String> userProfile;
  final Function(String, String, String, String) onUpdateProfile;
  final List<Map<String, String>> orderList;

  const ProfilePage({
    super.key,
    required this.userProfile,
    required this.onUpdateProfile,
    required this.orderList,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: widget.userProfile['name']);
    final TextEditingController emailController = TextEditingController(text: widget.userProfile['email']);
    final TextEditingController phoneController = TextEditingController(text: widget.userProfile['phone']);
    final TextEditingController addressController = TextEditingController(text: widget.userProfile['address']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Ubah Profil', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nama Lengkap', prefixIcon: const Icon(Icons.person, color: Color(0xff4F46E5)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                const SizedBox(height: 12),
                TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email, color: Color(0xff4F46E5)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                const SizedBox(height: 12),
                TextField(controller: phoneController, decoration: InputDecoration(labelText: 'No Handphone', prefixIcon: const Icon(Icons.phone, color: Color(0xff4F46E5)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                const SizedBox(height: 12),
                TextField(controller: addressController, maxLines: 2, decoration: InputDecoration(labelText: 'Alamat Pengiriman', prefixIcon: const Icon(Icons.home, color: Color(0xff4F46E5)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff4F46E5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                widget.onUpdateProfile(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                  addressController.text,
                );
                Navigator.pop(context);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil berhasil diperbarui! ✨'), backgroundColor: Colors.green),
                );
              },
              child: const Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xff4F46E5), Color(0xff3730A3)]),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Profil Saya', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.edit_rounded, color: Colors.white),
                        onPressed: () => _showEditProfileDialog(context),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Color(0xff4F46E5)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userProfile['name']!, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Text(widget.userProfile['email']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 2),
                            Text(widget.userProfile['phone']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                widget.userProfile['member_tier']!,
                                style: const TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(children: [Icon(Icons.account_balance_wallet_rounded, color: Color(0xff4F46E5), size: 18), SizedBox(width: 6), Text('Saldo', style: TextStyle(color: Colors.grey, fontSize: 12))]),
                          const SizedBox(height: 6),
                          Text(widget.userProfile['balance']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(children: [Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 18), SizedBox(width: 6), Text('Koin', style: TextStyle(color: Colors.grey, fontSize: 12))]),
                          const SizedBox(height: 6),
                          Text(widget.userProfile['coins']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Alamat Pengiriman Utama", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Color(0xff4F46E5), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.userProfile['address']!,
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Riwayat Pesanan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  widget.orderList.isEmpty
                      ? const Text("Belum ada riwayat pesanan.", style: TextStyle(color: Colors.grey, fontSize: 13))
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.orderList.length,
                    itemBuilder: (context, index) {
                      final order = widget.orderList[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(order['book']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: Text("ID: ${order['orderId']} • ${order['date']}\nPenerima: ${order['shippingName'] ?? '-'}", style: const TextStyle(fontSize: 11)),
                        isThreeLine: true,
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: order['status'] == 'Selesai' ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(order['status']!, style: TextStyle(color: order['status'] == 'Selesai' ? Colors.green : Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                    foregroundColor: Colors.redAccent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _logout,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Keluar (Logout)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// =========================================
// 7. HALAMAN KATEGORI NOVEL
// =========================================
class NovelCategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> bookProducts;
  final List<Map<String, dynamic>> bookmarkItems;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const NovelCategoryPage({super.key, required this.cartItems, required this.bookProducts, required this.bookmarkItems, required this.onAddToCart, required this.onBuyNow, required this.onToggleBookmark, required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    final novelBooks = bookProducts.where((p) =>
        ['Janji', 'Cantik Itu Luka', 'Laut Bercerita', 'Namaku Alam', 'Tentang Kamu'].contains(p['title'])
    ).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Novel 📚', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xff4F46E5), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: novelBooks.length,
          itemBuilder: (context, index) {
            final item = novelBooks[index];
            return ProductCard(
              product: item,
              isBookmarked: isBookmarked(item),
              onToggleBookmark: () => onToggleBookmark(item),
              onAddToCart: () => onAddToCart(
                item['title']!,
                item['price']!,
                item['image']!,
              ),
              onBuyNow: () => onBuyNow(item),
            );
          },
        ),
      ),
    );
  }
}

// =========================================
// 8. HALAMAN KATEGORI KOMIK
// =========================================
class ComicCategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> bookProducts;
  final List<Map<String, dynamic>> bookmarkItems;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const ComicCategoryPage({super.key, required this.cartItems, required this.bookProducts, required this.bookmarkItems, required this.onAddToCart, required this.onBuyNow, required this.onToggleBookmark, required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    final comicBooks = bookProducts.where((p) =>
        p['title'].toString().contains('One Piece')
    ).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Komik 🗯️', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xff4F46E5), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: comicBooks.length,
          itemBuilder: (context, index) {
            final item = comicBooks[index];
            return ProductCard(
              product: item,
              isBookmarked: isBookmarked(item),
              onToggleBookmark: () => onToggleBookmark(item),
              onAddToCart: () => onAddToCart(
                item['title']!,
                item['price']!,
                item['image']!,
              ),
              onBuyNow: () => onBuyNow(item),
            );
          },
        ),
      ),
    );
  }
}

// =========================================
// 9. HALAMAN KATEGORI EDUKASI / PENDIDIKAN
// =========================================
class EducationCategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> bookProducts;
  final List<Map<String, dynamic>> bookmarkItems;
  final Function(String, String, String) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;
  final Function(Map<String, dynamic>) onToggleBookmark;
  final bool Function(Map<String, dynamic>) isBookmarked;

  const EducationCategoryPage({super.key, required this.cartItems, required this.bookProducts, required this.bookmarkItems, required this.onAddToCart, required this.onBuyNow, required this.onToggleBookmark, required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    final educationBooks = bookProducts.where((p) =>
        ['Psikologi Pendidikan', 'Flutter', 'Gizi dan Kesehatan Anak'].contains(p['title'])
    ).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Edukasi 🎓', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xff4F46E5), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: educationBooks.length,
          itemBuilder: (context, index) {
            final item = educationBooks[index];
            return ProductCard(
              product: item,
              isBookmarked: isBookmarked(item),
              onToggleBookmark: () => onToggleBookmark(item),
              onAddToCart: () => onAddToCart(
                item['title']!,
                item['price']!,
                item['image']!,
              ),
              onBuyNow: () => onBuyNow(item),
            );
          },
        ),
      ),
    );
  }
}

// =========================================
// 10. HALAMAN PESANAN & LACAK
// =========================================
class OrderStatusPage extends StatelessWidget {
  final List<Map<String, String>> orderList;
  const OrderStatusPage({super.key, required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pesanan', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xff4F46E5), foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(order['book']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("\nID: ${order['orderId']}\nPenerima: ${order['shippingName'] ?? '-'}\nAlamat: ${order['shippingAddress'] ?? '-'}\nStatus: ${order['status']} (${order['date']})", style: const TextStyle(fontSize: 12)),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class ShippingTrackingPage extends StatelessWidget {
  final List<Map<String, String>> orderList;
  const ShippingTrackingPage({super.key, required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lacak Pengiriman', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xff4F46E5), foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xff4F46E5).withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.local_shipping_rounded, color: Color(0xff4F46E5)),
              ),
              title: Text(order['book']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("\nPenerima: ${order['shippingName']}\nTujuan: ${order['shippingAddress']}\nInfo: ${order['shippingStatus']}", style: const TextStyle(fontSize: 12)),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

// =========================================
// 11. HALAMAN NOTIFIKASI
// =========================================
class NotificationPage extends StatefulWidget {
  final List<Map<String, String>> notificationList;
  final VoidCallback onNotificationOpened;

  const NotificationPage({
    super.key,
    required this.notificationList,
    required this.onNotificationOpened,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onNotificationOpened();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi 🔔', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff4F46E5),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: widget.notificationList.isEmpty
          ? const Center(
        child: Text(
          'Belum ada notifikasi.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.notificationList.length,
        itemBuilder: (context, index) {
          final notif = widget.notificationList[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xff4F46E5).withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.notifications_active_rounded, color: Color(0xff4F46E5)),
              ),
              title: Text(notif['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Text("${notif['message']}\n${notif['time']}", style: const TextStyle(fontSize: 12)),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

// =========================================
// 12. WIDGET PENDUKUNG (MENU ITEM & PRODUCT CARD)
// =========================================
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xff1E293B)),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;
  final VoidCallback onToggleBookmark;
  final bool isBookmarked;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onBuyNow,
    required this.onToggleBookmark,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              product: product,
              isBookmarked: isBookmarked,
              onToggleBookmark: onToggleBookmark,
              onAddToCart: (title, price, image) {
                onAddToCart();
              },
              onBuyNow: onBuyNow,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    height: 115,
                    width: double.infinity,
                    color: Colors.grey.shade50,
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.book, size: 45, color: Color(0xff4F46E5)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: onToggleBookmark,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        color: isBookmarked ? Colors.amber : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xff1E293B)),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 13),
                            const SizedBox(width: 3),
                            Text(
                              product['rating'],
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product['price'],
                          style: const TextStyle(color: Color(0xff4F46E5), fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 26,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff4F46E5),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: onBuyNow,
                              child: const Text('Beli', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        SizedBox(
                          height: 26,
                          width: 26,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xff4F46E5).withOpacity(0.1),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.add_shopping_cart_rounded, color: Color(0xff4F46E5), size: 13),
                            onPressed: onAddToCart,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}