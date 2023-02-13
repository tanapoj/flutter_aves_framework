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
"init/main_dev_api.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:{{#projectName}}/app/environment.dart';
import 'package:{{#projectName}}/config/env/dev_api.dart';
import 'package:{{#projectName}}/main.dart';

void main() {
  Environment env = DevApiEnvironment();
  runner(env);
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
          input_file_pattern: .lang.yaml
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
import 'package:{{#projectName}}/config/di.dart';
import 'package:{{#projectName}}/ui/main/launch_screen.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'package:{{#projectName}}/config/lang/translations.g.dart';
import 'package:{{#projectName}}/config/log.dart';

void runner(Environment env) {
  registerFactory(build: () => env);

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
  Widget build(BuildContext context) {
    sysLog.i('build MainApplication');
    return App(
      env: env,
      child: Builder(
        builder: (BuildContext context) {
          sysLog.i('build AppProvider');
          var app = App.of(context);
          app.syncInit();
          app.asyncInit();
          return \$watch(
            app.\$state,
            build: (context, _) {
              sysLog.i('build-render MaterialApp');

              // run init async
              // App.of(context).asyncInit();

              /// Custom Code here...
              return MaterialApp(
                title: app.env.appName,
                theme: app.ui.theme.themeData,
                home: LaunchScreenPage.build(),
              );
            },
          );
        },
      ),
    );
  }
}
""",
"init/main_dev_mock.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:{{#projectName}}/app/environment.dart';
import 'package:{{#projectName}}/config/env/dev_mock.dart';
import 'package:{{#projectName}}/main.dart';

void main() {
  Environment env = DevMockEnvironment();
  runner(env);
}
""",
"init/main_prod_api.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:{{#projectName}}/app/environment.dart';
import 'package:{{#projectName}}/config/env/prod_api.dart';
import 'package:{{#projectName}}/main.dart';

void main() {
  Environment env = ProdApiEnvironment();
  runner(env);
}
""",
"init/ui/main/launch_screen.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/app_provider.dart';
import 'package:{{#projectName}}/config/startup.dart';

class LaunchScreenPage extends StatefulWidget {
  const LaunchScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LaunchScreenPage> createState() => _StartupPageState();

  factory LaunchScreenPage.build() {
    return const LaunchScreenPage();
  }
}

class _StartupPageState extends State<LaunchScreenPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {}

  @override
  Widget build(BuildContext context) {
    var app = App.of(context);
    startup(context).then((_) async {
      app.router.push(
        (context) => app.navigator.home(),
        replacement: true,
      );
    });
    return _widgetSplashScreen(context);
  }

  Widget _widgetSplashScreen(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (innerContext) {
          return const Center(
            child: Text('starting up..'),
          );
        },
      ),
    );
  }
}
""",
"init/ui/pages/home/home.view.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/index.dart';
import 'package:{{#projectName}}/common/translate.dart';
import 'package:{{#projectName}}/model/api/item.dart';
import 'package:{{#projectName}}/model/user.dart';
import 'package:{{#projectName}}/ui/pages/setting/setting.logic.dart';
import 'package:{{#projectName}}/ui/pages/user/user.logic.dart';
import 'package:{{#projectName}}/app/index.dart' as app;
import 'home.logic.dart';

class HomeView extends app.View<HomeLogic> {
  const HomeView(HomeLogic logic, {Key? key}) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tt.home_page.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String s) {
              switch (s) {
                case 'user':
                  router.push((context) => UserLogic.build());
                  break;
                case 'setting':
                  router.push((context) => SettingLogic.build());
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'user',
                  child: Text(tt.user_page.title),
                ),
                PopupMenuItem<String>(
                  value: 'setting',
                  child: Text(tt.setting_page.title),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (auth.isLogin) Text('Login as: \${auth.user!.name}') else const Text('not Login'),
            const Divider(),
            \$guard.isNull(logic.\$data, build: (_, ItemModel? item) {
                  return Text(tt.loading);
                }) |
                \$watch(logic.\$data, build: (_, ItemModel? item) {
                  return Text('\${tt.home_page.loaded_data_is} \${item?.name} (\${item?.price})');
                }),
            const Divider(),
            \$watch(logic.\$counter, build: (_, int count) {
              return Text('\${tt.home_page.counter_is} \$count');
            }),
            ElevatedButton(
              onPressed: () {
                logic.increment();
              },
              child: Text(tt.home_page.increment),
            ),
            const Divider(),
            \$watch(logic.global.\$accumulator, build: (_, int count) {
              return Text('\${tt.home_page.accumulator_is} \$count');
            }),
            ElevatedButton(
              onPressed: () {
                logic.incrementAccumulate();
              },
              child: Text(tt.home_page.increment),
            ),
          ],
        ),
      ),
    );
  }
}
""",
"init/ui/pages/home/home.logic.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/index.dart';
import 'package:{{#projectName}}/data/service/app_service.dart';
import 'package:{{#projectName}}/model/api/item.dart';
import 'package:{{#projectName}}/model/user.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'home.view.dart';

class HomeLogic extends ComponentLogic {
  @override
  String get name => 'home';

  /// Class Parameters
  /// if you want to customize, add here, then add parameter to constructor and build
  final LifeCycleOwner? parent;

  HomeLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
    this.parent,
  }) : super(key: key, builder: builder);

  factory HomeLogic.build({LifeCycleOwner? parent}) {
    return HomeLogic(
      parent: parent,
      builder: (logic) => HomeView(logic as HomeLogic),
    );
  }

  /// Service
  final AppService appService = inject<AppService>();

  /// Define LiveData
  late final LiveData<int> \$counter = LiveData(0).owner(this);
  late final LiveData<User?> \$user = LiveData<User?>(null).owner(this);
  late final LiveData<ItemModel?> \$data = LiveData<ItemModel?>(null).owner(this);

  /// LiveCycle Listener
  /// if no use, you can remove them

  @override
  onCreate() async {
    super.onCreate();
    // TODO when page constructed
    _init();
  }

  @override
  onInit() async {
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
  _init() async {
    ItemModel? item = await appService.getItem(1);
    \$data.value = item;

    if (auth.isLogin) {
      \$user.value = auth.user;
    }
  }

  increment() {
    \$counter.value++;
  }

  incrementAccumulate() {
    global.\$accumulator.value++;
  }
}
""",
"init/ui/pages/user/user.view.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/index.dart';
import 'package:{{#projectName}}/model/user.dart';
import 'package:{{#projectName}}/app/index.dart' as app;
import 'user.logic.dart';

class UserView extends app.View<UserLogic> {
  UserView(UserLogic logic, {Key? key}) : super(logic, key: key);

  final TextEditingController txtUsername = TextEditingController()..text = 'test';
  final TextEditingController txtPassword = TextEditingController()..text = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(\"Login\"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            \$when(logic.\$user)
              ..\$case((User? user) => user == null, build: (_, User? user) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: txtUsername,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: txtPassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Text('HINT: try `test` and `1234`'),
                  ],
                );
              })
              ..\$else(build: (_, User? user) {
                return Text('Login as \${user!.name}');
              }),
            \$guard.isNotNull(logic.\$error, build: (_, String? error) {
              return Text(
                error!,
                style: const TextStyle(
                  color: Colors.red,
                ),
              );
            }),
            \$when(logic.\$user)
              ..\$case((User? user) => user == null, build: (_, User? user) {
                return ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    logic.login(txtUsername.text, txtPassword.text);
                  },
                );
              })
              ..\$else(build: (_, User? user) {
                return ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {
                    logic.logout();
                  },
                );
              })
          ],
        ),
      ),
    );
  }
}
""",
"init/ui/pages/user/user.logic.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/common/log.dart';
import 'package:aves/index.dart';
import 'package:{{#projectName}}/model/user.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'user.view.dart';

class UserLogic extends ComponentLogic {
  @override
  String get name => 'user';

  /// Class Parameters
  /// if you want to customize, add here, then add parameter to constructor and build
  final LifeCycleOwner? parent;

  UserLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
    this.parent,
  }) : super(key: key, builder: builder);

  factory UserLogic.build({LifeCycleOwner? parent}) {
    return UserLogic(
      parent: parent,
      builder: (logic) => UserView(logic as UserLogic),
    );
  }

  /// Define LiveData
  late final LiveData<User?> \$user = LiveData<User?>(null).owner(this);
  late final LiveData<String?> \$error = LiveData<String?>(null).owner(this);

  /// LiveCycle Listener

  @override
  onCreate() {
    super.onCreate();
    _init();
  }

  _init() {
    if (auth.isLogin) {
      \$user.value = auth.user;
    }
  }

  /// Define action
  /// custom method, called by view
  login(String username, String password) {
    \$error.value = null;
    if (username.trim().toLowerCase() == 'test' && password == '1234') {
      auth.setUser(User(1, 'test'));
      \$user.value = auth.user;
    } else {
      \$error.value = 'username or password is incorrect!';
    }
  }

  logout() {
    auth.unsetUser();
    \$user.value = null;
    \$error.value = null;
  }
}
""",
"init/ui/pages/setting/setting.logic.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/index.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'setting.view.dart';

class SettingLogic extends ComponentLogic {
  @override
  String get name => 'setting';

  /// Class Parameters
  /// if you want to customize, add here, then add parameter to constructor and build
  final LifeCycleOwner? parent;

  SettingLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
    this.parent,
  }) : super(key: key, builder: builder);

  factory SettingLogic.build({LifeCycleOwner? parent}) {
    return SettingLogic(
      parent: parent,
      builder: (logic) => SettingView(logic as SettingLogic),
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
"init/ui/pages/setting/setting.view.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/index.dart';
import 'package:{{#projectName}}/common/translate.dart';
import 'package:{{#projectName}}/ui/widgets/none.dart';
import 'package:{{#projectName}}/app/index.dart' as app;
import 'setting.logic.dart';

class SettingView extends app.View<SettingLogic> {
  const SettingView(SettingLogic logic, {Key? key}) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tt.setting_page.title),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(tt.setting_page.locale_en),
                  trailing: translator.isUsingEnglish ? const Icon(Icons.check_circle) : None(),
                  onTap: () {
                    translator.useEnglish();
                  },
                ),
                ListTile(
                  title: Text(tt.setting_page.locale_th),
                  trailing: translator.isUsingThai ? const Icon(Icons.check_circle) : None(),
                  onTap: () {
                    translator.useThai();
                  },
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(tt.setting_page.theme_1),
                  trailing: ui.isUsingTheme1 ? const Icon(Icons.check_circle) : None(),
                  onTap: () {
                    ui.useTheme1();
                  },
                ),
                ListTile(
                  title: Text(
                    tt.setting_page.theme_2,
                  ),
                  trailing: ui.isUsingTheme2 ? const Icon(Icons.check_circle) : None(),
                  onTap: () {
                    ui.useTheme2();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
""",
"init/ui/widgets/none.template": """import 'package:flutter/widgets.dart';

class None extends SizedBox {
  const None({super.key, super.width, super.height, super.child});
}

class NoneElement extends Widget {
  static NoneElement? _singleton;

  factory NoneElement({Key? key}) {
    _singleton ??= NoneElement._internal(key: key);
    return _singleton!;
  }

  const NoneElement._internal({Key? key}) : super(key: key);

  @override
  Element createElement() => _NoneElement(this);
}

class _NoneElement extends Element {
  _NoneElement(NoneElement widget) : super(widget);

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
  }

  @override
  bool get debugDoingBuild => false;

  @override
  void performRebuild() {}
}
""",
"init/ui/widgets/example_widget.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

class ExampleWidget {
}""",
"init/app/app_provider.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/widgets.dart';
import 'package:aves/architecture/environment.dart';
import 'package:aves/architecture/provider.dart';
import 'package:aves/common/log.dart';
import 'package:aves/common/syslog.dart';
import 'package:flutter_live_data/index.dart';
import 'package:{{#projectName}}/app/global_var.dart';
import 'package:{{#projectName}}/app/app_auth.dart';
import 'package:{{#projectName}}/app/app_navigator.dart';
import 'package:{{#projectName}}/app/app_translator.dart';
import 'package:{{#projectName}}/app/app_ui.dart';

// ignore: must_be_immutable
class App extends AvesProvider {
  App({
    super.key,
    required super.child,
    required Environment env,
  }) : super(env: env);

  BuildContext? _variantContext;
  bool _isAlreadyRunAsyncInit = false;

  late final LiveData<App> \$state = LiveData(this);
  late AppNavigator _navigator = AppNavigator();
  late AppTranslator _translator = AppTranslator(this);
  late AppUi _ui = AppUi(this);
  late AppAuth _auth = AppAuth(this);
  late GlobalVar _globalVar = GlobalVar();

  AppNavigator get navigator => _navigator;

  AppRouterFacade get router {
    return AppRouterFacade(
      appNavigator: navigator,
      context: _variantContext!,
      routeRefName: '_app',
    );
  }

  AppTranslator get translator => _translator;

  AppUi get ui => _ui;

  AppAuth get auth => _auth;

  GlobalVar get global => _globalVar;

  void set({
    Environment? env,
    AppNavigator? navigator,
    AppTranslator? translator,
    AppUi? ui,
    AppAuth? auth,
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
    instance = result! as App;
    instance!._variantContext = context;
    return instance!;
  }

  changeNotify(){
    \$state.tick();
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
    appLog.setControlProvider(this);
    sysLog.setControlProvider(this);
    navigator.syncInit();
    ui.syncInit();
    auth.syncInit();
    translator.syncInit();
    global.syncInit();
    sysLog.d('AppProvider run syncInit ... done');
  }

  @override
  asyncInit() async {
    if (_isAlreadyRunAsyncInit) return;
    sysLog.d('AppProvider run asyncInit ... start');
    await Future.wait(<Future>[
      navigator.asyncInit(),
      ui.asyncInit(),
      auth.asyncInit(),
      translator.asyncInit(),
      global.asyncInit(),
    ]);
    _isAlreadyRunAsyncInit = true;
    sysLog.d('AppProvider run asyncInit ... done');
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppProvider{'
        '   navigator: \$navigator'
        '   translator: \$translator'
        '   ui: \$ui'
        '   auth: \$auth'
        '}';
  }
}

/// App Facade

App app([BuildContext? context]) {
  if (context != null) {
    return App.of(context);
  }
  return App.instance!;
}

class AppContext {
  Environment? env;
  AppTranslator? translator;
  AppUi? ui;
  AppAuth? auth;

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
import 'package:flutter_live_data/live_source.dart';
import 'package:{{#projectName}}/app/app_provider.dart';
import 'package:{{#projectName}}/config/lang/translations.g.dart';
import 'package:{{#projectName}}/data/preference/app_pref.dart';

class _AppTranslator extends TranslationsEn {
  final AppPreference _pref = AppPreference();

  _AppTranslator() : super.build();

  AppLocale _locale = AppLocale.en;

  AppLocale get locale => _locale;

  late LiveData<AppLocale> \$state = LiveSource(
    AppLocale.en,
    adapter: LiveDataSourceAdapter(
      saveData: (value) async {
        _pref.setAppLocale(value);
      },
    ),
  );

  syncInit() {}

  asyncInit() async {
    setLocale(await _pref.getAppLocale());
    return Future.value(null);
  }

  setLocale(AppLocale locale) {
    _locale = locale;
    LocaleSettings.instance.setLocale(_locale);
    \$state.value = locale;
  }
}

class AppTranslator extends _AppTranslator {
  AppTranslator(App provider) : super() {
    \$state.listen((value) {
      provider.changeNotify();
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
"init/app/global_var.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter_live_data/live_source.dart';
import 'package:{{#projectName}}/common/live_data.dart';

class GlobalVar {
  late final LiveData<int> \$accumulator = LiveSource(
    0,
    adapter: LiveSourcePref.intAdapter('global-accumulator', 0),
    name: 'global-accumulator',
  );

  syncInit() {}

  asyncInit() async {}
}
""",
"init/app/app_component.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/architecture/component/logic.dart' as l;
import 'package:aves/architecture/component/view.dart' as v;
import 'package:aves/common/syslog.dart';
import 'package:{{#projectName}}/app/global_var.dart';
import 'index.dart';

abstract class ComponentLogic<T> extends l.Logic<T> {
  ComponentLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: (component) => builder(component as ComponentLogic));

  @Deprecated('Use [router]')
  AppNavigator get nav {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).navigator;
  }

  AppRouterFacade get router {
    if (context == null) {
      sysLog.e('context is null');
      throw Exception();
    }
    return AppRouterFacade(
      appNavigator: App.of(context!).navigator,
      context: context!,
      routeRefName: name,
    );
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

  AppAuth get auth {
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

  AppRouterFacade get router => logic.router;

  AppTranslator get translator => logic.translator;

  AppUi get ui => logic.ui;

  AppAuth get auth => logic.auth;

  GlobalVar get global => logic.global;
}
""",
"init/app/index.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

export 'package:{{#projectName}}/app/app_auth.dart';
export 'package:{{#projectName}}/app/app_component.dart';
export 'package:{{#projectName}}/app/app_navigator.dart';
export 'package:{{#projectName}}/app/app_provider.dart';
export 'package:{{#projectName}}/app/app_translator.dart';
export 'package:{{#projectName}}/app/app_ui.dart';
export 'package:{{#projectName}}/app/environment.dart';
""",
"init/app/app_navigator.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:aves/architecture/navigator.dart';
import 'package:{{#projectName}}/ui/main/launch_screen.dart';
import 'package:{{#projectName}}/ui/pages/home/home.logic.dart';

class AppNavigator extends AvesNavigator {
  @override
  Widget startup() => LaunchScreenPage.build();

  @override
  Widget home() => HomeLogic.build();
}

class AppRouterFacade extends AvesRouterFacade {
  AppRouterFacade({
    required super.appNavigator,
    required super.context,
    required super.routeRefName,
  });
}
""",
"init/app/app_auth.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/architecture/auth.dart';
import 'package:aves/common/log.dart';
import 'package:aves/index.dart';
import 'package:flutter_live_data/live_source.dart';
import 'package:{{#projectName}}/app/app_provider.dart';
import 'package:{{#projectName}}/data/preference/app_pref.dart';
import 'package:{{#projectName}}/model/user.dart';

class AppAuth extends AvesAuth<User> {
  final AppPreference _pref = AppPreference();

  AppAuth(App provider) {
    \$state.listen((value) {
      provider.changeNotify();
    });
  }

  @override
  syncInit() {
    (\$state as LiveSource<User?>).adapter = LiveDataSourceAdapter<User?>(
      saveData: (user) async {
        _pref.setAppUser(user);
      },
    );
  }

  @override
  asyncInit() async {
    var user = await _pref.getAppUser();
    if (user != null) {
      await setUser(user);
    } else {
      await unsetUser();
    }
  }

  @override
  String toString() {
    if (isLogin) {
      return 'AppAuth{\$user}';
    }
    return 'AppAuth{null}';
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
  bool get isProduction => false;

  @override
  bool get isDebugMode => false;

  @override
  bool get isUsingNetworkMockData => false;

  @override
  bool get isLogging => false;

  @override
  bool get isSystemLogging => false;

  String get baseUrl => 'https://test.co';
}
""",
"init/app/app_ui.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/index.dart';
import 'package:flutter_live_data/live_source.dart';
import 'package:{{#projectName}}/app/app_provider.dart';
import 'package:{{#projectName}}/config/log.dart';
import 'package:{{#projectName}}/config/theme/theme1.dart';
import 'package:{{#projectName}}/config/theme/theme2.dart';
import 'package:{{#projectName}}/data/preference/app_pref.dart';

class AppUi extends AvesUi<AppTheme> {
  final AppPreference _pref = AppPreference();

  AppUi(App provider) {
    \$state.listen((value) {
      provider.changeNotify();
    });

    if (\$state.value == null) {
      \$state.just.value = AppTheme();
    }
  }

  @override
  syncInit() {
    (\$state as LiveSource<AppTheme?>).adapter = LiveDataSourceAdapter<AppTheme?>(
      saveData: (appTheme) async {
        _pref.setAppTheme(appTheme!);
      },
    );
  }

  @override
  asyncInit() async {
    setTheme(await _pref.getAppTheme());
  }

  useTheme1() {
    setTheme(AppTheme());
  }

  useTheme2() {
    setTheme(AppTheme2());
  }

  bool get isUsingTheme1 => theme.name == 'theme-1';

  bool get isUsingTheme2 => theme.name == 'theme-2';

  @override
  String toString() {
    return 'AppUi{\${\$state}}';
  }
}
""",
"init/config/assets.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

String imagePath(String file, [String extension = \"png\"]) => \"assets/images/\$file.\$extension\";

class Assets {
  static String logo = imagePath(\"logo\", \"png\");
}""",
"init/config/log.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/common/log.dart';
import 'package:aves/common/syslog.dart';
import 'package:flutter_live_data/log.dart' as fld;

Logger appLog = Logger.instance;
Logger sysLog = SysLogger.instance;

class LiveDataSysLogAdapter implements fld.Logger {
  @override
  void close() => sysLog.close();

  @override
  void d(message, [error, StackTrace? stackTrace]) => sysLog.d(message, error, stackTrace);

  @override
  void e(message, [error, StackTrace? stackTrace]) => sysLog.e(message, error, stackTrace);

  @override
  void i(message, [error, StackTrace? stackTrace]) => sysLog.i(message, error, stackTrace);

  @override
  void log(level, message, [error, StackTrace? stackTrace]) => sysLog.log(message, error, stackTrace);

  @override
  void v(message, [error, StackTrace? stackTrace]) => sysLog.v(message, error, stackTrace);

  @override
  void w(message, [error, StackTrace? stackTrace]) => sysLog.w(message, error, stackTrace);

  @override
  void wtf(message, [error, StackTrace? stackTrace]) => sysLog.wtf(message, error, stackTrace);
}

bindSysLogAdapterToLiveData() {
  fld.Logger.instance = LiveDataSysLogAdapter();
}""",
"init/config/di.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:{{#projectName}}/config/di.config.dart';

@InjectableInit(
  initializerName: r'\$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => \$initGetIt(GetIt.I);

registerFactory<T extends Object>({
  required T Function() build,
  String? instanceName,
}) {
  try {
    GetIt.I.registerFactory<T>(build, instanceName: instanceName);
  } catch (e) {}
}

T inject<T extends Object>([String? instanceName]) => GetIt.I.get<T>(instanceName: instanceName);
""",
"init/config/startup.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'package:{{#projectName}}/config/di.dart';
import 'package:{{#projectName}}/config/log.dart';

Future<void> startup(BuildContext context) async {
  appLog.i('run startup.');

  // bind Environment to Logger
  bindSysLogAdapterToLiveData();

  // Dependencies Injection
  configureDependencies();

  // run init async
  await App.of(context).asyncInit();

  ///
  /// Add Custom startup task here...
  ///
}
""",
"init/config/env/prod.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/widgets.dart';
import 'package:{{#projectName}}/app/index.dart';

@immutable
class ProdApiEnvironment extends Environment {
  @override
  String get envName => 'prod-api';

  @override
  String get appName => 'Aves Demo';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction => true;

  @override
  bool get isDebugMode => false;

  @override
  bool get isUsingNetworkMockData => false;

  @override
  bool get isLogging => true;

  @override
  bool get isSystemLogging => false;

  @override
  String get baseUrl => 'https://my.api';

  @override
  String toString() {
    return 'ProdApiEnvironment{\\n'
        '   envName: \$envName (isProduction: \$isProduction, isDebugMode: \$isDebugMode, isUsingNetworkMockData: \$isUsingNetworkMockData)\\n'
        '   appName: \$appName\\n'
        '   logLevel: \$logLevel\\n'
        '   baseUrl: \$baseUrl\\n'
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
  String get envName => 'dev-api';

  @override
  String get appName => 'Aves Demo';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction => false;

  @override
  bool get isDebugMode => true;

  @override
  bool get isUsingNetworkMockData => false;

  @override
  bool get isLogging => true;

  @override
  bool get isSystemLogging => true;

  @override
  String get baseUrl => 'https://my-dev.api';

  @override
  String toString() {
    return 'DevApiEnvironment{\\n'
        '   envName: \$envName (isProduction: \$isProduction, isDebugMode: \$isDebugMode, isUsingNetworkMockData: \$isUsingNetworkMockData)\\n'
        '   appName: \$appName\\n'
        '   logLevel: \$logLevel\\n'
        '   baseUrl: \$baseUrl\\n'
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
  String get envName => 'dev-mock';

  @override
  String get appName => 'Aves Demo';

  @override
  int get logLevel => 1;

  @override
  bool get isProduction => false;

  @override
  bool get isDebugMode => true;

  @override
  bool get isUsingNetworkMockData => true;

  @override
  bool get isLogging => true;

  @override
  bool get isSystemLogging => true;

  @override
  String get baseUrl => 'https://local';

  @override
  String toString() {
    return 'DevMockEnvironment{\\n'
        '   envName: \$envName (isProduction: \$isProduction, isDebugMode: \$isDebugMode, isUsingNetworkMockData: \$isUsingNetworkMockData)\\n'
        '   appName: \$appName\\n'
        '   logLevel: \$logLevel\\n'
        '   baseUrl: \$baseUrl\\n'
        '}';
  }
}
""",
"init/config/theme/theme2.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:{{#projectName}}/config/theme/theme1.dart';
import 'package:flutter/material.dart' as m;

class AppTheme2 extends AppTheme {
  @override
  String get name => 'theme-2';

  @override
  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.teal,
      colorScheme: const m.ColorScheme.dark().copyWith(
        primary: m.Colors.teal,
      ),
    );
  }

  @override
  String toString() {
    return 'AppTheme{dark theme}';
  }
}
""",
"init/config/theme/theme1.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter/material.dart' as m;

class AppTheme {
  String get name => 'theme-1';

  m.ThemeData get themeData {
    return m.ThemeData(
      primarySwatch: m.Colors.teal,
    );
  }

  @override
  String toString() {
    return 'AppTheme{light theme}';
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
"init/common/translate.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:{{#projectName}}/config/lang/translations.g.dart' as slang;
export '../../config/lang/translations.g.dart';

slang.TranslationsEn get tt => slang.slang_global_tt;
""",
"init/common/live_data.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:flutter_live_data/live_source.dart';
import 'package:{{#projectName}}/data/preference/app_pref.dart';

class LiveSourcePref {
  static LiveDataSourceAdapter<T> intAdapter<T>(String key, T defaultValue, {bool autoload = true}) {
    return LiveDataSourceAdapter<T>(
      loadData: autoload ? loadIntFactory<T>(key, defaultValue) : null,
      saveData: saveIntFactory(key),
    );
  }

  static Future<T> Function() loadIntFactory<T>(String key, T initValue) {
    AppPreference pref = AppPreference();
    return () async {
      return (await pref.getInt(key) ?? (initValue as int)) as T;
    };
  }

  static Future<void> Function(T value) saveIntFactory<T>(String key) {
    AppPreference pref = AppPreference();
    return (T value) async {
      pref.setInt(key, value as int);
    };
  }

  static Future<T> Function() loadStringFactory<T>(String key, T initValue) {
    AppPreference pref = AppPreference();
    return () async {
      return (await pref.getString(key) ?? (initValue as String)) as T;
    };
  }

  static Future<void> Function(T value) saveStringFactory<T>(String key) {
    AppPreference pref = AppPreference();
    return (T value) async {
      pref.setString(key, value as String);
    };
  }
}
""",
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

import 'dart:convert';

class User {
  final int id;
  final String name;
  String? _token;

  String get token => _token ?? '';

  User(this.id, this.name);

  setToken(String token) {
    _token = _token;
  }

  String serialize() {
    return jsonEncode({
      'id': id,
      'name': name,
      'token': _token,
    });
  }

  static User? unserialize(String serializedString) {
    try {
      var data = jsonDecode(serializedString);
      int id = data['id'];
      String name = data['name'];
      String? token = data['token'];
      var user = User(id, name);
      if (token != null) user.setToken(token);
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return 'User{id: \$id, name: \$name, _token: \$_token}';
  }
}
""",
"init/model/api/item.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'item.g.dart';

//=========================================
// ItemModel
//=========================================

@JsonSerializable(explicitToJson: true)
@immutable
class ItemModel {

  // TODO: (1) add Model's Fields

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'created_at', fromJson: _parseDateTime)
  final DateTime createdAt;

  static DateTime _parseDateTime(String formattedString) => DateTime.parse(formattedString);

  // Do not modify this section

  factory ItemModel.fromJson(Map<String, dynamic> json) => _\$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _\$ItemModelToJson(this);

  const ItemModel(this.id, this.name, this.price, this.createdAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          createdAt == other.createdAt;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode ^ createdAt.hashCode;

  @override
  String toString() {
    return 'ItemModel{id: \$id, name: \$name, price: \$price, createdAt: \$createdAt}';
  }

  // TODO: (2) generate Constructor, == and toString

  // TODO: (3) then run `flutter pub run aves build:model` or `fvm flutter pub run aves build:model`

}
""",
"init/data/network/interceptor.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:aves/architecture/di.dart';
import 'package:aves/common/log.dart';
import 'package:aves/data/network/network.dart';
import 'package:{{#projectName}}/app/index.dart';
import 'package:{{#projectName}}/data/network/app_api.dart';

class Pagination {
  final int from;
  final int to;
  final int total;

  Pagination(this.from, this.to, this.total);

  int page({required int perPage}) {
    return (from / perPage).ceil() + 1;
  }

  int totalPage({required int perPage}) {
    return (total / perPage).ceil();
  }

  @override
  String toString() {
    return 'Pagination{\$from-\$to/\$total}';
  }
}

extension ResponsePagination on Response {
  Pagination? get pagination {
    if (extra is! Map || !extra.containsKey('pagination')) return null;
    var pagination = extra['pagination'];
    if (!pagination.containsKey('from') || !pagination.containsKey('to') || !pagination.containsKey('total')) {
      return null;
    }
    return Pagination(pagination['from'], pagination['to'], pagination['total']);
  }
}

RequestInterceptor useMockData({
  required String fileName,
  Duration? responseTime,
  int statusCode = 200,
}) {
  if (!app().env.isUsingNetworkMockData) {
    return RequestInterceptor(interceptor: (Request request) async {
      return RequestInterceptorFlow(request);
    });
  }
  int randInt(int from, int to) => Random().nextInt(to - from + 1) + from;
  responseTime ??= Duration(milliseconds: randInt(200, 800));
  return RequestInterceptor(interceptor: (Request request) async {
    if (responseTime!.isNegative == false) {
      await Future.delayed(responseTime);
    }
    final content = await rootBundle.loadString(fileName);
    var m = jsonDecode(content);
    return RequestInterceptorFlow(request,
        terminate: true,
        response: Response(
          statusCode: statusCode,
          data: m,
          body: content,
        ));
  });
}

RequestInterceptor useUserAuthorizationToken() {
  return RequestInterceptor(interceptor: (Request request) async {
    var user = app().auth.user;
    if (user == null) {
      return RequestInterceptorFlow(request);
    }
    return RequestInterceptorFlow(
      request
        ..queryParameter['Authorization'] = user.token
        ..headers['Authorization'] = 'Bearer \${user.token}',
      terminate: false,
    );
  });
}

ResponseInterceptor useUnboxedStructure() {
  return ResponseInterceptor(interceptor: (Response response) async {
    if (!response.ok) {
      return ResponseInterceptorFlow(response, terminate: true);
    }
    try {
      Map<String, dynamic> model = response.data is String ? jsonDecode(response.data) : response.data;

      bool unacceptable = false;

      if (model['status'] == 'success' && !model.containsKey('data')) unacceptable = true;
      if (unacceptable) {
        return ResponseInterceptorFlow(
          ResponseCustomError(
            error: response.data,
            body: response.body,
            statusCode: response.statusCode,
            headers: response.headers,
            message: 'JSend Success Structure Incorrect',
          ),
          terminate: true,
        );
      }

      if ((model['status'] == 'fail' || model['status'] == 'error') && !model.containsKey('code')) unacceptable = true;
      if (unacceptable) {
        return ResponseInterceptorFlow(
          ResponseCustomError(
            error: response.data,
            body: response.body,
            statusCode: response.statusCode,
            headers: response.headers,
            message: 'JSend Fail/Error Structure Incorrect',
          ),
          terminate: true,
        );
      }

      if (model['status'] != 'success') unacceptable = true;
      if (![200, 201].contains(response.statusCode)) unacceptable = true;
      if (unacceptable) {
        return ResponseInterceptorFlow(
          ResponseCustomError(
            error: model,
            body: response.body,
            statusCode: response.statusCode,
            headers: response.headers,
            message: 'JSend Status: \${model['status']}',
          ),
          terminate: true,
        );
      }

      return ResponseInterceptorFlow(
        Response<Map<String, dynamic>>(
          data: model['data'],
          body: response.body,
          statusCode: response.statusCode,
          headers: response.headers,
          message: response.message,
        ),
        terminate: false,
      );
    } on FormatException catch (e) {
      var errorMessage = 'Interceptor: useUnboxedStructure Error, cannot unwrap = \${response.data}';
      appLog.w(errorMessage);
      return ResponseInterceptorFlow(
        ResponseCustomError(
          error: null,
          body: response.body,
          statusCode: response.statusCode,
          headers: response.headers,
          message: errorMessage,
        ),
        terminate: true,
      );
    }
  });
}

ResponseInterceptor useRetry({required int limit}) {
  int count = 0;
  return ResponseInterceptor(interceptor: (Response response) async {
    if (count < limit && response.statusCode != 200) {
      count++;
      return ResponseInterceptorFlow(response, terminate: false, startAgain: true);
    } else {
      return ResponseInterceptorFlow(response, terminate: false, startAgain: false);
    }
  });
}

ResponseInterceptor useContentRangePagination() {
  return ResponseInterceptor(interceptor: (Response response) async {
    var contentRanges = [];
    try {
      contentRanges = (response.headers?['content-range']?[0] ?? '').split(' ');
    } catch (e) {}
    int from = -1;
    int to = -1;
    int total = -1;
    if (contentRanges.length == 2) {
      var label = contentRanges[0];
      final regexp = RegExp(r'^([0-9]+)\-([0-9]+)/([0-9]+)');
      final match = regexp.firstMatch(contentRanges[1]);
      from = int.tryParse(match?.group(1) ?? '\$from') ?? from;
      to = int.tryParse(match?.group(2) ?? '\$to') ?? to;
      total = int.tryParse(match?.group(3) ?? '\$total') ?? total;
    }

    if (response.extra is! Map) response.extra = {};
    response.extra['pagination'] = {
      'from': from,
      'to': to,
      'total': total,
    };

    return ResponseInterceptorFlow(response, terminate: false, startAgain: false);
  });
}

ResponseInterceptor useReAuth() {
  int limit = 2;
  int count = 0;
  return ResponseInterceptor(interceptor: (Response response) async {
    var api = inject<AppApi>();
    var user = app().auth.user;
    if (user == null) {
      return ResponseInterceptorFlow(response, terminate: false, startAgain: false);
    }

    if (count < limit && response.statusCode == 401) {
      count++;

      var res = await api.auth(username: 'username', password: 'password').fetch();
      user.setToken('\${res.data?['data']['token']}');

      return ResponseInterceptorFlow(
        response,
        terminate: false,
        startAgain: true,
        // requestDecorator: (req) {
        //   return req
        //     ..queryParameter['Authorization'] = userToken.token
        //     ..headers['Authorization'] = userToken.token;
        // },
      );
    } else {
      return ResponseInterceptorFlow(response, terminate: false, startAgain: false);
    }
  });
}
""",
"init/data/network/app_api.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/common/json.dart';
import 'package:aves/data/network/network.dart';
import 'package:injectable/injectable.dart' as di;
import 'package:{{#projectName}}/app/environment.dart';
import 'package:{{#projectName}}/model/api/item.dart';
import 'interceptor.dart';

@di.injectable
class AppApi {
  final Environment env;

  AppApi(this.env);

  Request<T> _request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = env.baseUrl
      ..requestInterceptor = useUserAuthorizationToken()
      ..responseInterceptor = useRetry(limit: 3);
  }

  Request<Map<String, dynamic>> auth({required String username, required String password}) {
    return _request<Map<String, dynamic>>()
      ..method = 'POST'
      ..url = 'auth'
      ..mappingResponse = (dynamic body, response) {
        return ensureJsonDecodeToMap(body);
      };
  }

  Request<ItemModel> getItem(int id) {
    return _request<ItemModel>()
      ..method = 'GET'
      ..url = 'item/\$id'
      ..requestInterceptor = useMockData(fileName: 'assets/mock/item.json')
      ..mappingResponse = (dynamic body, response) {
        return ItemModel.fromJson(ensureJsonDecodeToMap(body));
      };
  }

  Request<List<ItemModel>> getItems() {
    return _request<List<ItemModel>>()
      ..method = 'GET'
      ..url = 'item'
      ..requestInterceptor = useMockData(fileName: 'assets/mock/items.json')
      ..mappingResponse = (dynamic body, response) {
        return <ItemModel>[
          ...(ensureJsonDecodeToIterable(body)).map((item) => ItemModel.fromJson(ensureJsonDecodeToMap(item))),
        ];
      };
  }
}
""",
"init/data/preference/app_pref.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/common/log.dart';
import 'package:injectable/injectable.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{#projectName}}/config/lang/translations.g.dart';
import 'package:{{#projectName}}/config/theme/theme1.dart';
import 'package:{{#projectName}}/config/theme/theme2.dart';
import 'package:{{#projectName}}/model/user.dart';

@di.injectable
class AppPreference {
  static const String prefAppUser = 'pref-app-user';
  static const String prefAppLocale = 'pref-app-locale';
  static const String prefAppTheme = 'pref-app-theme';

  // AppUser

  Future<User?> getAppUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString(prefAppUser);
    appLog.d('FrameworkPreference.getAppUser = \$userData');
    return userData == null ? null : User.unserialize(userData);
  }

  void setAppUser(User? user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null) {
      prefs.remove(prefAppUser);
    } else {
      var userData = user.serialize();
      appLog.d('FrameworkPreference.setAppUser = \$userData');
      prefs.setString(prefAppUser, userData);
    }
  }

  // AppLocale

  Future<AppLocale> getAppLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var langCode = prefs.getString(prefAppLocale) ?? 'en';
    appLog.d('FrameworkPreference.getAppLocale = \$langCode');
    if (langCode == 'th') return AppLocale.th;
    return AppLocale.en;
  }

  void setAppLocale(AppLocale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode;
    if (locale == AppLocale.en) langCode = 'en';
    if (locale == AppLocale.th) langCode = 'th';
    appLog.d('FrameworkPreference.setAppLocale = \$langCode');
    prefs.setString(prefAppLocale, langCode ?? 'en');
  }

  // AppLocale

  Future<AppTheme> getAppTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeCode;
    try {
      themeCode = prefs.getString(prefAppTheme) ?? '';
    } catch (e) {
      themeCode = '';
    }
    appLog.d('FrameworkPreference.getAppTheme = \$themeCode');
    if (themeCode == '2') return AppTheme2();
    return AppTheme();
  }

  void setAppTheme(AppTheme theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeCode;
    if (theme is AppTheme2) themeCode = '2';
    appLog.d('FrameworkPreference.setAppTheme = \$themeCode');
    prefs.setString(prefAppTheme, themeCode ?? '1');
  }

  // Custom

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  void setInt(String key, int? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
      return;
    }
    prefs.setInt(key, value);
  }

  Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  void setDouble(String key, double? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
      return;
    }
    prefs.setDouble(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void setString(String key, String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
      return;
    }
    prefs.setString(key, value);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  void setBool(String key, bool? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
      return;
    }
    prefs.setBool(key, value);
  }
}
""",
"init/data/db/database.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

""",
"init/data/service/app_service.template": """/// Project: {{#projectName}}
/// Author: {{#author}}
/// Created at: {{#createdAt}}

import 'package:aves/data/network/network.dart';
import 'package:{{#projectName}}/data/network/app_api.dart';
import 'package:{{#projectName}}/model/api/item.dart';
import 'package:injectable/injectable.dart' as di;

@di.injectable
class AppService {
  final AppApi appApi;

  AppService(this.appApi);

  Future<ItemModel?> getItem(int id) async {
    return (await appApi.getItem(id).fetch()).data;
  }
}
""",
"init/assets/mock/items.json.template": """[
  {
    \"id\": 1,
    \"name\": \"Test Item.\",
    \"price\": 12.34,
    \"created_at\": \"2023-01-01 10:20:30\"
  }
]""",
"init/assets/mock/item.json.template": """{
  \"id\": 1,
  \"name\": \"Test Item.\",
  \"price\": 12.34,
  \"created_at\": \"2023-01-01 10:20:30\"
}""",
"init/assets/lang/string_th.lang.yaml.template": """home_page:
  title: \"เดโม่\"
  loaded_data_is: \"ข้อมูลที่โหลดมาคือ\"
  counter_is: \"counter คือ\"
  accumulator_is: \"accumulator คือ\"
  increment: \"เพิ่มค่า\"
setting_page:
  title: \"หน้าตั้งค่า\"
  locale_en: \"อังกฤษ\"
  locale_th: \"ไทย\"
  theme_1: \"ธีม ๑\"
  theme_2: \"ธีม ๒\"
user_page:
  title: \"ผู้ใช้งาน\"
loading: \"กำลังโหลด...\"""",
"init/assets/lang/string.lang.yaml.template": """home_page:
  title: \"Demo\"
  loaded_data_is: \"loaded data is\"
  counter_is: \"counter is\"
  accumulator_is: \"accumulator is\"
  increment: \"increment\"
setting_page:
  title: \"Setting\"
  locale_en: \"English\"
  locale_th: \"Thai\"
  theme_1: \"Theme I\"
  theme_2: \"Theme II\"
user_page:
  title: \"User\"
loading: \"loading...\"""",
};