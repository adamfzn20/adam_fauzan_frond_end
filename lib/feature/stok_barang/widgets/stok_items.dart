import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_controller.dart';
import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:adam_fauzan_frond_end/utills/helper/convert.dart';
import 'package:flutter/material.dart';
import '/resources/resources.dart';
import 'package:sizer/sizer.dart';

class StokListItem extends StatelessWidget {
  final Barang barang;
  final StokController controller;

  const StokListItem({
    super.key,
    required this.barang,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.showDetailStok(context, barang);
      },
      child: Container(
          width: 100.w,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [AppElevation.elevation4px]),
          clipBehavior: Clip.hardEdge,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 8,
              children: [
                SizedBox(
                  width: 100.w - 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          barang.namaBarang,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColour90),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          Convert.formatRupiah(barang.harga),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.surface),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w - 70,
                  child: Text(
                    "Stok: ${barang.stok}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorSecondary),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
