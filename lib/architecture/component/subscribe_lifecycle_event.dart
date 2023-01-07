import 'dart:async';
import 'package:flutter_live_data/index.dart' as fld;

class SubscribeLifeCycleEvent {
  final List<dynamic> streamSubscription = [];

  call<T>(
    fld.LiveData<T> liveData,
    void Function(T value) onData,
  ) {
    streamSubscription.add(liveData.listen(onData)!);
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
