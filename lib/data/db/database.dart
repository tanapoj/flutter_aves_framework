import 'dart:async';
import 'package:aves/data/db/dao/app_log.dao.dart';
import 'package:aves/data/db/entities/app_log.entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [AppLogEntity])
abstract class AppDatabase extends FloorDatabase {
  AppLogDao get appLogDao;

  late final AppDatabase db;

  init() async {
    // db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
