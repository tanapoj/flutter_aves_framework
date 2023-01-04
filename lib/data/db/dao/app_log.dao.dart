import 'package:aves/data/db/entities/app_log.entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class AppLogDao {
  @Query('SELECT * FROM Person')
  Future<List<AppLogEntity>> findAllLogs();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<AppLogEntity?> findLogById(int id);

  @insert
  Future<void> insertLog(AppLogEntity log);
}
