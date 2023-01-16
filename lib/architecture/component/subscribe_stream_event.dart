import 'dart:async';
import 'package:flutter_live_data/index.dart' as fld;

class SubscribeStreamEvent {
  final List<dynamic> streamSubscription = [];

  StreamSubscription<T> call<T>(
    Stream<T> stream,
    void Function(T value) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    StreamSubscription<T> ss = stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
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
