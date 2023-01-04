import 'package:floor/floor.dart';

@Entity(tableName: 'app_log')
class AppLogEntity {
  @PrimaryKey()
  @ColumnInfo(name: 'id')
  final int id;

  @ColumnInfo(name: 'log_type')
  final String logType;

  @ColumnInfo(name: 'message')
  final String message;

  AppLogEntity(this.id, this.logType, this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLogEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          logType == other.logType &&
          message == other.message;

  @override
  int get hashCode => id.hashCode ^ logType.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'AppLogEntity{id: $id, logType: $logType, message: $message}';
  }
}
