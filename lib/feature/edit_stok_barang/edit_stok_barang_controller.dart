import 'package:adam_fauzan_frond_end/data/local/sqlite/database_service.dart';
import 'package:adam_fauzan_frond_end/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EditStokBarangController extends GetxController {
  var selectedItems = <Barang>[].obs;
  final RefreshController refreshController = RefreshController();
  final DatabaseService _databaseService = DatabaseService();

  RxList<Barang> barangList = <Barang>[].obs;
  RxList<Barang> allBarangList = <Barang>[].obs;
  RxBool hasMore = true.obs;
  int _page = 1;
  final int _limit = 5;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    loadDataBarang();
    await getAllDataBarang();
  }

  Future<void> refreshPage() async {
    barangList.clear();
    allBarangList.clear();
    refreshController.resetNoData();
    _page = 1;
    hasMore.value = true;
    await loadDataBarang();
    await getAllDataBarang();
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

  Future<void> getAllDataBarang() async {
    try {
      final newItems = await _databaseService.getAllBarang();
      if (newItems.isEmpty) {
        hasMore.value = false;
      } else {
        allBarangList.addAll(newItems);
      }
    } catch (e) {
      print(e);
    }
  }

  void toggleSelection(Barang barang) {
    if (selectedItems.contains(barang)) {
      selectedItems.remove(barang);
    } else {
      selectedItems.add(barang);
    }
  }

  void selectAll() {
    selectedItems.value = List.from(barangList);
  }

  Future<void> deleteSelected(BuildContext context) async {
    isLoading.value = true;
    try {
      for (var barang in selectedItems) {
        await _databaseService.deleteBarang(barang.id!);
        barangList.remove(barang);
      }
      selectedItems.clear();
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
}
