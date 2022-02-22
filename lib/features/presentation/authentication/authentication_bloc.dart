import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supdup/core/config/my_shared_pref.dart';
import 'package:supdup/features/data/datasource/local_datasource.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final MySharedPref _mySharedPref;
  final LocalDataSource _localDataSource;

  AuthenticationBloc(
      {required MySharedPref mySharedPref,
      required LocalDataSource localDataSource})
      : _mySharedPref = mySharedPref,
        _localDataSource = localDataSource,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
