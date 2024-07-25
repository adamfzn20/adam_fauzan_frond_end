import 'package:adam_fauzan_frond_end/feature/stok_barang/add_stok/add_barang_controller.dart';
import 'package:get/get.dart';

class AddBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBarangController>(() => AddBarangController());
  }
}
