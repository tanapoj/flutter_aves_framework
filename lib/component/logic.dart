import 'dart:async';

import 'package:aves/common/syslog.dart';
import 'package:aves/component/periodic_lifecycle_event.dart';
import 'package:aves/component/subscribe_lifecycle_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_data/index.dart' as fld;
import 'legacy/index.dart' as legacy;

abstract class Logic<T> extends legacy.ComponentLogic {
  String get name;

  final bool _logging;

  final SubscribeLifeCycleEvent _subscribeLifeCycleEvent = SubscribeLifeCycleEvent();
  final PeriodicLifeCycleEvent _periodicLifeCycleEvent = PeriodicLifeCycleEvent();

  Logic({
    Key? key,
    required Widget Function(T) builder,
    bool showSysLog = true,
  })  : _logging = showSysLog,
        super(
        key: key,
        builder: (legacy.ComponentLogic component) => builder(component as T),
      ) {
    _selfLog('construct');
    _subscribeLifeCycleEvent.onCtor();
    _periodicLifeCycleEvent.onCtor();
  }

  String get _logTag => sysLog.magenta('[Logic: $name]');

  _selfLog(String message) {
    if (_logging) {
      sysLog.i('$_logTag - $message');
    }
  }

  subscribe<T>(
      fld.LiveData<T>? liveData,
      void Function(T value) onData,
      ) {
    if (liveData == null) return;
    if (attr.isInitializingState) {
      sysLog.w('call [subscribe] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'move code to onCreate');
    }
    return _subscribeLifeCycleEvent.call(liveData, onData);
  }

  PeriodicTimerSnap periodic(
      Duration duration,
      void Function(Timer timer) callback,
      ) {
    if (attr.isInitializingState) {
      sysLog.w('call [periodic] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'move code to onCreate');
    }

    return _periodicLifeCycleEvent.call(duration, callback);
  }

  @override
  onCreate() {
    super.onCreate();
    _selfLog('onCreate');
  }

  @override
  void onInit() {
    _selfLog('onInit');
    super.onInit();
    _subscribeLifeCycleEvent.onInit();
    _periodicLifeCycleEvent.onInit();
  }

  @override
  onResume() {
    _selfLog('onResume');
    super.onResume();
    _subscribeLifeCycleEvent.onResume();
    _periodicLifeCycleEvent.onResume();
  }

  @override
  void onDispose() {
    _subscribeLifeCycleEvent.onDispose();
    _periodicLifeCycleEvent.onDispose();
    super.onDispose();
    _selfLog('onDispose');
  }

  @override
  onPause() {
    _subscribeLifeCycleEvent.onPause();
    _periodicLifeCycleEvent.onPause();
    super.onPause();
    _selfLog('onPause');
  }

  @override
  void onInactive() {
    super.onDetach();
    _selfLog('onInactive');
  }

  @override
  void onDetach() {
    super.onDetach();
    _selfLog('onDetach');
  }
}
