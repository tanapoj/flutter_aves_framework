import 'package:flutter/widgets.dart';
import 'package:flutter_live_data/index.dart';
import 'life_cycle_listener.dart';
import 'component_view.dart';

class _ImComponentProperties {
  bool isInitializingState = false;
  bool isCreatingState = false;
  late Widget view;
  void Function()? setRebuild;
  BuildContext? context;
}

class ComponentLogic extends StatefulWidget implements LifeCycleListener, LifeCycleOwner {
  final Widget Function(ComponentLogic) builder;
  final List<LiveData> _liveData = <LiveData>[];
  final _ImComponentProperties attr = _ImComponentProperties();

  BuildContext? get context => attr.context;

  ComponentLogic({
    Key? key,
    required this.builder,
  }) : super(key: key) {
    attr.view = builder(this);

    Future.delayed(const Duration(microseconds: 1), () {
      attr.isCreatingState = true;
      onCreate();
      attr.isCreatingState = false;
    });
  }

  onCreate() {
    if (attr.view is ComponentView) {
      (attr.view as ComponentView).onCreate();
    }
  }

  rebuild() {
    attr.setRebuild?.call();
  }

  @override
  State<StatefulWidget> createState() => _ComponentLogicState();

  @override
  void observeLiveData<T>(LiveData<T> liveData) {
    _liveData.add(liveData);
  }

  void clearObserveLiveData() {
    for (var liveData in _liveData) {
      liveData.close();
    }
    _liveData.clear();
  }

  Widget bindView(Widget view) {
    return attr.view = view;
  }

  // void bloComponentSelfInit() {}

  @override
  void onInit() {
    // TODO: implement onBuild
  }

  @override
  void onDispose() {
    // TODO: implement onBuild
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  @override
  void onInactive() {
    // TODO: implement onResume
  }

  @override
  void onDetach() {
    // TODO: implement onResume
  }

// onReassemble() {
//   appLog.i('==================================\n'
//       'onReassemble'
//       '==================================\n');
//   onDispose();
// }
}

class _ComponentLogicState extends State<ComponentLogic> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    widget.attr.context = context;
    Future.delayed(const Duration(microseconds: 1), () {
      widget.attr.isInitializingState = true;
      WidgetsBinding.instance.addObserver(this);
      widget.onInit();
      // widget.bloComponentSelfInit();
      _asView(widget.attr.view)?.onInit();
      widget.attr.isInitializingState = false;
    });
  }

  @override
  void dispose() {
    widget.onDispose();
    widget.clearObserveLiveData();
    _asView(widget.attr.view)?.onDispose();
    WidgetsBinding.instance.removeObserver(this);
    widget.attr.setRebuild = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.attr.context = context;
    widget.attr.setRebuild = rebuild;
    return widget.bindView(widget.builder(widget));
  }

  rebuild() {
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onResume();
      _asView(widget.attr.view)?.onResume();
    } else if (state == AppLifecycleState.paused) {
      widget.onPause();
      _asView(widget.attr.view)?.onPause();
    } else if (state == AppLifecycleState.inactive) {
      widget.onInactive();
      _asView(widget.attr.view)?.onInactive();
    } else if (state == AppLifecycleState.detached) {
      widget.onDetach();
      _asView(widget.attr.view)?.onDetach();
    }
  }

// @override
// reassemble() {
//   super.reassemble();
//   if (widget.onReassemble != null) {
//     widget.onReassemble();
//   }
// }
}

ComponentView? _asView(Widget w) => w is ComponentView ? w : null;
