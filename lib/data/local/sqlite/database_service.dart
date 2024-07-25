import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:adam_fauzan_frond_end/model/kategori_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class DatabaseService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<Database> _database() async {
    return openDatabase(
      'my_database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE barang (id INTEGER PRIMARY KEY, nama_barang TEXT, kategori_id INTEGER, stok INTEGER, kelompok_barang TEXT, harga REAL)',
        );
        await db.execute(
          'CREATE TABLE kategori (id INTEGER PRIMARY KEY, nama_kategori TEXT)',
        );
      },
    );
  }

  Future<List<Barang>> getBarangPaginated(int page, int limit) async {
    final db = await _database();
    final offset = (page - 1) * limit;
    final List<Map<String, dynamic>> maps = await db.query(
      'barang',
      offset: offset,
      limit: limit,
    );

    return List.generate(maps.length, (i) {
      return Barang(
        id: maps[i]['id'],
        namaBarang: maps[i]['nama_barang'],
        kategoriId: maps[i]['kategori_id'],
        stok: maps[i]['stok'],
        kelompokBarang: maps[i]['kelompok_barang'],
        harga: maps[i]['harga'],
      );
    });
  }

  Future<int> addBarang(Barang barang) async {
    Database db = await _dbHelper.database;
    return await db.insert('barang', barang.toMap());
  }

  Future<int> addKategori(Kategori kategori) async {
    Database db = await _dbHelper.database;
    return await db.insert('kategori', kategori.toMap());
  }

  // Future<List<Barang>> getAllBarang() async {
  //   Database db = await _dbHelper.database;
  //   final List<Map<String, dynamic>> maps = await db.query('barang');

  //   return List.generate(maps.length, (i) {
  //     return Barang(
  //       id: maps[i]['id'],
  //       namaBarang: maps[i]['nama_barang'],
  //       kategoriId: maps[i]['kategori_id'],
  //       stok: maps[i]['stok'],
  //       kelompokBarang: maps[i]['kelompok_barang'],
  //       harga: maps[i]['harga'],
  //     );
  //   });
  // }

  Future<List<Kategori>> getAllKategori() async {
    Database db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('kategori');

    return List.generate(maps.length, (i) {
      return Kategori(
        id: maps[i]['id'],
        namaKategori: maps[i]['nama_kategori'],
      );
    });
  }

  Future<int> updateBarang(Barang barang) async {
    Database db = await _dbHelper.database;
    return await db.update(
      'barang',
      barang.toMap(),
      where: 'id = ?',
      whereArgs: [barang.id],
    );
  }

  Future<int> deleteBarang(int id) async {
    Database db = await _dbHelper.database;
    return await db.delete(
      'barang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
