import 'package:flutter/widgets.dart';

@immutable
abstract class Environment {
  String get envName => 'default env';

  String get appName => 'My Aves Framework';

  int get logLevel => 1;

  bool get isProduction {
    return false;
  }

  bool get isUsingNetworkMockData {
    return false;
  }

  bool get isDebugMode {
    return true;
  }

  bool get isLogging {
    return true;
  }

  bool get isSystemLogging {
    return true;
  }
}
