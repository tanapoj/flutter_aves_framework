/// Generated File, Do not modify this file.
/// to generate, run: fvm flutter pub run aves:gen

Map<String,String> template = {
"view-blank.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/index.dart' as app;
import '{{#class_name}}.logic.dart';

class {{#className}}View extends app.View<{{#className}}Logic> {
  const {{#className}}View({{#className}}Logic logic, {Key? key}) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text('placeholder for {{#className}}'),
    );
  }
}
""",
"model.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part '{{#class_name}}.g.dart';

//=========================================
// {{#className}}
//=========================================

@JsonSerializable(explicitToJson: true)
@immutable
class {{#className}} {

  // TODO: (1) add Model's Fields

  @JsonKey(name: 'example_field')
  final int? exampleField;

  // Do not modify this section

  factory {{#className}}.fromJson(Map<String, dynamic> json) => _\${{#className}}FromJson(json);

  Map<String, dynamic> toJson() => _\${{#className}}ToJson(this);

  // TODO: (2) generate Constructor, == and toString

  // TODO: (3) then run `flutter pub run aves build:model` or `fvm flutter pub run aves build:model`
}
""",
"view.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/index.dart' as app;
import '{{#class_name}}.logic.dart';

class {{#className}}View extends app.View<{{#className}}Logic> {
  const {{#className}}View({{#className}}Logic logic, {Key? key}) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('placeholder for {{#className}}'),
          \$watch(logic.\$counter, build: (_, int count) {
            return Text('count is \$count');
          }),
          ElevatedButton(
            onPressed: () {
              logic.increment();
            },
            child: const Text('increment'),
          ),
        ],
      ),
    );
  }
}
""",
"test.template": """class {{#className}}{
    int x = 0;
}""",
"logic-blank.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/index.dart';
import '{{#class_name}}.view.dart';

class {{#className}}Logic extends ComponentLogic {
  @override
  String get name => '{{#class_name}}';

  {{#className}}Logic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  factory {{#className}}Logic.build() {
    return {{#className}}Logic(
      builder: (logic) => {{#className}}View(logic as {{#className}}Logic),
    );
  }
}
""",
"logic.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/index.dart';
import '{{#class_name}}.view.dart';

class {{#className}}Logic extends ComponentLogic {
  @override
  String get name => '{{#class_name}}';

  /// Class Parameters
  /// if you want to customize, add here, then add parameter to constructor and build
  final LifeCycleOwner? parent;

  {{#className}}Logic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
    this.parent,
  }) : super(key: key, builder: builder);

  factory {{#className}}Logic.build({LifeCycleOwner? parent}) {
    return {{#className}}Logic(
      parent: parent,
      builder: (logic) => {{#className}}View(logic as {{#className}}Logic),
    );
  }

  /// Define LiveData
  late final LiveData<int> \$counter = LiveData(0).owner(this);
  late final LiveData<String?> \$nullable = LiveData<String?>(null).owner(this);

  /// LiveCycle Listener
  /// if no use, you can remove them

  @override
  onCreate() {
    super.onCreate();
    // TODO when page constructed
  }

  @override
  onInit() {
    super.onInit();
    // TODO when page start running
  }

  @override
  onResume() {
    super.onResume();
    // TODO when page resume after it paused
  }

  @override
  onPause() {
    // TODO when page leaving from display
    super.onPause();
  }

  @override
  onDispose() {
    // TODO when page destroy (end of running)
    super.onDispose();
  }

  /// Define action
  /// custom method, called by view
  increment() {
    \$counter.value++;
  }
}
""",
"init/build.yaml.template": """targets:
  \$default:
    builders:
      slang_build_runner:
        options:
          base_locale: en
          fallback_strategy: base_locale
          input_directory: assets/lang
          input_file_pattern: .lang.json
          output_directory: lib/config/lang
          # output_file_pattern: .g.dart # deprecated, use output_file_name
          output_file_name: translations.g.dart
          output_format: multiple_files #single_file
          locale_handling: true
          namespaces: false
          translate_var: slang_global_tt
          enum_name: AppLocale
          translation_class_visibility: public
          key_case: snake
          key_map_case: camel
          param_case: pascal
          string_interpolation: double_braces
          flat_map: false
          timestamp: true
          maps:
            - error.codes
            - category
            - iconNames
          pluralization:
            auto: cardinal
            cardinal:
              - someKey.apple
            ordinal:
              - someKey.place
          contexts:
            gender_context:
              enum:
                - male
                - female
              auto: false
              paths:
                - my.path.to.greet
          interfaces:
            PageData: onboarding.pages.*
            PageData2:
              paths:
                - my.path
                - cool.pages.*
              attributes:
                - String title
                - String? content""",
"init/main.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:bloc_builder/index.dart';
import 'package:{{#projectName}}/config/env/dev_mock.dart';
import 'package:{{#projectName}}/ui/main/startup.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'package:{{#projectName}}/common/log.dart';
import 'package:{{#projectName}}/config/lang/translations.g.dart';

void main() {
  Environment env = DevMockEnvironment();

  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  sysLog.i('run app, using environment: \$env');

  runApp(MainApplication(
    env: env,
  ));
}

class MainApplication extends StatelessWidget {
  final Environment env;

  const MainApplication({
    Key? key,
    required this.env,
  }) : super(key: key);

  @override
  Widget build(BuildContext _context) {
    sysLog.i('build MainApplication');
    return App(
      env: env,
      child: Builder(
        builder: (BuildContext context) {
          sysLog.i('build AppProvider');
          var app = App.of(context);
          app.syncInit();
          return \$watch(
            app.\$state,
            build: (context, _) {

              /// Custom Code here...
              sysLog.i('build-render MaterialApp');
              return MaterialApp(
                title: app.env.appName,
                theme: app.ui.theme.themeData,
                home: StartupPage.build(),
              );
            },
          );
        },
      ),
    );
  }
}
""",
"init/ui/main/startup.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

""",
"init/ui/widgets/example_widget.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

class ExampleWidget {
}""",
"init/app/app_provider.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/architecture/environment.dart';
import 'package:aves/architecture/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_live_data/index.dart';
import 'package:{{#projectName}}/app/app_auth.dart';
import 'package:{{#projectName}}/app/app_navigator.dart';
import 'package:{{#projectName}}/app/app_translator.dart';
import 'package:{{#projectName}}/app/app_ui.dart';
import 'package:{{#projectName}}/common/log.dart';
import 'package:{{#projectName}}/config/global_var.dart';
import 'package:{{#projectName}}/model/user.dart';

// ignore: must_be_immutable
class App extends AvesProvider {
  App({
    super.key,
    required super.child,
    required Environment env,
  }) : super(env: env);

  late AppContext variantContext;

  late final LiveData<App> \$state = LiveData(this);
  late AppNavigator _navigator = AppNavigator();
  late AppTranslator _translator = AppTranslator(this);
  late AppUi _ui = AppUi(this);
  late AppAuth<User> _auth = AppAuth<User>();
  late GlobalVar _globalVar = GlobalVar();

  AppNavigator get navigator => _navigator;

  AppTranslator get translator => _translator;

  AppUi get ui => _ui;

  AppAuth<User> get auth => _auth;

  GlobalVar get global => _globalVar;

  void set({
    Environment? env,
    AppNavigator? navigator,
    AppTranslator? translator,
    AppUi? ui,
    AppAuth<User>? auth,
    GlobalVar? globalVar,
  }) {
    if (env != null) {
      this.env = env;
    }
    if (navigator != null) {
      _navigator = navigator;
    }
    if (translator != null) {
      _translator = translator;
    }
    if (ui != null) {
      _ui = ui;
    }
    if (auth != null) {
      _auth = auth;
    }
    if (globalVar != null) {
      _globalVar = globalVar;
    }
  }

  static App? instance;

  static App of(BuildContext context) {
    final AvesProvider? result = context.dependOnInheritedWidgetOfExactType<App>();
    assert(result != null || result is! App, 'No AppProvider found in context');
    return instance = result! as App;
  }

  @override
  bool updateShouldNotify(App oldWidget) =>
      env != oldWidget.env &&
      navigator != oldWidget.navigator &&
      translator != oldWidget.translator &&
      ui != oldWidget.ui &&
      auth != oldWidget.auth;

  @override
  syncInit() {
    sysLog.d('AppProvider run syncInit ... start');
    navigator.syncInit();
    ui.syncInit();
    auth.syncInit();
    translator.syncInit();
    sysLog.d('AppProvider run syncInit ... done');
  }

  @override
  asyncInit() async {
    sysLog.d('AppProvider run asyncInit ... start');
    await Future.wait(<Future>[
      navigator.asyncInit(),
      ui.asyncInit(),
      auth.asyncInit(),
      translator.asyncInit(),
    ]);
    sysLog.d('AppProvider run asyncInit ... done');
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppProvider{\n'
        '   navigator: \$navigator\n'
        '   translator: \$translator\n'
        '   ui: \$ui\n'
        '   auth: \$auth\n'
        '}';
  }
}

/// App Facade

App app() {
  return App.instance!;
}

class AppContext {
  Environment? env;
  AppTranslator? translator;
  AppUi? ui;
  AppAuth<User>? auth;

  AppContext({this.env, this.translator, this.ui, this.auth});
}

extension AppIntercept on App {
  void override({
    required AppContext context,
    required void Function(AppContext prev, AppContext current) action,
  }) {
    var prevContext = AppContext()
      ..env = env
      ..translator = translator
      ..ui = ui
      ..auth = auth;

    var currentContext = AppContext()
      ..env = context.env ?? env
      ..translator = context.translator ?? translator
      ..ui = context.ui ?? ui
      ..auth = context.auth ?? auth;

    set(
      env: currentContext.env,
      translator: currentContext.translator,
      ui: currentContext.ui,
      auth: currentContext.auth,
    );

    action(prevContext, currentContext);

    set(
      env: prevContext.env,
      translator: prevContext.translator,
      ui: prevContext.ui,
      auth: prevContext.auth,
    );
  }
}
""",
"init/app/app_translator.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:{{#projectName}}/app/app_provider.dart';
import 'package:{{#projectName}}/config/lang/translations.g.dart';
import 'package:{{#projectName}}/data/preferences/framework_preference.dart';

class _AppTranslator extends TranslationsEn {
  final FrameworkPreference _pref = FrameworkPreference();

  _AppTranslator() : super.build();

  AppLocale _locale = AppLocale.en;

  AppLocale get locale => _locale;

  LiveDataSource<AppLocale> \$state = LiveDataSource(
    AppLocale.en,
    dataSourceInterface: null,
  );

  syncInit() {}

  asyncInit() async {
    setLocale(await _pref.getAppLocale());
    \$state.dataSourceInterface = createDataSourceInterface<AppLocale>(
      loadValueAction: null,
      onValueUpdatedAction: (AppLocale value, bool hasChange) async {
        _pref.setAppLocale(value);
      },
    );
    return Future.value(null);
  }

  setLocale(AppLocale locale) {
    _locale = locale;
    LocaleSettings.instance.setLocale(_locale);
  }
}

class AppTranslator extends _AppTranslator {
  AppTranslator(App provider) : super() {
    \$state.listen((value) {
      provider.\$state.tick();
    });
  }

  switchLocale(AppLocale newLocale) {
    setLocale(newLocale);

    if (locale == AppLocale.en) {
      LocaleSettings.instance.setLocale(AppLocale.en);
      \$state.value = locale;
    }
    if (locale == AppLocale.th) {
      LocaleSettings.instance.setLocale(AppLocale.th);
      \$state.value = locale;
    }
  }

  void useEnglish() {
    switchLocale(AppLocale.en);
  }

  void useThai() {
    switchLocale(AppLocale.th);
  }

  bool get isUsingEnglish => locale == AppLocale.en;

  bool get isUsingThai => locale == AppLocale.th;

  @override
  String toString() {
    return 'AppTranslator{\${\$state.value}}';
  }
}
""",
"init/app/app_component.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/architecture/component/logic.dart' as l;
import 'package:aves/architecture/component/view.dart' as v;
import 'package:aves/common/syslog.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/config/global_var.dart';
import 'package:{{#projectName}}/model/user.dart';
import 'index.dart';

abstract class ComponentLogic<T> extends l.Logic<T> {
  ComponentLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: (component) => builder(component as ComponentLogic));

  AppNavigator get nav {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).navigator;
  }

  AppTranslator get translator {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }

    return App.of(context!).translator;
  }

  AppUi get ui {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).ui;
  }

  AppAuth<User> get auth {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).auth;
  }

  GlobalVar get global {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).global;
  }
}

abstract class View<BC extends ComponentLogic> extends v.View<BC> {
  const View(
    BC component, {
    Key? key,
  }) : super(component, key: key);

  AppNavigator get nav => logic.nav;

  AppTranslator get translator => logic.translator;

  AppUi get ui => logic.ui;

  AppAuth<User> get auth => logic.auth;

  GlobalVar get global => logic.global;
}
""",
"init/app/index.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

export 'app_auth.dart';
export 'app_component.dart';
export 'app_navigator.dart';
export 'app_provider.dart';
export 'app_translator.dart';
export 'app_ui.dart';
export 'environment.dart';
""",
"init/app/app_navigator.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/architecture/navigator.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/common/log.dart';
import 'package:{{#projectName}}/ui/pages/home/home.logic.dart';
import 'package:{{#projectName}}/ui/main/startup.dart';

class AppNavigator extends AvesNavigator {
  @override
  Widget startup() => StartupPage.build();

  @override
  Widget home() => HomeLogic.build();

  Future<NavigatorResult> push(BuildContext context, Widget Function(BuildContext context) builder) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: builder));
    if (result is NavigatorResult) {
      sysLog.i('pop page with result: \$result');
      return result;
    }
    return NavigatorResult(data: {'result': result});
  }

  Future<NavigatorResult> pushReplacement(BuildContext context, Widget Function(BuildContext context) builder) async {
    var result = await Navigator.pushReplacement(context, MaterialPageRoute(builder: builder));
    if (result is NavigatorResult) {
      sysLog.i('pop page with result: \$result');
      return result;
    }
    return NavigatorResult(data: {'result': result});
  }

  AppNavigator pop<T extends Object?>(BuildContext context, {NavigatorResult? result}) {
    result ??= NavigatorResult();
    Navigator.pop(context, result);
    return this;
  }
}
""",
"init/app/app_auth.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/architecture/auth.dart';

class AppAuth<User> extends AvesAuth<User> {
  @override
  String toString() {
    return 'AppAuth{\$user}';
  }
}
""",
"init/app/environment.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart' as aves;
import 'package:flutter/widgets.dart';

@immutable
class Environment extends aves.Environment {
  @override
  String get appName => 'Bellugg';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction {
    return false;
  }

  @override
  bool get isDebugMode {
    return true;
  }

  @override
  bool get isUsingNetworkMockData => false;

  bool get isLogging => false;

  bool get isSystemLogging => false;

  bool get isEnableAds => true;

  String get baseUrl => 'https://test.co';
}
""",
"init/app/app_ui.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter/material.dart' as m;
import 'package:{{#projectName}}/app/app_provider.dart';
import 'package:{{#projectName}}/data/preferences/framework_preference.dart';

class AppUi extends AvesUi {
  final FrameworkPreference _pref = FrameworkPreference();
  late final LiveDataSource<AppTheme> \$state = LiveDataSource(
    AppTheme(),
    verifyDataChange: true,
  );

  AppUi(App provider) {
    \$state.listen((value) {
      provider.\$state.tick();
    });
  }

  @override
  asyncInit() async {
    setTheme(await _pref.getAppTheme());
    \$state.dataSourceInterface = createDataSourceInterface<AppTheme>(
      loadValueAction: null,
      onValueUpdatedAction: (AppTheme value, bool hasChange) async {
        _pref.setAppTheme(value);
      },
    );
  }

  setTheme(AppTheme theme) {
    \$state.value = theme;
  }

  useTheme1() {
    \$state.value = AppTheme();
  }

  useTheme2() {
    \$state.value = AppTheme2();
  }

  AppTheme get theme {
    return \$state.value;
  }

  AppStyle get style {
    return AppStyle();
  }

  bool get isUsingTheme1 => !isUsingTheme2;

  bool get isUsingTheme2 => \$state.value is AppTheme2;

  @override
  String toString() {
    return 'AppUi{\${\$state}}';
  }
}

class AppTheme {
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: const m.MaterialColor(
        0xFF009DA8,
        <int, m.Color>{
          50: m.Color(0xFF009DA8),
          100: m.Color(0xFF009DA8),
          200: m.Color(0xFF009DA8),
          300: m.Color(0xFF009DA8),
          400: m.Color(0xFF009DA8),
          500: m.Color(0xFF009DA8),
          600: m.Color(0xFF009DA8),
          700: m.Color(0xFF009DA8),
          800: m.Color(0xFF009DA8),
          900: m.Color(0xFF009DA8),
        },
      ),
    );
  }

  @override
  String toString() {
    return 'AppTheme{light theme}';
  }
}

class AppTheme2 extends AppTheme {
  @override
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.purple,
    );
  }

  @override
  String toString() {
    return 'AppTheme{dark theme}';
  }
}

class AppStyle {
  final _Text text = _Text();
  final _Color color = _Color();
  final _Dimen dimen = _Dimen();
}

// Text

class _Text {
  final _TextSize size = _TextSize();
  final m.TextStyle textStyle1 = const m.TextStyle(
    color: m.Colors.green,
  );
  final m.TextStyle textStyle2 = const m.TextStyle(
    color: m.Colors.cyan,
  );
}

class _TextSize {
  final int header1 = 24;
}

// Color

class _Color {
  final m.Color primary = m.Colors.green;
}

// dimension

class _Dimen {
  final double s = 0;
}
""",
"init/config/assets.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

String imagePath(String file, [String extension = "png"]) => "assets/images/\$file.\$extension";

class Assets {
  static String logo = imagePath("logo", "png");
}""",
"init/config/global_var.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';

class GlobalVar {
  late final LiveData<int> \$counter = LiveData(0);
}
""",
"init/config/di.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:{{#projectName}}/config/di.config.dart';

void setDefaultDependencies(AvesDi di) {
  di.singletonFactory<int>((c) {
    return 1;
  }, instanceName: 'app-version');
}

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'\$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => \$initGetIt(getIt);""",
"init/config/startup.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'package:{{#projectName}}/config/di.dart';

Future<void> startup(BuildContext context) async {
  var provider = App.of(context);
  await provider.asyncInit();
  configureDependencies();
  setDefaultDependencies(Di().container);
  return await _startup(context);
}

Future<void> _startup(BuildContext context) async {
  // custom...
  return Future.delayed(const Duration(seconds: 1));
}
""",
"init/config/env/prod.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/widgets.dart';
import 'package:{{#projectName}}/app/index.dart';

@immutable
class ProdEnvironment extends Environment {
  @override
  String get envName => 'prod env';

  @override
  String get appName => 'Aves';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction {
    return true;
  }

  @override
  bool get isDebugMode {
    return false;
  }

  @override
  bool get isUsingNetworkMockData => false;

  @override
  bool get isLogging => false;

  @override
  bool get isSystemLogging => false;

  @override
  String get baseUrl => 'https://api.aves.com';

  @override
  String toString() {
    return 'ProdEnvironment{\n'
        '   envName: \$envName (isProduction: \$isProduction, isDebugMode: \$isDebugMode, isUsingNetworkMockData: \$isUsingNetworkMockData)\n'
        '   appName: \$appName\n'
        '   logLevel: \$logLevel\n'
        '   baseUrl: \$baseUrl\n'
        '}';
  }
}
""",
"init/config/env/dev_api.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/widgets.dart';
import 'package:{{#projectName}}/app/index.dart';

@immutable
class DevApiEnvironment extends Environment {
  @override
  String get envName => 'dev-api env';

  @override
  String get appName => 'Aves (Dev API)';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction {
    return false;
  }

  @override
  bool get isDebugMode {
    return true;
  }

  @override
  bool get isUsingNetworkMockData => false;

  @override
  bool get isLogging => true;

  @override
  bool get isSystemLogging => true;

  @override
  String get baseUrl => 'https://api.aves.com';

  @override
  String toString() {
    return 'DevApiEnvironment{\n'
        '   envName: \$envName (isProduction: \$isProduction, isDebugMode: \$isDebugMode, isUsingNetworkMockData: \$isUsingNetworkMockData)\n'
        '   appName: \$appName\n'
        '   logLevel: \$logLevel\n'
        '   baseUrl: \$baseUrl\n'
        '}';
  }
}
""",
"init/config/env/dev_mock.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/widgets.dart';
import 'package:{{#projectName}}/app/index.dart';

@immutable
class DevMockEnvironment extends Environment {
  @override
  String get envName => 'dev-mock env';

  @override
  String get appName => 'Aves (Dev Mock)';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction {
    return false;
  }

  @override
  bool get isDebugMode {
    return true;
  }

  @override
  bool get isUsingNetworkMockData => true;

  @override
  bool get isLogging => true;

  @override
  bool get isSystemLogging => true;

  @override
  String get baseUrl => 'https://api.aves.com';

  @override
  String toString() {
    return 'DevMockEnvironment{\n'
        '   envName: \$envName (isProduction: \$isProduction, isDebugMode: \$isDebugMode, isUsingNetworkMockData: \$isUsingNetworkMockData)\n'
        '   appName: \$appName\n'
        '   logLevel: \$logLevel\n'
        '   baseUrl: \$baseUrl\n'
        '}';
  }
}
""",
"init/.aves/aves_config.yaml.template": """# main command for run flutter: 'flutter' or 'fvm'
command: {{#command}}

# 'none', 'overwrite'
delete-conflicting-outputs: none

template:
#  logic: assets/my_logic.template
#  view: assets/my_view.template
#  model: assets/my_model.template""",
"init/common/helpers.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

int add(int x, int y) {
    return x + y;
}""",
"init/common/extension/string.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

extension StringExample on String {
  String example() {
    return 'example of \$this';
  }
}
""",
"init/model/user.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

""",
"init/data/network/app_api.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

""",
"init/data/preference/app_pref.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

""",
"init/data/db/database.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

""",
};