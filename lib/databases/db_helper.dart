import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'trackingpaket3.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Buat tabel tracking
        await db.execute(
          "CREATE TABLE tracking(id INTEGER PRIMARY KEY AUTOINCREMENT, resi TEXT UNIQUE, courier TEXT, timestamp TEXT)",
        );

        // Buat tabel user_data untuk menyimpan data user (nama, alamat, path foto)
        await db.execute(
          "CREATE TABLE user_data(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT, imagePath TEXT)",
        );
      },
    );
  }

  // Fungsi untuk menambah atau memperbarui tracking paket
  Future<void> addOrUpdateTrackingRecord(String resi, String courier) async {
    final db = await database;

    // Hapus data lama (jika ada)
    await db.delete(
      'tracking',
      where: 'resi = ?',
      whereArgs: [resi],
    );

    // Tambah data baru dengan timestamp saat ini
    await db.insert(
      'tracking',
      {
        'resi': resi,
        'courier': courier,
        'timestamp': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fungsi untuk mengambil semua data tracking
  Future<List<Map<String, dynamic>>> getTrackingRecords() async {
    final db = await database;
    return db.query(
      'tracking',
      orderBy: 'timestamp DESC', // Urutkan berdasarkan timestamp terbaru
    );
  }

  Future<bool> hasUserData() async {
  final db = await DBHelper().database;
  final result = await db.query('user_data');
  return result.isNotEmpty; // Return true if there is user data
}


  // Fungsi untuk menghapus tracking berdasarkan id
  Future<void> deleteTrackingRecord(int id) async {
    final db = await database;
    await db.delete(
      'tracking',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // === Fitur Baru untuk Data Pengguna ===

  // Fungsi untuk menambahkan data pengguna (nama, alamat, path gambar)
  Future<void> insertUserData(
      String name, String address, String imagePath) async {
    final db = await database;

    // Masukkan atau perbarui data user
    await db.insert(
      'user_data',
      {
        'name': name,
        'address': address,
        'imagePath': imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fungsi untuk menghapus data pengguna
  Future<void> deleteUserData(int id) async {
    final db = await database;
    await db.delete(
      'user_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

Future<Map<String, String>> getUserData() async {
  final db = await DBHelper().database;
  final List<Map<String, dynamic>> result =
      await db.query('user_data', limit: 1);

  if (result.isNotEmpty) {
    return {
      'name': result[0]['name'] ?? 'Nama Tidak Ditemukan',
      'imagePath': result[0]['imagePath'] ??
          'assets/images/placeholder_avatar.png', // Default image if null
    };
  } else {
    return {
      'name': 'Nama Tidak Ditemukan',
      'imagePath':
          'assets/images/placeholder_avatar.png', // Default image if no data
    };
  }
}


Future<String> getUserName() async {
  final db = await DBHelper().database;
  final List<Map<String, dynamic>> result =
      await db.query('user_data', limit: 1);

  if (result.isNotEmpty) {
    return result[0]['name'] ??
        'Lorem Ipsum'; // Jika nama tidak ada, gunakan default
  } else {
    return 'Lorem Ipsum'; // Jika tidak ada data, tampilkan placeholder
  }
}
