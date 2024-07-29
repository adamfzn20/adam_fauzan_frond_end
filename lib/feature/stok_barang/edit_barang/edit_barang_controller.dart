import 'package:adam_fauzan_frond_end/data/local/sqlite/database_service.dart';
import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:adam_fauzan_frond_end/model/kategori_model.dart';
import 'package:adam_fauzan_frond_end/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_controller.dart';

class EditBarangController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final DatabaseService _databaseService = DatabaseService();
  final StokController stokController = StokController.find;

  bool isObscure = true;
  String? kelompokResult;
  String? kategoriResult;
  String? namaBarangResult;
  int? stokResult;
  double? hargaResult;
  int? id;

  RxList<Kategori> kategoriList = <Kategori>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getData();
    fetchKategoriList();
    update();
  }

  Future<void> getData() async {
    id = Get.arguments['id'];
    namaBarangResult = Get.arguments['namaBarang'];
    kategoriResult = Get.arguments['kategoriId'];
    stokResult = Get.arguments['stok'];
    kelompokResult = Get.arguments['kelompokBarang'];
    hargaResult = Get.arguments['harga'];
    update();
  }

  void fetchKategoriList() async {
    kategoriList.value = await _databaseService.getAllKategori();
    final kategoriId = int.parse(Get.arguments['kategoriId'].toString());
    final selectedKategori = kategoriList.firstWhere(
      (kategori) => kategori.id == kategoriId,
      orElse: () => Kategori(id: 0, namaKategori: 'Kategori tidak ditemukan'),
    );
    kategoriResult = selectedKategori.namaKategori;
    update();
  }

  Future<void> updateBarang(BuildContext context) async {
    if (formKey.currentState != null &&
        formKey.currentState!.saveAndValidate()) {
      final selectedKategori = kategoriList.firstWhere(
        (kategori) => kategori.namaKategori == kategoriResult,
        orElse: () => Kategori(id: 0, namaKategori: 'Kategori tidak ditemukan'),
      );
      kategoriResult = selectedKategori.id.toString();
      final updatedBarang = Barang(
        id: id,
        namaBarang: namaBarangResult!,
        kategoriId: int.parse(kategoriResult!),
        stok: stokResult!,
        kelompokBarang: kelompokResult!,
        harga: hargaResult!,
      );
      await _databaseService.updateBarang(updatedBarang);
      await stokController.refreshPage();
      if (context.mounted) {
        await PopUpWidget.successAndFailPopUp(
          context: context,
          titleString: "txt_general_request_sent".tr,
          middleText: "txt_general_success".tr,
          buttonText: "txt_button_ok".tr,
        );
      }
      Get.back();
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
