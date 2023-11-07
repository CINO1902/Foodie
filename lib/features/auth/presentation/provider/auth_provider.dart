import 'package:flutter/foundation.dart';
import 'package:foodie/features/auth/domain/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepsitiory authRepsitiory;

  AuthProvider(this.authRepsitiory);

  String username = '';
  bool loading = false;
  List returnvalues = [];
  String token = '';
  String msg = '';
  bool error = false;
  Future<void> Login(email, password) async {
    loading = true;
    returnvalues = await authRepsitiory.login(email: email, password: password);
    msg = returnvalues[1];
    error = returnvalues[2];
    print(returnvalues);
    notifyListeners();
  }
}
