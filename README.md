# ResepKu - Aplikasi Resep Digital

Aplikasi ResepKu adalah aplikasi mobile berbasis Flutter yang dirancang sebagai buku resep digital. Aplikasi ini bertujuan untuk memudahkan pengguna dalam menyimpan, melihat, mencari, dan mengelola berbagai macam resep makanan dan minuman. Dengan antarmuka yang intuitif dan fitur yang lengkap, ResepKu menjadi solusi praktis untuk para pecinta kuliner yang ingin mengorganisir resep mereka secara digital.

## Fitur Utama

-   **Manajemen Resep Lengkap:** Menambah, melihat, mencari, dan menghapus resep.
-   **Autentikasi Pengguna:** Sistem login dan pendaftaran pengguna yang aman.
-   **Pencarian & Filter:** Mencari resep berdasarkan nama atau menyaringnya berdasarkan kategori.
-   **Navigasi Intuitif:** Menggunakan `BottomNavigationBar` untuk perpindahan antar halaman yang mudah.
-   **Data Tersinkronisasi:** Semua perubahan data (tambah/hapus resep) langsung terupdate di seluruh halaman aplikasi.

## Teknologi dan Konsep Penerapan

Proyek ini dikembangkan menggunakan framework Flutter dengan bahasa pemrograman Dart. Beberapa konsep dan komponen utama yang diterapkan untuk memenuhi kriteria yang ditentukan adalah:

### Tampilan (UI)

-   **ListView.builder:** Digunakan secara ekstensif pada halaman `AllRecipesPage`, `SearchRecipePage`, `CategoryRecipePage`, dan `DeleteRecipePage` untuk menampilkan daftar resep secara efisien dan dinamis.
-   **Stack:** Diterapkan pada halaman `LoginPage` dan `SignUpPage` untuk menciptakan tampilan berlapis dengan background gradien yang menarik di belakang form login dan pendaftaran.

### Navigasi & Rute

-   **Navigator.pushNamed:** Digunakan untuk berpindah antar halaman, seperti dari menu utama ke halaman tambah resep atau dari daftar resep ke halaman detail.
-   **BottomNavigationBar:** Diimplementasikan pada `MainNavigationPage` sebagai navigasi utama aplikasi, memungkinkan pengguna beralih antar halaman inti (Beranda, Semua Resep, Cari, Profil) dengan mudah.

### Stateful Widget

-   Halaman **Sign In** (`LoginPage`) dan **Sign Up** (`SignUpPage`) sepenuhnya memanfaatkan komponen `StatefulWidget`. Ini terlihat dari penggunaan `TextEditingController` untuk mengelola input teks, `setState()` untuk memperbarui tampilan (misalnya, toggle visibility password), dan penyimpanan data pengguna secara dinamis ke dalam class `UserData`.

## Deskripsi Halaman

Berikut adalah penjelasan rinci untuk setiap halaman dalam aplikasi ResepKu:

-   **Halaman Login (`LoginPage`)**
    -   **Tujuan:** Sebagai gerbang masuk bagi pengguna untuk mengakses aplikasi.
    -   **Fitur Utama:** Form input email dan password, toggle untuk melihat/menyembunyikan password, dan navigasi ke halaman pendaftaran.
    -   **Implementasi Kunci:** Menggunakan `StatefulWidget` dengan `Stack` untuk background gradien. Input form dikelola dengan `TextEditingController`, dan logika autentikasi memanfaatkan class `UserData` untuk memvalidasi kredensial pengguna.

-   **Halaman Pendaftaran (`SignUpPage`)**
    -   **Tujuan:** Memungkinkan pengguna baru untuk membuat akun.
    -   **Fitur Utama:** Form pendaftaran lengkap (nama, email, password, konfirmasi password), validasi input, dan toggle visibility password.
    -   **Implementasi Kunci:** Mirip dengan halaman login, halaman ini menggunakan `StatefulWidget` dan `Stack`. Data pengguna baru yang valid akan disimpan ke dalam class `UserData` sehingga dapat digunakan untuk login selanjutnya.

-   **Halaman Navigasi Utama (`MainNavigationPage`)**
    -   **Tujuan:** Kerangka utama aplikasi yang mengelola navigasi antar halaman fitur.
    -   **Fitur Utama:** `BottomNavigationBar` dengan empat tab: Beranda, Semua Resep, Cari, dan Profil.
    -   **Implementasi Kunci:** Menggunakan `StatefulWidget` untuk mengelola indeks tab yang aktif (`_currentIndex`) dan menampilkan halaman yang sesuai berdasarkan tab yang dipilih pengguna.

-   **Halaman Beranda (`HomePage`)**
    -   **Tujuan:** Menampilkan menu-menu utama dan pintasan ke fitur-fitur unggulan.
    -   **Fitur Utama:** Tombol navigasi untuk "Tambah Resep Baru", "Resep Berdasarkan Kategori", dan "Hapus Resep".
    -   **Implementasi Kunci:** Halaman `StatelessWidget` yang sederhana dengan `Column` untuk menata tombol-tombol menu secara vertikal.

-   **Halaman Semua Resep (`AllRecipesPage`)**
    -   **Tujuan:** Menampilkan daftar lengkap semua resep yang tersedia dalam aplikasi.
    -   **Fitur Utama:** Daftar resep dalam bentuk kartu yang dapat diklik untuk melihat detail.
    -   **Implementasi Kunci:** Menggunakan `ListView.builder` untuk merender daftar resep secara efisien. Setiap item dalam daftar (`ListTile`) memiliki `onTap` yang menavigasi ke `RecipeDetailPage` sambil membawa data resep terkait.

-   **Halaman Cari Resep (`SearchRecipePage`)**
    -   **Tujuan:** Memungkinkan pengguna mencari resep berdasarkan nama.
    -   **Fitur Utama:** Kolom pencarian, tombol cari, dan menampilkan hasil pencarian yang relevan.
    -   **Implementasi Kunci:** Menggunakan `StatefulWidget` untuk mengelola state hasil pencarian (`_searchResults`). `ListView.builder` digunakan untuk menampilkan hasil pencarian yang dinamis.

-   **Halaman Kategori Resep (`CategoryRecipePage`)**
    -   **Tujuan:** Menyaring dan menampilkan resep berdasarkan kategori tertentu (misalnya, Makanan Utama, Minuman).
    -   **Fitur Utama:** Dropdown untuk memilih kategori dan menampilkan daftar resep yang sesuai.
    -   **Implementasi Kunci:** `StatefulWidget` digunakan untuk mengelola state kategori yang dipilih. `ListView.builder` menampilkan resep dari kategori yang dipilih.

-   **Halaman Tambah Resep (`AddRecipePage`)**
    -   **Tujuan:** Form untuk menambahkan resep baru ke dalam koleksi.
    -   **Fitur Utama:** Form input untuk nama resep, waktu persiapan, waktu memasak, kategori (dropdown), bahan-bahan, dan langkah-langkah. Dilengkapi dengan validasi form.
    -   **Implementasi Kunci:** Menggunakan `StatefulWidget` dengan `Form` dan `GlobalKey` untuk validasi. `TextEditingController` digunakan untuk setiap field input.

-   **Halaman Hapus Resep (`DeleteRecipePage`)**
    -   **Tujuan:** Menampilkan daftar resep yang dapat dihapus oleh pengguna.
    -   **Fitur Utama:** Daftar resep dengan ikon hapus di setiap item dan dialog konfirmasi sebelum menghapus.
    -   **Implementasi Kunci:** `StatefulWidget` untuk mengelola daftar resep yang dapat berubah (berkurang). `ListView.builder` menampilkan daftar, dan `showDialog` digunakan untuk konfirmasi penghapusan.

-   **Halaman Detail Resep (`RecipeDetailPage`)**
    -   **Tujuan:** Menampilkan informasi lengkap tentang sebuah resep.
    -   **Fitur Utama:** Menampilkan nama, kategori, waktu memasak, bahan-bahan, dan langkah-langkah pembuatan.
    -   **Implementasi Kunci:** Halaman `StatelessWidget` yang menerima data resep melalui `ModalRoute.of(context)!.settings.arguments`. `ListView` digunakan untuk memastikan seluruh konten dapat di-scroll.

-   **Halaman Profil (`ProfilePage`)**
    -   **Tujuan:** Menampilkan informasi pengguna dan pengaturan akun.
    -   **Fitur Utama:** Avatar pengguna, nama, email, dan tombol untuk keluar (logout).
    -   **Implementasi Kunci:** Halaman `StatelessWidget` yang sederhana. Tombol keluar menggunakan `Navigator.pushReplacementNamed` untuk mengarahkan pengguna kembali ke halaman login dan membersihkan stack navigasi.

## Cara Menjalankan Aplikasi

Untuk menjalankan proyek ini secara lokal, ikuti langkah-langkah berikut:

1.  **Clone Repository**
    ```bash
    git clone https://github.com/nashwanfz/2309106125_Nashwan-Faiz-Nandana_PosttestKB3.git
    cd 2309106125_Nashwan-Faiz-Nandana_PosttestKB3
    ```

2.  **Install Dependencies**
    Pastikan Anda sudah menginstal Flutter. Jalankan perintah berikut untuk mengunduh semua dependensi yang dibutuhkan:
    ```bash
    flutter pub get
    ```

3.  **Jalankan Aplikasi**
    ```bash
    flutter run
    ```
