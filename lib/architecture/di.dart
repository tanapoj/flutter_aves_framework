import 'package:get_it/get_it.dart';

class AvesDi {
  final _getIt = GetIt.I;

  T get<T extends Object>([String? instanceName]) => _getIt.get<T>(instanceName: instanceName);

  void singletonFactory<T extends Object>(
    T Function(AvesDi) factory, {
    String? instanceName,
  }) {
    try {
      var i = _getIt.get<T>();
      _getIt.unregister(instance: i, instanceName: instanceName);
    } catch (e) {}
    try {
      _getIt.registerLazySingleton(() {
        return factory(this);
      }, instanceName: instanceName);
    } catch (e) {}
  }

  Future<void> singletonAsyncFactory<T extends Object>(
    Future<T> Function(AvesDi) factory, {
    String? instanceName,
  }) async {
    try {
      var i = _getIt.get<T>();
      _getIt.unregister(instance: i, instanceName: instanceName);
    } catch (e) {}
    try {
      var object = await factory(this);
      _getIt.registerLazySingleton(() {
        return object;
      }, instanceName: instanceName);
    } catch (e) {}
  }

  void singleton<T extends Object>(
    T instance, {
    String? instanceName,
  }) {
    try {
      try {
        var i = _getIt.get<T>(instanceName: instanceName);
        _getIt.unregister<T>(instance: i, instanceName: instanceName);
      } catch (e) {}
      _getIt.registerSingleton<T>(instance, instanceName: instanceName);
    } catch (e) {}
  }
}

class Di {
  static Di? _singleton;

  factory Di([AvesDi? container]) {
    _singleton ??= Di._internal();
    if (container != null) _singleton!.container = container;
    return _singleton!;
  }

  Di._internal();

  late AvesDi container = AvesDi();
}

extension DefaultSetting on AvesDi {
  AvesDi withDefaultDependencies() {
    // singletonFactory<int>((c) {
    //   return 1234;
    // }, instanceName: 'app-version');

    return this;
  }
}

T inject<T extends Object>([String? instanceName]) => Di().container.get<T>(instanceName);

//EnvironmentConfig injectEnv() => Di().container.get<EnvironmentConfig>('env');
