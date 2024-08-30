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
  final path = join(await getDatabasesPath(), 'trackingpaket.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE tracking(id INTEGER PRIMARY KEY AUTOINCREMENT, resi TEXT UNIQUE, courier TEXT, timestamp TEXT)",
      );
    },
    version: 1,
  );
  }

  Future<void> addOrUpdateTrackingRecord(String resi, String courier) async {
  final db = await database;

  // Optionally delete existing record
  await db.delete(
    'tracking',
    where: 'resi = ?',
    whereArgs: [resi],
  );

  // Insert new record with current timestamp
  await db.insert(
    'tracking',
    {
      'resi': resi,
      'courier': courier,
      'timestamp': DateTime.now().toIso8601String(), // Add current timestamp
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  Future<List<Map<String, dynamic>>> getTrackingRecords() async {
  final db = await database;
  return db.query(
    'tracking',
    orderBy: 'timestamp DESC', // Ensure sorting if needed
  );
}

Future<void> deleteTrackingRecord(int id) async {
    final db = await database;
    await db.delete(
      'tracking',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
