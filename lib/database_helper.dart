import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "ProfileDB.db";
  static const _databaseVersion = 1;

  static const table = 'profile';

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnEmail = 'email';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Tạo bảng khi DB được khởi tạo lần đầu
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL
          )
          ''');
          
    // Insert dữ liệu mẫu ban đầu
    await db.insert(table, {
      columnName: 'Nguyễn Công Vũ',
      columnEmail: '6451071089@st.utc2.edu.vn'
    });
  }

  // CREATE (Thêm mới Profile)
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // READ (Lấy ra Profile đầu tiên)
  Future<Map<String, dynamic>?> getProfile() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> res = await db.query(table, limit: 1);
    if (res.isNotEmpty) {
      return res.first;
    }
    return null;
  }

  // UPDATE (Cập nhật Profile)
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // DELETE (Xóa Profile)
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
