import 'package:flutter/material.dart';

class UserData {
  static final Map<String, String> _users = {
    'admin@resepku.com': 'admin123',
    'user@test.com': 'password',
  };

  static Map<String, String> get users => _users;

  static void addUser(String email, String password) {
    _users[email] = password;
  }

  static bool checkUser(String email, String password) {
    return _users.containsKey(email) && _users[email] == password;
  }
}

class RecipeData {
  static int _nextId = 4;

  static List<Map<String, dynamic>> _recipes = [
    {
      'id': 1,
      'name': 'Nasi Goreng Spesial',
      'category': 'Makanan Utama',
      'prepTime': 15,
      'cookTime': 20,
      'ingredients': '2 piring nasi, 3 siung bawang putih, 4 butir bawang merah, 1 batang daun bawang, 2 butir telur, Kecap manis secukupnya, Garam dan merica secukupnya',
      'steps': '1. Panaskan minyak goreng di wajan.\n2. Tumis bawang putih dan bawang merah hingga harum.\n3. Masukkan telur, orak-arik hingga matang.\n4. Tambahkan nasi, aduk hingga tercampur rata.\n5. Bumbui dengan kecap manis, garam, dan merica.\n6. Tambahkan irisan daun bawang, aduk sebentar.\n7. Sajikan.',
    },
    {
      'id': 2,
      'name': 'Soto Ayam',
      'category': 'Makanan Utama',
      'prepTime': 30,
      'cookTime': 60,
      'ingredients': '1 ekor ayam, 2 liter air, Bumbu halus, Mie bihun, Telur rebus, Daun seledri, Bawang goreng',
      'steps': '1. Rebus ayam hingga empuk, angkat dan suwir-suwir.\n2. Tumis bumbu halus hingga harum.\n3. Masukkan bumbu ke dalam kaldu ayam.\n4. Siapkan mangkuk, beri mie bihun, telur rebus, dan daging ayam suwir.\n5. Siram dengan kuah soto panas.\n6. Taburi dengan daun seledri dan bawang goreng.',
    },
    {
      'id': 3,
      'name': 'Es Teh Manis',
      'category': 'Minuman',
      'prepTime': 5,
      'cookTime': 5,
      'ingredients': '2 kantong teh celup, 200g gula pasir, Es batu secukupnya',
      'steps': '1. Seduh teh dengan air panas, diamkan 5 menit.\n2. Saring teh, tambahkan gula pasir, aduk hingga larut.\n3. Dinginkan.\n4. Sajikan dalam gelas dengan es batu.',
    },
  ];

  static List<Map<String, dynamic>> get recipes => _recipes;

  static void addRecipe(Map<String, dynamic> recipe) {
    recipe['id'] = _nextId++;
    _recipes.add(recipe);
  }

  static void deleteRecipe(int id) {
    _recipes.removeWhere((recipe) => recipe['id'] == id);
  }
}

void main() {
  runApp(const ResepApp());
}

class ResepApp extends StatelessWidget {
  const ResepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Resep Makanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIconColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const MainNavigationPage(),
        '/add': (context) => const AddRecipePage(),
        '/all': (context) => const AllRecipesPage(),
        '/search': (context) => const SearchRecipePage(),
        '/category': (context) => const CategoryRecipePage(),
        '/delete': (context) => const DeleteRecipePage(),
        '/detail': (context) => const RecipeDetailPage(),
      },
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const AllRecipesPage(),
    const SearchRecipePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Semua Resep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResepKu'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.restaurant_menu, size: 80, color: Colors.orange),
            const SizedBox(height: 16),
            const Text('ResepKu', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
            const SizedBox(height: 8),
            const Text('Pilih menu di bawah ini untuk mulai', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            
            _buildMenuItem(context, Icons.add, 'Tambah Resep Baru', '/add'),
            const SizedBox(height: 12),
            _buildMenuItem(context, Icons.category, 'Resep Berdasarkan Kategori', '/category'),
            const SizedBox(height: 12),
            _buildMenuItem(context, Icons.delete, 'Hapus Resep', '/delete'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String route) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.orange.shade800,
        elevation: 0,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Pengguna', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('user@resepku.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Keluar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password harus diisi')),
      );
      return;
    }

    if (UserData.checkUser(email, password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil!')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orange.shade200,
                  Colors.orange.shade50,
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.restaurant_menu, size: 80, color: Colors.orange),
                  const SizedBox(height: 16),
                  const Text('ResepKu', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
                  const SizedBox(height: 8),
                  const Text('Masuk ke akun Anda', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Masuk'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Belum punya akun? '),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isConfirmObscure = true;

  void _signup() {
    if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty || 
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak cocok')),
      );
      return;
    }

    UserData.addUser(_emailController.text, _passwordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Akun berhasil dibuat! Silakan login.')),
    );
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orange.shade200,
                  Colors.orange.shade50,
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.restaurant_menu, size: 80, color: Colors.orange),
                  const SizedBox(height: 16),
                  const Text('Buat Akun Baru', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
                  const SizedBox(height: 8),
                  const Text('Isi data diri Anda', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _isConfirmObscure,
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_isConfirmObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isConfirmObscure = !_isConfirmObscure;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _signup,
                    child: const Text('Daftar'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? '),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================== ADD RECIPE PAGE (SUDAH DIPERBAIKI) ===================
class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _prepTimeController = TextEditingController(); // Controller baru
  final _cookTimeController = TextEditingController(); // Controller baru
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  String _selectedCategory = 'Makanan Utama';

  final List<String> _categories = [
    'Makanan Utama',
    'Makanan Pembuka',
    'Makanan Penutup',
    'Minuman',
    'Cemilan',
  ];

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final newRecipe = {
        'name': _nameController.text,
        'category': _selectedCategory,
        'prepTime': int.tryParse(_prepTimeController.text) ?? 0, // Ambil dari controller
        'cookTime': int.tryParse(_cookTimeController.text) ?? 0, // Ambil dari controller
        'ingredients': _ingredientsController.text,
        'steps': _stepsController.text,
      };
      RecipeData.addRecipe(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resep berhasil disimpan!')),
      );
      
      // Kosongkan semua form setelah menyimpan
      _nameController.clear();
      _prepTimeController.clear(); // Kosongkan controller baru
      _cookTimeController.clear(); // Kosongkan controller baru
      _ingredientsController.clear();
      _stepsController.clear();
      setState(() {
        _selectedCategory = 'Makanan Utama';
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Resep Baru'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Resep',
                  prefixIcon: Icon(Icons.restaurant_menu),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Nama resep harus diisi' : null,
              ),
              const SizedBox(height: 16),
              // Field baru untuk Waktu Persiapan
              TextFormField(
                controller: _prepTimeController,
                keyboardType: TextInputType.number, // Tampilkan keyboard angka
                decoration: const InputDecoration(
                  labelText: 'Waktu Persiapan (menit)',
                  prefixIcon: Icon(Icons.timer),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Waktu persiapan harus diisi' : null,
              ),
              const SizedBox(height: 16),
              // Field baru untuk Waktu Memasak
              TextFormField(
                controller: _cookTimeController,
                keyboardType: TextInputType.number, // Tampilkan keyboard angka
                decoration: const InputDecoration(
                  labelText: 'Waktu Memasak (menit)',
                  prefixIcon: Icon(Icons.timer_outlined),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Waktu memasak harus diisi' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Bahan-bahan',
                  prefixIcon: Icon(Icons.shopping_basket),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Bahan-bahan harus diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Langkah-langkah',
                  prefixIcon: Icon(Icons.format_list_numbered),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Langkah-langkah harus diisi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: const Text('Simpan Resep'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllRecipesPage extends StatefulWidget {
  const AllRecipesPage({super.key});

  @override
  State<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends State<AllRecipesPage> {
  @override
  Widget build(BuildContext context) {
    final recipes = RecipeData.recipes;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Resep'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Daftar semua resep tersedia', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(recipe['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Kategori: ${recipe['category']}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: recipe,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({super.key});

  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    List<Map<String, dynamic>> results = RecipeData.recipes.where((recipe) {
      return recipe['name'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Resep'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Temukan resep favorit Anda', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Cari resep...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.clear),
              ),
              onSubmitted: (value) => _performSearch(value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _performSearch(_searchController.text),
              child: const Text('Cari'),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: _searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'Masukkan kata kunci untuk mencari resep',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final recipe = _searchResults[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            title: Text(recipe['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Kategori: ${recipe['category']}'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: recipe,
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryRecipePage extends StatefulWidget {
  const CategoryRecipePage({super.key});

  @override
  State<CategoryRecipePage> createState() => _CategoryRecipePageState();
}

class _CategoryRecipePageState extends State<CategoryRecipePage> {
  String _selectedCategory = 'Makanan Utama';

  final List<String> _categories = [
    'Makanan Utama',
    'Makanan Pembuka',
    'Makanan Penutup',
    'Minuman',
    'Cemilan',
  ];

  List<Map<String, dynamic>> get _currentRecipes {
    return RecipeData.recipes.where((recipe) => recipe['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep Berdasarkan Kategori'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Pilih kategori resep', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Pilih Kategori',
                prefixIcon: Icon(Icons.category),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: _currentRecipes.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada resep dalam kategori ini',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _currentRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _currentRecipes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            title: Text(recipe['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Kategori: ${recipe['category']}'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: recipe,
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteRecipePage extends StatefulWidget {
  const DeleteRecipePage({super.key});

  @override
  State<DeleteRecipePage> createState() => _DeleteRecipePageState();
}

class _DeleteRecipePageState extends State<DeleteRecipePage> {
  @override
  Widget build(BuildContext context) {
    final recipes = RecipeData.recipes;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hapus Resep'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Pilih resep yang akan dihapus', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            Expanded(
              child: recipes.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada resep untuk dihapus',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = recipes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            title: Text(recipe['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Kategori: ${recipe['category']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Konfirmasi Hapus'),
                                    content: Text('Apakah Anda yakin ingin menghapus resep "${recipe['name']}"?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          RecipeData.deleteRecipe(recipe['id']);
                                          setState(() {});
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Resep berhasil dihapus')),
                                          );
                                        },
                                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              recipe['name'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 8),
            Text(
              'Kategori: ${recipe['category']}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Waktu Memasak',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Persiapan: ${recipe['prepTime']} menit',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Memasak: ${recipe['cookTime']} menit',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Bahan-bahan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              recipe['ingredients'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Langkah-langkah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              recipe['steps'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}