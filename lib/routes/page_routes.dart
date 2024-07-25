import 'package:adam_fauzan_frond_end/feature/loader/loading_page.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/add_stok/add_barang_binding.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/add_stok/add_barang_page.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/edit_barang/edit_barang_binding.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/edit_barang/edit_barang_page.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_binding.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_page.dart';
import 'package:get/get.dart';
import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.LOADER,
      page: () => const LoadingPage(),
    ),
    GetPage(
      name: PageName.STOK,
      page: () => const StokPage(),
      binding: StokBinding(),
    ),
    GetPage(
      name: PageName.ADD_BARANG,
      page: () => const AddBarangPage(),
      binding: AddBarangBinding(),
    ),
    GetPage(
      name: PageName.EDIT_BARANG,
      page: () => const EditBarangPage(),
      binding: EditBarangBinding(),
    ),
  ];
}
