// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppLogDao? _appLogDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_log` (`id` INTEGER NOT NULL, `log_type` TEXT NOT NULL, `message` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppLogDao get appLogDao {
    return _appLogDaoInstance ??= _$AppLogDao(database, changeListener);
  }
}

class _$AppLogDao extends AppLogDao {
  _$AppLogDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _appLogEntityInsertionAdapter = InsertionAdapter(
            database,
            'app_log',
            (AppLogEntity item) => <String, Object?>{
                  'id': item.id,
                  'log_type': item.logType,
                  'message': item.message
                },
            changeListener),
        _appLogEntityDeletionAdapter = DeletionAdapter(
            database,
            'app_log',
            ['id'],
            (AppLogEntity item) => <String, Object?>{
                  'id': item.id,
                  'log_type': item.logType,
                  'message': item.message
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppLogEntity> _appLogEntityInsertionAdapter;

  final DeletionAdapter<AppLogEntity> _appLogEntityDeletionAdapter;

  @override
  Future<List<AppLogEntity>> findAllLogs() async {
    return _queryAdapter.queryList('SELECT * FROM app_log',
        mapper: (Map<String, Object?> row) => AppLogEntity(row['id'] as int,
            row['log_type'] as String, row['message'] as String));
  }

  @override
  Stream<AppLogEntity?> findLogById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM app_log WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AppLogEntity(row['id'] as int,
            row['log_type'] as String, row['message'] as String),
        arguments: [id],
        queryableName: 'app_log',
        isView: false);
  }

  @override
  Stream<List<AppLogEntity>> findLogBefore(int id) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM task app_log WHERE id < ?1',
        mapper: (Map<String, Object?> row) => AppLogEntity(row['id'] as int,
            row['log_type'] as String, row['message'] as String),
        arguments: [id],
        queryableName: 'task',
        isView: false);
  }

  @override
  Future<void> insertLog(AppLogEntity log) async {
    await _appLogEntityInsertionAdapter.insert(log, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTasks(List<AppLogEntity> tasks) async {
    await _appLogEntityDeletionAdapter.deleteList(tasks);
  }
}
