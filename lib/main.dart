import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'package:flutter_cyf/common/app_manager.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/ui/material/fmaterial_app.dart';
import 'package:flutter_cyf/ui/cupertino/fcupertino_app.dart';
import 'package:flutter_cyf/ui/store/reducers/app_state_reducer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isProd = const bool.fromEnvironment('dart.vm.product');
  AppManager()..isProd = isProd;
  // Create Persistor
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  final initialStateFromStorage = await persistor.load();
  final store = Store<AppState>(
    appReducer,
    initialState: initialStateFromStorage ?? initialState,
    middleware: [
      persistor.createMiddleware(),
      LoggingMiddleware.printer(),
      thunkMiddleware,
    ],
  );
  if (Platform.isIOS || Platform.isMacOS) {
    runApp(FCupertinoApp(
      store: store,
    ));
  } else {
    runApp(FMaterialApp(
      store: store,
    ));
  }
}
