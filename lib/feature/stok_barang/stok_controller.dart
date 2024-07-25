import 'package:adam_fauzan_frond_end/feature/stok_barang/detail_barang/detail_barang_page.dart';
import 'package:adam_fauzan_frond_end/utills/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StokController extends GetxController {
  RefreshController refreshController = RefreshController();
  // RxList<MedicalData> medicalList = <MedicalData>[].obs;
  RxBool hasMore = true.obs;
  String? token;
  bool isEmptyData = true;
  RxBool isLoading = false.obs;

  int _page = 1;
  // final int _limit = 10;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> refreshPage() async {
    refreshController.resetNoData();
    _page = 1;
    hasMore.value = true;
    refreshController.refreshCompleted();
  }

  Future<void> loadNextPage() async {
    if (hasMore.value) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  void showDetailStok(BuildContext context) {
    isLoading = true.obs;
    update();
    BottomSheetWidget.showSimpleBottomSheet(
      context,
      titleText: "Detail Barang",
      bottomSheetContent: const DetailBarangPage(),
    );
    isLoading = false.obs;
    update();
  }
}
