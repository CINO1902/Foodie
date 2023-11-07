import 'package:dio/dio.dart';
import 'package:foodie/features/Firstcheck/data/datasources/firstcheckdatasource.dart';
import 'package:foodie/features/Firstcheck/domain/repositories/firstcheck_repository.dart';
import 'package:foodie/features/Firstcheck/presentation/provider/firstcheckprovider.dart';
import 'package:foodie/features/auth/data/datasources/remote_datasource.dart';
import 'package:foodie/features/auth/data/repositories/auth_datasource.dart';
import 'package:foodie/features/auth/domain/repositories/auth_repository.dart';
import 'package:foodie/features/getfoodfeed/data/datasources/remote_getfood.dart';
import 'package:foodie/features/getfoodfeed/data/repositories/getfooddatasource.dart';
import 'package:foodie/features/getfoodfeed/domain/repositories/getfood_repo.dart';
import 'package:foodie/features/getfoodfeed/presentation/provider/getfoodfeed_state.dart';
import 'package:foodie/features/orderfood/presentation/provider/getCart.dart';
import 'package:get_it/get_it.dart';
import '../../features/Firstcheck/data/repositories/firstcheckrepo.dart';
import '../../features/SelectExtrafood/data/datasources/extra_datasource.dart';
import '../../features/SelectExtrafood/data/repositories/extrafood_repo.dart';
import '../../features/SelectExtrafood/domain/repositories/Extrafood_Repo.dart';
import '../../features/SelectExtrafood/presentation/provider/getExtraprovider.dart';
import '../../features/addTocart/data/datasources/remoteDatasource.dart';
import '../../features/addTocart/data/repositories/DatasourceRepo.dart';
import '../../features/addTocart/domain/repositories/sendcartRepo.dart';
import '../../features/addTocart/presentation/provider/AddTocart.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import '../../features/changeaddress/data/datasources/remote_datasource.dart';
import '../../features/changeaddress/data/repositories/changeaddress_repo.dart';
import '../../features/changeaddress/domain/repositories/changeAdressrepo.dart';
import '../../features/changeaddress/presentation/provider/changeAddress.dart';
import '../../features/collecttime /data/datasources/remote_datasource.dart';
import '../../features/collecttime /data/repositories/gettime_repo.dart';
import '../../features/collecttime /domain/repositories/getTimerepo.dart';
import '../../features/collecttime /presentation/Provider/getTimeProvider.dart';
import '../../features/getslide/data/datasources/remote_datasource.dart';
import '../../features/getslide/data/repositories/remote_repositories.dart';
import '../../features/getslide/domain/repositories/slide_repository.dart';
import '../../features/getslide/presentation/provider/getslideprovider.dart';
import '../../features/notification/data/datasources/remote_datasource.dart';
import '../../features/notification/data/repositories/notification_repo.dart';
import '../../features/notification/domain/repositories/Notificationrepo.dart';
import '../../features/notification/presentation/provider/NotificationPro.dart';
import '../../features/orderfood/data/datasources/remote_datasource.dart';
import '../../features/orderfood/data/repositories/cart_repo.dart';
import '../../features/orderfood/domain/repositories/cartrepo.dart';
import '../../features/orders/data/datasources/remote_datasource.dart';
import '../../features/orders/data/repositories/orderRepo.dart';
import '../../features/orders/domain/repositories/order_repo.dart';
import '../../features/orders/presentation/provider/GetOrder.dart';
import '../../features/userdetails/data/datasources/remote_datasource.dart';
import '../../features/userdetails/data/repositories/detailsrepo.dart';
import '../../features/userdetails/domain/repositories/userdetails_repo.dart';
import '../../features/userdetails/presentation/provider/getregisteredId.dart';
import 'dio_service.dart';
import 'http_service.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator
    //repositories
    ..registerLazySingleton<AuthDatasourceImpl>(
        () => AuthDatasourceImpl(locator()))
    ..registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(locator()))
    ..registerLazySingleton<AuthRepsitiory>(() => AuthRepositoryImpl(locator()))
    ..registerLazySingleton(() => AuthProvider(locator()))
    //firstcheck
    ..registerLazySingleton<Firstcheckimp>(() => Firstcheckimp(locator()))
    ..registerLazySingleton<FirscheckDatasource>(
        () => Firstcheckdatasoureimpl(locator()))
    ..registerLazySingleton<Firscheckrepository>(() => Firstcheckimp(locator()))
    ..registerLazySingleton(() => firstcheckprovider(locator()))

    //Authrepo
    //changeAdress
    ..registerLazySingleton<ChangeAddressimp>(() => ChangeAddressimp(locator()))
    ..registerLazySingleton<ChangeAddressDataSource>(
        () => ChangeAddressimp(locator()))
    ..registerLazySingleton<ChangeAddressRepo>(
        () => ChangeAddressRepoimp(locator()))
    ..registerLazySingleton(() => ChangeAddressPro(locator()))
    //GetCart
    ..registerLazySingleton<CartDataSourceImpl>(
        () => CartDataSourceImpl(locator()))
    ..registerLazySingleton<CartDatasource>(
        () => CartDataSourceImpl(locator()))
    ..registerLazySingleton<CartRepo>(() => CartRepoImpl(locator()))
    ..registerLazySingleton(() => GetCartPro(locator()))
        //GetOrder
    ..registerLazySingleton<orderdatasourceImpl>(
        () => orderdatasourceImpl(locator()))
    ..registerLazySingleton<OrderDatasource>(
        () => orderdatasourceImpl(locator()))
    ..registerLazySingleton<OrderRepo>(() => OrderRepoImpl(locator()))
    ..registerLazySingleton(() => GetOrderPro(locator()))
    //food details
    ..registerLazySingleton<GetfoodDataSourceimp>(
        () => GetfoodDataSourceimp(locator()))
    ..registerLazySingleton<GetfoodDataSource>(
        () => GetfoodDataSourceimp(locator()))
    ..registerLazySingleton<GetfoodRepository>(() => GetfoodDataimp(locator()))
    ..registerLazySingleton(() => getfoodprovider(locator()))
    //ImagesSlide
    ..registerLazySingleton<SliderepositoryImp>(
        () => SliderepositoryImp(locator()))
    ..registerLazySingleton<SlideDataSource>(
        () => getslidedatasourceimpl(locator()))
    ..registerLazySingleton<Sliderepository>(
        () => SliderepositoryImp(locator()))
    ..registerLazySingleton(() => Getslideprovider(locator()))
    //notification
    ..registerLazySingleton<NotificationDatasourceImpl>(
        () => NotificationDatasourceImpl(locator()))
    ..registerLazySingleton<NotificationDatasource>(
        () => NotificationDatasourceImpl(locator()))
    ..registerLazySingleton<NotificationRepo>(
        () => NotificationRepoImpl(locator()))
    ..registerLazySingleton(() => NotificationPro(locator()))
    //GetTime
    ..registerLazySingleton<GetTimeDatasourceImpl>(
        () => GetTimeDatasourceImpl(locator()))
    ..registerLazySingleton<GetTimeDatasource>(
        () => GetTimeDatasourceImpl(locator()))
    ..registerLazySingleton<GetTimeRepo>(() => GetTimeRepoImpl(locator()))
    ..registerLazySingleton(() => GetTimePro(locator()))
    //getregisteredID
    ..registerLazySingleton<UserdetailrepoImpl>(
        () => UserdetailrepoImpl(locator()))
    ..registerLazySingleton<UserdetailsDatasource>(
        () => UserdetaisImp(locator()))
    ..registerLazySingleton<Userdetailsrepository>(
        () => UserdetailrepoImpl(locator()))
    ..registerLazySingleton(() => GetregisteredIdprovider(locator()))
    //FoodExtra
    ..registerLazySingleton<ExtraDatasourceImp>(
        () => ExtraDatasourceImp(locator()))
    ..registerLazySingleton<ExtrafoodDataSource>(
        () => ExtraDatasourceImp(locator()))
    ..registerLazySingleton<ExtrafoodRepository>(() => ExtrafoodImp(locator()))
    ..registerLazySingleton(() => GetExtraprovider(locator()))
//sendcart
    ..registerLazySingleton<SendCartDatasourceImpl>(
        () => SendCartDatasourceImpl(locator()))
    ..registerLazySingleton<SendCartDataSource>(
        () => SendCartDatasourceImpl(locator()))
    ..registerLazySingleton<SendCartRepository>(() => SendcartImp(locator()))
    ..registerLazySingleton(() => addTocart(locator()))
    //services

    ..registerLazySingleton<HttpService>(() => DioService(locator()))
    //packages
    ..registerLazySingleton(() => Dio());
}
