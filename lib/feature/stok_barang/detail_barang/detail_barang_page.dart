import 'package:adam_fauzan_frond_end/routes/page_names.dart';
import 'package:adam_fauzan_frond_end/utills/helper/convert.dart';
import 'package:adam_fauzan_frond_end/utills/widget/button/primary_button.dart';
import 'package:adam_fauzan_frond_end/utills/widget/content/detail_content_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../model/barang_model.dart';
import '../../../resources/resources.dart';
import '../stok_controller.dart';

class DetailBarangPage extends StatelessWidget {
  final Barang barang;
  final StokController controller;

  const DetailBarangPage(
      {super.key, required this.barang, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AppImages.imageEmpty.image().image,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          color: AppColors.colorSecondary,
          thickness: 1,
        ),
        const SizedBox(height: 8),
        DetailContentItem(
          icon: const Icon(
            IconlyLight.bag,
            color: AppColors.colorSecondary,
          ),
          title: "txt_nama_barang".tr,
          contentText: barang.namaBarang,
        ),
        const SizedBox(height: 16),
        DetailContentItem(
          icon: const Icon(
            Icons.signpost_outlined,
            color: AppColors.colorSecondary,
          ),
          title: "txt_kategori_barang".tr,
          contentText: barang.kategoriId.toString(),
        ),
        const SizedBox(height: 16),
        DetailContentItem(
          icon: const FaIcon(
            IconlyLight.category,
            color: AppColors.colorSecondary,
          ),
          title: "txt_kelompok_barang".tr,
          contentText: barang.kelompokBarang,
        ),
        const SizedBox(height: 16),
        DetailContentItem(
          icon: const FaIcon(
            FontAwesomeIcons.bars,
            color: AppColors.colorSecondary,
          ),
          title: "txt_stok".tr,
          contentText: barang.stok.toString(),
        ),
        const SizedBox(height: 16),
        DetailContentItem(
          icon: const FaIcon(
            FontAwesomeIcons.moneyBill,
            color: AppColors.colorSecondary,
          ),
          title: "txt_harga".tr,
          contentText: Convert.formatRupiah(barang.harga),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryButton(
              width: MediaQuery.of(context).size.width * 0.43,
              title: 'txt_button_hapus_barang'.tr,
              colorText: AppColors.danger,
              customColor: AppColors.surface,
              elevation: [AppElevation.elevation2px],
              onPressed: () async {
                await controller.deleteBarang(barang, context);
                Get.back();
              },
            ),
            PrimaryButton(
              width: MediaQuery.of(context).size.width * 0.43,
              title: 'txt_button_edit_barang'.tr,
              onPressed: () {
                Get.toNamed(PageName.EDIT_BARANG, arguments: {
                  'id': barang.id,
                  'namaBarang': barang.namaBarang,
                  'kategoriId': barang.kategoriId.toString(),
                  'kelompokBarang': barang.kelompokBarang,
                  'stok': barang.stok,
                  'harga': barang.harga,
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
