import 'package:aves/common/log.dart';
import 'package:aves/common/extension/string.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as leisim;

Logger sysLog = SysLogger.instance;

class SysLogger extends Logger {
  static SysLogger? _instance;

  static SysLogger get instance {
    _instance ??= SysLogger();
    return _instance!;
  }

  @override
  void close() {
    // TODO: implement close
  }

  _printMultiLine(String output, {String suffix = ''}) {
    if (provider?.env.isSystemLogging == false) return;
    // AppDatabase db = inject<AppDatabase>().db;
    // db.appLogDao.insertLog(AppLogEntity(1, 'logType', 'message')).then((value) => null);

    var cs = output.chunk(1000);
    if (cs.isNotEmpty && cs.last.length + suffix.length <= 1000) {
      cs[cs.length - 1] = '${cs[cs.length - 1]}$suffix';
    } else {
      cs.add(suffix);
    }

    cs.forEach(print);
  }

  @override
  void v(message, [error, StackTrace? stackTrace]) {
    if (level.index >= leisim.Level.verbose.index && kDebugMode) {
      _printMultiLine('${black('[v]')} $message');
    }
  }

  @override
  void d(message, [error, StackTrace? stackTrace]) {
    _printMultiLine('${blue('sysd')} $message');
  }

  @override
  void i(message, [error, StackTrace? stackTrace]) {
    _printMultiLine('${blue('sysi')} $message');
  }

  @override
  void w(message, [error, StackTrace? stackTrace]) {
    //if (level.index >= leisim.Level.warning.index && kDebugMode) {

    List<String> stackTraceLine = '${StackTrace.current}'
        .split('\n')
        .where((line) => line.length > 2)
        .map((line) => line.substring(1).replaceAll(RegExp(r'^([0-9])+'), '').trim())
        .takeWhile((line) => !line.contains('package:flutter'))
        .skip(1)
        .toList();

    String stackTrace = stackTraceLine.isNotEmpty ? stackTraceLine[1] : '';

    _printMultiLine(yellow('\n'
        '=== WARNING ============================'
        '\n'
        '[w] $message'
        '\n'
        '    $stackTrace'
        '\n'));
    //}
  }

  @override
  void e(message, [error, StackTrace? stackTrace]) {
    // if (level.index >= leisim.Level.error.index && kDebugMode) {

    List<String> stackTraceLine = '${StackTrace.current}'
        .split('\n')
        .where((line) => line.length > 2)
        .map((line) => line.substring(1).replaceAll(RegExp(r'^([0-9])+'), '').trim())
        .takeWhile((line) => !line.contains('package:flutter'))
        .skip(1)
        .toList();

    String stackTrace = stackTraceLine.map((line) => '    $line').join('\n');

    _printMultiLine(red('\n'
        '=== ERROR =============================='
        '\n'
        '[e] $message'
        '\n'
        '$stackTrace'
        '\n'));

    // }
  }

  @override
  void log(leisim.Level level, message, [error, StackTrace? stackTrace]) {
    _printMultiLine(message);
  }

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {
    // TODO: implement wtf
  }

  // Black:   \x1B[30m
  // Red:     \x1B[31m
  // Green:   \x1B[32m
  // Yellow:  \x1B[33m
  // Blue:    \x1B[34m
  // Magenta: \x1B[35m
  // Cyan:    \x1B[36m
  // White:   \x1B[37m
  // Reset:   \x1B[0m

  String black(String msg) {
    return '\x1B[30m$msg\x1B[0m';
  }

  String red(String msg) {
    return '\x1B[31m$msg\x1B[0m';
  }

  String green(String msg) {
    return '\x1B[32m$msg\x1B[0m';
  }

  String blue(String msg) {
    return '\x1B[34m$msg\x1B[0m';
  }

  String cyan(String msg) {
    return '\x1B[36m$msg\x1B[0m';
  }

  String magenta(String msg) {
    return '\x1B[35m$msg\x1B[0m';
  }

  String yellow(String msg) {
    return '\x1B[33m$msg\x1B[0m';
  }

  String white(String msg) {
    return '\x1B[37m$msg\x1B[0m';
  }
}
