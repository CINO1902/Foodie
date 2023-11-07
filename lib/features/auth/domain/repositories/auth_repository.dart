import 'dart:developer';

import 'package:foodie/features/auth/data/repositories/auth_datasource.dart';

abstract class AuthRepsitiory {
  Future<String> signup({required String email, required String password});
  Future<List> login({required String email, required String password});
  Future<String> forgetPassword({required String email});
}

class AuthRepositoryImpl implements AuthRepsitiory {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);
  @override
  Future<String> forgetPassword({required String email}) async {
    try {
      await authDatasource.forgetPassword(email: email);
    } catch (e) {
      log(e.toString());
    }
    return '';
  }

  @override
  Future<List> login({required String email, required String password}) async {
    List result = [];
    try {
      result = await authDatasource.login(email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  @override
  Future<String> signup({required String email, required String password}) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
