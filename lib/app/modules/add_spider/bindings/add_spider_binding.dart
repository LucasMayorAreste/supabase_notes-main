import 'package:get/get.dart';
import '../controllers/add_spider_controller.dart';

class AddSpiderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSpiderController>(
          () => AddSpiderController(),
    );
  }
}