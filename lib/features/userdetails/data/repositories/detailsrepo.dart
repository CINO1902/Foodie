import '../models/fetchidmodel.dart';

abstract class UserdetailsDatasource {
  Future<int> getId();
  Future<List<Prev>> getregisteredId();
  Future<void> sendtoken(token);
  Future<String?> getaddress();
}
