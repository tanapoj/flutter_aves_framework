import 'dart:async';

import 'package:aves/common/syslog.dart';


class PeriodicLifeCycleEvent {
  final List<PeriodicTimerSnap> periodicTimerSnap = <PeriodicTimerSnap>[];

  call(
    Duration duration,
    void Function(Timer timer) callback,
  ) {
    var snap = PeriodicTimerSnap(duration, callback);
    _startTask(snap);
    periodicTimerSnap.add(snap);
    return snap;
  }

  _startTask(PeriodicTimerSnap snap) {
    snap.timer?.cancel();
    snap.timer = Timer.periodic(snap.duration, (Timer timer) {
      snap.callback(timer);
      snap.run = true;
    });
  }

  _cancel() {
    int clearCount = 0;
    for (var snap in periodicTimerSnap) {
      snap.timer?.cancel();
      snap.run = false;
      clearCount++;
    }
    if (clearCount > 0) {
      sysLog.i('clear periodic TimerSnap for $clearCount instances.');
    }
  }

  onCtor() {
    for (var snap in periodicTimerSnap) {
      if (!snap.run) {
        _startTask(snap);
      }
    }
  }

  onInit() {
    for (var snap in periodicTimerSnap) {
      _startTask(snap);
      // snap.timer = Timer.periodic(snap.duration, (Timer timer) {
      //   snap.callback(timer);
      //   snap.run = true;
      // });
    }
  }

  onResume() {
    for (var snap in periodicTimerSnap) {
      _startTask(snap);
      // snap.timer = Timer.periodic(snap.duration, (Timer timer) {
      //   snap.callback(timer);
      //   snap.run = true;
      // });
    }
  }

  onPause() {
    _cancel();
  }

  onDispose() {
    _cancel();
    // periodicTimerSnap.clear();
  }
}

class PeriodicTimerSnap {
  final Duration duration;
  final void Function(Timer timer) callback;
  Timer? timer;
  bool run = false;

  PeriodicTimerSnap(this.duration, this.callback);

  PeriodicTimerSnap startNow() {
    Future.delayed(const Duration(microseconds: 1), () {
      if (timer != null) {
        callback(timer!);
      }
    });
    return this;
  }

  @override
  String toString() {
    return 'PeriodicTimerSnap{duration: $duration, callback: $callback, timer: $timer, run: $run}';
  }
}
