import 'package:flutter/material.dart' as m;

class EventListenerWidget extends m.InheritedWidget {
  const EventListenerWidget({super.key, required super.child});

  static EventListenerWidget of(m.BuildContext context) {
    final EventListenerWidget? result = context.dependOnInheritedWidgetOfExactType<EventListenerWidget>();
    assert(result != null, 'No AvesProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant m.InheritedWidget oldWidget) {
    return true;
  }
}
