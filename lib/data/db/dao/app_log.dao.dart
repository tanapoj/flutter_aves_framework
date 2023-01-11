import 'package:aves/data/db/entities/app_log.entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class AppLogDao {
  @Query('SELECT * FROM app_log')
  Future<List<AppLogEntity>> findAllLogs();

  @Query('SELECT * FROM app_log WHERE id = :id')
  Stream<AppLogEntity?> findLogById(int id);

  @Query('SELECT * FROM task app_log WHERE id < :id')
  Stream<List<AppLogEntity>> findLogBefore(int id);

  @insert
  Future<void> insertLog(AppLogEntity log);

  @delete
  Future<void> deleteTasks(List<AppLogEntity> tasks);
}
