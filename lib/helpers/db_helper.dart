import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  //setting db
  static Future<sql.Database> database() async {
    //get or create a database in the app
    final dbPath = await sql.getDatabasesPath();

    //opens the existing database which we have create in the path and named "todo.db"
    return sql.openDatabase(path.join(dbPath, 'todo.db'),
        onCreate: (db, version) {
          // creating a table in the db with columns
          return db.execute(
              'CREATE TABLE user_todo(id PRIMARY KEY, title TEXT, date INT )');
        }, version: 1);
  }

  // inserting values into the tables
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //delete todos from the tables
  static Future<void> deleteTodos(String id) async {
    final db = await DBHelper.database();
    return await db.delete(
      'user_todo',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //getting values from tables
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
