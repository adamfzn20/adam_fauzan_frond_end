import 'package:adam_fauzan_frond_end/feature/edit_stok_barang/edit_stok_barang_controller.dart';
import 'package:adam_fauzan_frond_end/feature/edit_stok_barang/widgets/stok_list_builder.dart';
import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:adam_fauzan_frond_end/utills/widget/app_bar/app_bar_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/button/primary_button.dart';
import 'package:adam_fauzan_frond_end/utills/widget/state_handle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class EditStokBarangPage extends StatelessWidget {
  const EditStokBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditStokBarangController>(builder: (controller) {
      return Scaffold(
        appBar: AppBarWidget.secondaryAppbar(
          titleString: "Edit ${"txt_list_stok_barang".tr}",
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => SmartRefresher(
                  enablePullUp: controller.hasMore.value,
                  enablePullDown: true,
                  onRefresh: controller.refreshPage,
                  onLoading: controller.loadNextPage,
                  controller: controller.refreshController,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        StateHandleWidget(
                          emptyImage: AppImages.svgEmpty,
                          emptyEnabled: controller.barangList.isEmpty,
                          errorEnabled: false,
                          onRetryPressed: () {
                            controller.refreshPage();
                          },
                          body: Column(
                            children: [
                              Container(
                                width: 100.w,
                                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                child: Text(
                                  "${controller.allBarangList.length} Data ditampilkan",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorSecondary),
                                ),
                              ),
                              ListStokBarangBuilder(controller: controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 100.w,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: controller.selectAll,
                    child: const Text('Select All'),
                  ),
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width * 0.43,
                    title: 'txt_button_hapus_barang'.tr,
                    colorText: AppColors.danger,
                    customColor: AppColors.surface,
                    elevation: [AppElevation.elevation2px],
                    onPressed: () async {
                      await controller.deleteSelected(context);
                    },
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await controller.deleteSelected();
                  //   },
                  //   child: const Text('Delete Selected'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
