import 'dart:io';

class Printer {
  write(dynamic message) {
    stdout.write(message);
  }

  writeln(dynamic message) {
    stdout.writeln(message);
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

Printer printer = Printer();
