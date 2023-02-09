import 'package:flutter_live_data/index.dart';
import 'package:flutter_live_data/live_source.dart';

class AvesAuth<User> {
  syncInit() {}

  asyncInit() async {}

  bool get isLogin => $state.value != null;

  User? get user => $state.value;

  LiveData<User?> $state = LiveSource(
    null,
    adapter: LiveDataSourceAdapter(
      saveData: (value) async {},
    ),
  );

  setUser(User user) {
    $state.value = user;
  }

  unsetUser() {
    $state.value = null;
  }
}
