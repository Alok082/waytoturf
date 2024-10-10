import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waytoturf/controller.dart';

final locator = GetIt.instance;

GetStorage storage = locator<GetStorage>();
Future<void> setup() async {
  // locator.registerLazySingleton(Get.put(() => RideController()));
  // locator.registerLazySingleton(Get.put(() => SplashScreenController()));
  // locator.registerLazySingleton(Get.put(() => AuthController()));
  locator.registerSingletonAsync<GetStorage>(() async {
    await GetStorage.init(); // Initialize GetStorage
    return GetStorage(); // Return an instance of GetStorage
  });
}
