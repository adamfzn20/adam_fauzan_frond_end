import 'package:adam_fauzan_frond_end/data/local/sqlite/database_service.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/detail_barang/detail_barang_page.dart';
import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:adam_fauzan_frond_end/utills/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StokController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final DatabaseService _databaseService = DatabaseService();

  RxList<Barang> barangList = <Barang>[].obs;
  RxBool hasMore = true.obs;
  int _page = 1;
  final int _limit = 7;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDataBarang();
  }

  Future<void> refreshPage() async {
    barangList.clear();
    refreshController.resetNoData();
    _page = 1;
    hasMore.value = true;
    await loadDataBarang();
    refreshController.refreshCompleted();
  }

  Future<void> loadNextPage() async {
    if (hasMore.value) {
      _page++;
      await loadDataBarang();
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> loadDataBarang() async {
    isLoading.value = true;
    final newItems = await _databaseService.getBarangPaginated(_page, _limit);
    if (newItems.isEmpty) {
      hasMore.value = false;
    } else {
      barangList.addAll(newItems);
    }
    isLoading.value = false;
  }

  Future<void> deleteBarang(Barang barang, BuildContext context) async {
    isLoading.value = true;
    try {
      await _databaseService.deleteBarang(barang.id!);
      barangList.remove(barang);
      isLoading.value = false;
      update();
      if (context.mounted) {
        await PopUpWidget.successAndFailPopUp(
          context: context,
          titleString: "txt_general_request_sent".tr,
          middleText: "txt_general_success".tr,
          buttonText: "txt_button_ok".tr,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> updateBarang(Barang barang) async {
    isLoading.value = true;
    await _databaseService.updateBarang(barang);
    int index = barangList.indexWhere((b) => b.id == barang.id);
    if (index != -1) {
      barangList[index] = barang;
    }
    isLoading.value = false;
    update();
  }

  void showDetailStok(BuildContext context, Barang barang) {
    isLoading = true.obs;
    update();
    BottomSheetWidget.showSimpleBottomSheet(
      context,
      titleText: "Detail Barang",
      bottomSheetContent: DetailBarangPage(
        barang: barang,
        controller: this,
      ),
    );
    isLoading = false.obs;
    update();
  }
}
