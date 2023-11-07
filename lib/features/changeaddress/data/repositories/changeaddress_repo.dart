import 'package:foodie/features/changeaddress/data/models/changeAddress.dart';

abstract class ChangeAddressDataSource {
  Future<List> changeAddress(ChangeAddress change);
}
