import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_controller.dart';
import 'package:adam_fauzan_frond_end/feature/stok_barang/widgets/stok_items.dart';
import 'package:flutter/material.dart';

class ListStokBarangBuilder extends StatelessWidget {
  const ListStokBarangBuilder({
    super.key,
    required this.controller,
  });

  final StokController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // itemCount: controller.dataList.length,
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return StokListItem(
          index: index,
          controller: controller,
          // mData: controller.dataList[index],
        );
      },
    );
  }
}
