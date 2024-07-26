import 'package:adam_fauzan_frond_end/feature/edit_stok_barang/edit_stok_barang_controller.dart';
import 'package:flutter/material.dart';
import 'stok_items.dart';

class ListStokBarangBuilder extends StatelessWidget {
  const ListStokBarangBuilder({
    super.key,
    required this.controller,
  });

  final EditStokBarangController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.barangList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final barang = controller.barangList[index];
        return StokListItem(
          barang: barang,
          controller: controller,
        );
      },
    );
  }
}
