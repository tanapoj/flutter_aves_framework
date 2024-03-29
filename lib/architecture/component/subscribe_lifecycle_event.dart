import 'dart:async';
import 'package:flutter_live_data/index.dart' as fld;

class SubscribeLifeCycleEvent {
  final List<dynamic> streamSubscription = [];

  StreamSubscription<T> call<T>(
    fld.LiveData<T> liveData,
    void Function(T value) onData, {
    void Function()? onDone,
    Function? onError,
    bool? cancelOnError,
  }) {
    StreamSubscription<T> ss = liveData.listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    )!;
    streamSubscription.add(ss);
    return ss;
  }

  onCtor() {}

  onInit() {}

  onPause() {
    for (var s in streamSubscription) {
      if (s is! StreamSubscription) continue;
      StreamSubscription subscription = s;
      subscription.pause();
    }
  }

  onResume() {
    for (var s in streamSubscription) {
      if (s is! StreamSubscription) continue;
      StreamSubscription subscription = s;
      subscription.resume();
    }
  }

  onDispose() {
    onPause();
    streamSubscription.clear();
  }
}
