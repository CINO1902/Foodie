abstract class AuthDatasource {
  Future<String> signup({required String email, required String password});
  Future<List> login({required String email, required String password});
  Future<String> forgetPassword({required String email});
}