import 'package:client/data/model/extracted_pdf.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DocDb {
  static const String databaseName = 'auto_flashcard';
  static const String tableName = 'raw_docs';

  late final Database _db;

  Future<void> init() async {
    _db = await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (db, version) {
      return db.execute("CREATE TABLE $tableName(${ExtractedPdf.idColumnName} "
          "INTEGER PRIMARY KEY AUTOINCREMENT, ${ExtractedPdf.nameColumnName} TEXT NOT NULL UNIQUE,"
          " ${ExtractedPdf.pageContentColumnName} TEXT NOT NULL UNIQUE, "
          "${ExtractedPdf.pageColumnName} INTEGER NOT NULL)");
    });
  }


  Future<void> insertDocument(ExtractedPdf extractedPdf) async{
    await _db.insert(tableName, extractedPdf.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
