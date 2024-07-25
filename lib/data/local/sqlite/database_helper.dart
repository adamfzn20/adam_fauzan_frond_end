import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE kategori (
        id INTEGER PRIMARY KEY,
        nama_kategori TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE barang (
        id INTEGER PRIMARY KEY,
        nama_barang TEXT,
        kategori_id INTEGER,
        stok INTEGER,
        kelompok_barang TEXT,
        harga REAL,
        FOREIGN KEY (kategori_id) REFERENCES kategori (id)
      )
    ''');

    // Pre-fill table kategori
    List<Map<String, String>> kategoriList = [
      {'nama_kategori': 'Elektronik'},
      {'nama_kategori': 'Fashion Pria'},
      {'nama_kategori': 'Fashion Wanita'},
      {'nama_kategori': 'Alat Rumah Tangga'},
    ];

    for (var kategori in kategoriList) {
      await db.insert('kategori', kategori);
    }
  }
}
