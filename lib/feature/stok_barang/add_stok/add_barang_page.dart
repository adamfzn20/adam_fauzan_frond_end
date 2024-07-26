import 'package:adam_fauzan_frond_end/feature/stok_barang/add_stok/add_barang_controller.dart';
import 'package:adam_fauzan_frond_end/utills/helper/convert.dart';
import 'package:adam_fauzan_frond_end/utills/widget/app_bar/app_bar_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/floating_action_button/floating_submit_button.dart';
import 'package:adam_fauzan_frond_end/utills/widget/forms/dropdown_search_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/forms/label_form_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/forms/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../utills/helper/validator.dart';

class AddBarangPage extends StatelessWidget {
  const AddBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBarangController>(builder: (controller) {
      return Scaffold(
        appBar: AppBarWidget.secondaryAppbar(
            titleString: "txt_tambah_barang".tr, context: context),
        body: FormBuilder(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelFormWidget(labelText: "txt_nama_barang".tr),
                  TextFieldWidget(
                    name: 'nama_barang',
                    hintText: "Masukan ${'txt_nama_barang'.tr}",
                    validator: Validator.required(),
                    onChanged: (String? newValue) {
                      controller.namaBarangResult = newValue;
                    },
                  ),
                  const SizedBox(height: 16),
                  LabelFormWidget(labelText: "txt_kategori_barang".tr),
                  Obx(() => DropdownSearchWidget(
                        hintText: "Masukan ${'txt_kategori_barang'.tr}",
                        selectedItem: controller.kategoriResult,
                        validator: Validator.required(),
                        dropdownItems: controller.kategoriList
                            .map((kategori) => kategori.namaKategori)
                            .toList(),
                        onChanged: (String? newValue) {
                          final selectedKategori = controller.kategoriList
                              .firstWhere((kategori) =>
                                  kategori.namaKategori == newValue);
                          controller.kategoriResult =
                              selectedKategori.id.toString();
                        },
                      )),
                  const SizedBox(height: 16),
                  LabelFormWidget(labelText: 'txt_kelompok_barang'.tr),
                  DropdownSearchWidget(
                    hintText: "Masukan ${"txt_kelompok_barang".tr}",
                    selectedItem: controller.kelompokResult,
                    validator: Validator.required(),
                    dropdownItems: const [
                      'Kemeja',
                      'TV',
                      'Smartphone',
                      'Celana',
                      'Gamis',
                      'Laptop',
                      'Sepatu',
                      'Tas',
                      'Jam Tangan',
                      'Kacamata',
                    ],
                    onChanged: (String? newValue) {
                      controller.kelompokResult = newValue;
                    },
                  ),
                  const SizedBox(height: 16),
                  LabelFormWidget(labelText: "txt_stok".tr),
                  TextFieldWidget(
                    name: 'stok',
                    hintText: "Masukan ${'txt_stok'.tr}",
                    validator: Validator.required(),
                    keyboardType: TextInputType.number,
                    onChanged: (String? newValue) {
                      controller.stokResult = int.tryParse(newValue ?? '0');
                    },
                  ),
                  const SizedBox(height: 16),
                  LabelFormWidget(labelText: "txt_harga".tr),
                  TextFieldWidget(
                    name: 'harga',
                    enabled: true,
                    hintText: "Masukan ${'txt_harga'.tr}",
                    validator: Validator.required(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return controller.formatRupiah(newValue.text);
                      }),
                    ],
                    onChanged: (String? newValue) {
                      controller.hargaResult =
                          Convert.removeFormatRupiah(newValue!);
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingSubmitButton(
          textButton: 'txt_button_tambah_barang'.tr,
          onPressed: () async {
            if (controller.formKey.currentState != null &&
                controller.formKey.currentState!.saveAndValidate()) {
              await controller.addBarang(context);
            }
          },
        ),
      );
    });
  }
}
