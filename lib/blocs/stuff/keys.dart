import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
    !!!IMPORTANTE!!!
    tutte le chiave dei form vanno inserite in questa classe
*/
class FormKey {
  static final playersKey = const Key('players');
  static final coachesKey = const Key('coaches');
  static final modulesKey = const Key('modules');
  static final jerseyKey = const Key('modules');
  static final loginKey = const Key('login');
  static final homeKey = const Key('homeKey');
  static final multiBlocProviderKey = const Key('multiBlocProviderKey');
  static final materialAppKey = const Key('materialAppKey');
  static final loadingKey = const Key('loadingKey');
  static final fliploaderkey = const Key('fliploaderkey');
  static final logoutKey = const Key('logoutKey');
  static final authenticationUnauthenticated =
      const Key('authenticationUnauthenticated');
  static final authenticationAuthenticated =
      const Key('authenticationAuthenticated');
  static final matchPageKey = const Key('matchPageKey');
  static final ocrPageKey = const Key('ocrPageKey');
}
