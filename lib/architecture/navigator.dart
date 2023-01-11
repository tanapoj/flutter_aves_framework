import 'package:aves/common/syslog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef NavigatorTransition = Route Function(
  BuildContext context,
  Widget Function(BuildContext context) builder, {
  RouteSettings? settings,
});

abstract class AvesNavigator {
  syncInit() {}

  asyncInit() async {
    return Future.value(null);
  }

  Widget startup();

  Widget home();

  static NavigatorResult? _currentResult;

  static NavigatorResult? flashResult() {
    var r = _currentResult;
    _currentResult = null;
    return r;
  }

  static NavigatorTransition get defaultTransition => materialPageRouteTransition;

  static NavigatorTransition get materialPageRouteTransition {
    return (
      BuildContext context,
      Widget Function(BuildContext context) builder, {
      RouteSettings? settings,
    }) {
      return MaterialPageRoute(
        settings: settings,
        builder: builder,
      );
    };
  }

  static NavigatorTransition get transition1 {
    return (
      BuildContext context,
      Widget Function(BuildContext context) builder, {
      RouteSettings? settings,
    }) {
      return PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return builder(context);
        },
        settings: settings,
      );
    };
  }

  static NavigatorTransition get transition2 {
    return (
      BuildContext context,
      Widget Function(BuildContext context) builder, {
      RouteSettings? settings,
    }) {
      return PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return builder(context);
        },
        settings: settings,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(2.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      );
    };
  }

  Future<NavigatorResult> push(
    BuildContext context,
    Widget Function(BuildContext context) builder, {
    Key? refKey,
    NavigatorTransition? navigatorTransition,
  }) async {
    navigatorTransition ??= defaultTransition;

    var result = await Navigator.push(
      context,
      navigatorTransition(
        context,
        builder,
        settings: refKey == null ? null : RouteSettings(arguments: refKey),
      ),
    );

    if (result is NavigatorResult) {
      sysLog.i('pop page with result: $result');
      return result;
    }

    return NavigatorResult();
  }

  Future<NavigatorResult> pushReplacement(
    BuildContext context,
    Widget Function(BuildContext context) builder, {
    Key? refKey,
  }) async {
    var result = await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: refKey == null ? null : RouteSettings(arguments: refKey),
        builder: builder,
      ),
    );
    if (result is NavigatorResult) {
      sysLog.i('pop page with result: $result');
      return result;
    }
    return NavigatorResult(data: {'result': result});
  }

  AvesNavigator pop<T extends Object?>(
    BuildContext context, {
    NavigatorResult? result,
  }) {
    result ??= NavigatorResult();
    Navigator.pop(context, result);
    return this;
  }

  AvesNavigator popUntil<T extends Object?>(
    BuildContext context,
    RoutePredicate predicate, {
    NavigatorResult? result,
  }) {
    _currentResult = result;
    Navigator.popUntil(context, predicate);
    return this;
  }

  AvesNavigator popUntilRoot<T extends Object?>(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    return this;
  }
}

class AvesRouterFacade {
  final AvesNavigator appNavigator;
  final BuildContext context;
  final String checkPointName;

  AvesRouterFacade({
    required this.appNavigator,
    required this.context,
    required this.checkPointName,
  });

  Future<NavigatorResult> push(
    Widget Function(BuildContext context) builder, {
    Key? refKey,
    bool replacement = false,
  }) async {
    refKey ??= ValueKey(checkPointName);

    NavigatorResult result = replacement
        ? await appNavigator.pushReplacement(context, builder, refKey: refKey)
        : await appNavigator.push(context, builder, refKey: refKey);

    var flashResult = AvesNavigator.flashResult();
    if (flashResult != null) {
      sysLog.i('popUntil page(refKey: $refKey) with result: $flashResult');
      return flashResult;
    }

    return result;
  }

  AvesNavigator pop<T extends Object?>({
    NavigatorResult? result,
    RoutePredicate? until,
  }) {
    return until != null
        ? appNavigator.popUntil(context, until, result: result)
        : appNavigator.pop(context, result: result);
  }
}

class UntilPredicate {
  static RoutePredicate root() => (Route<dynamic> route) => route.isFirst;

  static RoutePredicate checkPoint(Key key) {
    var match = false;
    return (Route<dynamic> route) {
      if (route.isFirst) return true;
      if (match == true) return true;
      match = route.settings.arguments == key;
      return false;
    };
  }
}

class NavigatorResult {
  final Key? refKey;
  late final Object? data;

  NavigatorResult({
    this.refKey,
    this.data,
  });

  @override
  String toString() {
    return 'NavigatorResult{refKey: $refKey, data: $data}';
  }
}
