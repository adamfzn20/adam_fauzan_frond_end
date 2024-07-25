import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_controller.dart';
import 'package:get/get.dart';

class StokBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StokController>(() => StokController());
  }
}
