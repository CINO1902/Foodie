import 'dart:developer';
import 'package:foodie/features/getslide/data/repositories/remote_repositories.dart';

abstract class Sliderepository {
  Future<List> getSlide();
}

class SliderepositoryImp implements Sliderepository {
  final SlideDataSource slideDataSource;

  SliderepositoryImp(this.slideDataSource);

  @override
  Future<List> getSlide() async {
    List result = [];
    try {
      result = await slideDataSource.getSlide();
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
