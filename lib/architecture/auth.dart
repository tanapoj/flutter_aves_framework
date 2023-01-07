import 'package:flutter_live_data/index.dart';

class AvesAuth<User> {
  syncInit() {}

  asyncInit() async {
    return Future.value(null);
  }

  bool get isLogin => user != null; // || user is GuestUser;

  User? get user => $state.value;

  LiveDataSource<User?> $state = LiveDataSource(
    null, // GuestUser(),
    dataSourceInterface: null,
  );

  setUser(User user) {
    $state.value = user;
  }

  unsetUser() {
    $state.value = null;
  }
}

abstract class AvesUser {
  String? serialize();

  void unserialize(String? serializeString);
}