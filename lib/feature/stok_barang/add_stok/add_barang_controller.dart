import 'package:adam_fauzan_frond_end/data/local/sqlite/database_service.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_controller.dart';
import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:adam_fauzan_frond_end/model/kategori_model.dart';
import 'package:adam_fauzan_frond_end/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddBarangController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final DatabaseService _databaseService = DatabaseService();
  final StokController stokController = StokController.find;

  bool isObscure = true;
  String? kelompokResult;
  String? kategoriResult;
  String? namaBarangResult;
  int? stokResult;
  String? hargaResult;

  RxList<Kategori> kategoriList = <Kategori>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKategoriList();
  }

  void fetchKategoriList() async {
    kategoriList.value = await _databaseService.getAllKategori();
  }

  Future<void> addBarang(BuildContext context) async {
    if (formKey.currentState != null &&
        formKey.currentState!.saveAndValidate()) {
      final barang = Barang(
        namaBarang: namaBarangResult!,
        kategoriId: int.parse(kategoriResult!),
        stok: stokResult!,
        kelompokBarang: kelompokResult!,
        harga: double.parse(hargaResult!),
      );
      await _databaseService.addBarang(barang);
      if (context.mounted) {
        await PopUpWidget.successAndFailPopUp(
          context: context,
          titleString: "txt_general_request_sent".tr,
          middleText: "txt_general_success".tr,
          buttonText: "txt_button_ok".tr,
        );
      }
      await stokController.refreshPage();
      Get.back();
    }
  }

  TextEditingValue formatRupiah(String text) {
    if (text.isEmpty) {
      return TextEditingValue(text: text);
    }
    try {
      final numericValue = int.parse(text.replaceAll('.', ''));
      final formatText =
          NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
              .format(numericValue);

      return TextEditingValue(
        text: formatText,
        selection: TextSelection.collapsed(offset: formatText.length),
      );
    } catch (e) {
      // Tangani kesalahan parsing angka
      return TextEditingValue(text: text);
    }
  }
}
