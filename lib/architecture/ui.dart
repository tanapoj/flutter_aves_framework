import 'package:aves/index.dart';
import 'package:flutter_live_data/live_source.dart';

class AvesUi<Theme> {
  syncInit() {}

  asyncInit() async {}

  Theme get theme {
    if ($state.value != null) {
      return $state.value!;
    } else {
      throw Exception('theme is null, you should load theme in `asyncInit` before use.');
    }
  }

  LiveData<Theme?> $state = LiveSource(
    null,
    adapter: LiveDataSourceAdapter(
      saveData: (value) async {},
    ),
  );

  setTheme(Theme theme) {
    $state.value = theme;
  }
}
