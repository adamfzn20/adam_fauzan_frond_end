import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:adam_fauzan_frond_end/routes/page_names.dart';
import 'package:adam_fauzan_frond_end/utills/widget/app_bar/app_bar_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/floating_action_button/request_fab_widget.dart';
import 'package:adam_fauzan_frond_end/utills/widget/state_handle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'stok_controller.dart';
import 'widgets/stok_list_builder.dart';

class StokPage extends StatelessWidget {
  const StokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.secondaryAppbar(
        titleString: "txt_list_stok_barang".tr,
        withSearch: true,
        context: context,
        withLeading: true,
        center: true,
      ),
      body: GetBuilder<StokController>(builder: (controller) {
        return Obx(
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
                    body: ListStokBarangBuilder(controller: controller),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: RequestFloatingActionButton(
        onTap: () {
          Get.toNamed(PageName.ADD_BARANG);
        },
        text: "txt_button_barang".tr,
      ),
    );
  }
}
