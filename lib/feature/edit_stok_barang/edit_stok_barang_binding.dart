import 'package:adam_fauzan_frond_end/feature/edit_stok_barang/edit_stok_barang_controller.dart';
import 'package:get/get.dart';

class EditStokBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditStokBarangController>(() => EditStokBarangController());
  }
}
