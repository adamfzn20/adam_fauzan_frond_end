import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:adam_fauzan_frond_end/routes/page_names.dart';
import 'package:adam_fauzan_frond_end/utills/helper/convert.dart';
import 'package:adam_fauzan_frond_end/utills/widget/app_bar/app_bar_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/button/primary_button.dart';
import 'package:adam_fauzan_frond_end/utills/widget/floating_action_button/request_fab_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/state_handle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'stok_controller.dart';
import 'widgets/stok_list_builder.dart';

class StokPage extends StatelessWidget {
  const StokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StokController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget.secondaryAppbar(
            titleString: "txt_list_stok_barang".tr,
            withSearch: true,
            context: context,
            withLeading: true,
            center: true,
            searchResultWidget: Container(), // Dummy widget
            onSearchPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(
                  barangList: controller.allBarangList,
                  controller: controller,
                ),
              );
            },
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
                                  margin:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${controller.allBarangList.length} Data ditampilkan",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    AppColors.colorSecondary),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(PageName.EDIT_STOK);
                                        },
                                        child: Text(
                                          "Edit Data",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.info),
                                        ),
                                      ),
                                    ],
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Stok ${controller.totalStok}'),
                        Text(
                            'Total Harga ${Convert.formatRupiah(controller.totalHarga)}'),
                      ],
                    ),
                    PrimaryButton(
                      width: MediaQuery.of(context).size.width * 0.43,
                      title: 'txt_button_tambah_barang'.tr,
                      elevation: [AppElevation.elevation2px],
                      onPressed: () async {
                        Get.toNamed(PageName.ADD_BARANG);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
