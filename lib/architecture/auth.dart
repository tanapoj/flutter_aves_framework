import 'package:flutter_live_data/index.dart';

class AvesAuth<AppUser> {
  syncInit() {}

  asyncInit() async {
    return Future.value(null);
  }

  bool get isLogin => user != null; // || user is GuestUser;

  AppUser? get user => $state.value;

  LiveDataSource<AppUser?> $state = LiveDataSource(
    null, // GuestUser(),
    dataSourceInterface: null,
  );

  setUser(AppUser user) {
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