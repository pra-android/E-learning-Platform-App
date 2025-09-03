import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavouritesDb {
  static Database? _database;
  FavouritesDb._init();
  static final instance = FavouritesDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb("favourites.db");
    return _database!;
  }

  Future<Database?> _initDb(String s) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, s);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE favourites(courseId TEXT PRIMARY KEY,title TEXT,imageUrl TEXT,description TEXT,
rating TEXT,comments TEXT,duration TEXT,pages TEXT,price TEXT,videoUrl TEXT,pdfs TEXT)''',
    );
  }

  Future<void> addFavourites(Map<String, dynamic> course) async {
    final ratings = (course["ratings"] as List)
        .map((r) => r["rating"] as num)
        .toList();
    double avgRating = 0.0;
    if (ratings.isNotEmpty) {
      avgRating = ratings.reduce((a, b) => a + b) / ratings.length;
    }
    final comments = course["comments"];
    int commentsCount = 0;
    if (comments != null && comments is List) {
      commentsCount = comments.length;
    }

    final db = await instance.database;
    await db.insert("favourites", {
      "imageUrl": course['imageUrl'],
      "title": course["title"],
      "courseId": course["courseId"].toString(),
      "description": course["description"],
      "rating": avgRating.toString(),
      "comments": commentsCount.toString(),
      "duration": course["duration"],
      "pages": course["pages"],
      "price": course["price"],
      "videoUrl": course["videoUrl"] ?? "",
      "pdfs": jsonEncode(course["pdfs"] ?? []),
    });
  }

  Future<void> removeFavourites(String courseId) async {
    final db = await instance.database;
    await db.delete("favourites", where: "courseId = ?", whereArgs: [courseId]);
  }

  Future<bool> isFavorite(String courseId) async {
    final db = await instance.database;
    final result = await db.query(
      "favourites",
      where: "courseId = ?",
      whereArgs: [courseId],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await instance.database;
    final results = await db.query("favourites");
    return results.map((course) {
      return {
        ...course,
        "videoUrl": course["videoUrl"],
        "pdfs": jsonDecode((course["pdfs"] as String?) ?? "[]"),
      };
    }).toList();
  }
}
