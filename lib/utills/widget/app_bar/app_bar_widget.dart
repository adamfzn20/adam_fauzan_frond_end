import 'package:adam_fauzan_frond_end/feature/stok_barang/stok_controller.dart';
import 'package:adam_fauzan_frond_end/model/barang_model.dart';
import 'package:adam_fauzan_frond_end/utills/helper/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '/resources/resources.dart';

class AppBarWidget {
  static AppBar defaultAppBar({
    Color? color,
    required Brightness brightness,
    ImageProvider? backImage,
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    List<Widget>? actions,
    Function()? backCallback,
    PreferredSizeWidget? bottom,
    required BuildContext context,
  }) {
    return AppBar(
      title: Text(
        title ?? '',
        style: titleStyle ??
            Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.textColour80),
      ),
      centerTitle: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0.0,
      leading: InkWell(
        onTap: backCallback ?? () => Get.back(),
        child: backImage == null
            ? const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.textColour80,
              )
            : Image(
                image: backImage,
                width: 24,
                height: 24,
              ),
      ),
      actions: actions ?? [],
      bottom: bottom,
    );
  }

  // AppBar transparent with just Back Button
  static AppBar simple({
    required String titleString,
    required BuildContext context,
  }) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.textColour80),
      backgroundColor: Colors.transparent,
      title: Text(
        titleString,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontSize: 18, color: AppColors.textColour80),
      ),
    );
  }

  /// Gunakan `Primary Appbar` untuk membuat AppBar default secara global
  /// agar jenis AppBar utama terpusat dan modular
  /// *boleh di-edit sesuai kebutuhan*
  ///
  static AppBar primaryAppbar({
    required String titleString,
    required BuildContext context,
    bool withFilter = false,
    Function()? filterOnPressed,
    bool withSearch = false,
    Widget? searchResultWidget,
    List<Barang>? barangList,
    Function()? onSearchPressed,
  }) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.textColour80),
      backgroundColor: AppColors.surface,
      shadowColor: const Color(0xFF000E33).withOpacity(0.1),
      elevation: 2,
      title: Text(
        titleString,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontSize: 18, color: AppColors.textColour80),
      ),
      actions: [
        Visibility(
          visible: withSearch,
          child: Container(
            margin:
                withFilter == false ? const EdgeInsets.only(right: 8) : null,
            child: IconButton(
              icon:
                  const Icon(IconlyLight.search, color: AppColors.textColour80),
              onPressed: onSearchPressed,
            ),
          ),
        ),
        Visibility(
          visible: withFilter,
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
                icon: const Icon(IconlyLight.filter2,
                    color: AppColors.textColour80),
                onPressed: filterOnPressed),
          ),
        ),
      ],
    );
  }

  /// `Secondary Appbar` digunakan apabila membutuhkan jenis AppBar yang berbeda
  /// dari AppBar utama. Misal untuk AppBar Detail
  /// *boleh di-edit sesuai kebutuhan*
  ///
  static AppBar secondaryAppbar({
    required String titleString,
    required BuildContext context,
    bool withLeading = false,
    bool withFilter = false,
    Function()? filterOnPressed,
    bool withSearch = false,
    Widget? searchResultWidget,
    bool? center,
    List<Barang>? barangList,
    Function()? onSearchPressed,
  }) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.textColour80),
      backgroundColor: AppColors.surface,
      shadowColor: const Color(0xFF000E33).withOpacity(0.1),
      elevation: 2,
      centerTitle: center,
      leading: withLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textColour80),
              onPressed: () {
                // Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(
        titleString,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: AppColors.textColour80),
      ),
      actions: [
        Visibility(
          visible: withSearch,
          child: Container(
            margin:
                withFilter == false ? const EdgeInsets.only(right: 8) : null,
            child: IconButton(
              icon:
                  const Icon(IconlyLight.search, color: AppColors.textColour80),
              onPressed: onSearchPressed,
            ),
          ),
        ),
        Visibility(
          visible: withFilter,
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
                icon: const Icon(IconlyLight.filter2,
                    color: AppColors.textColour80),
                onPressed: filterOnPressed),
          ),
        ),
      ],
    );
  }
}

class MySearchDelegate extends SearchDelegate<Barang?> {
  MySearchDelegate({required this.barangList, required this.controller});

  final List<Barang> barangList;
  final StokController controller;
  static const int initialItemCount = 4;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: AppColors.textColour80),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.textColour80),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = barangList
        .where((barang) =>
            barang.namaBarang.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final barang = results[index];
        return StokListItem(
          barang: barang,
          controller: controller,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = barangList
        .where((barang) =>
            barang.namaBarang.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final limitedSuggestions = suggestions.take(initialItemCount).toList();

    return ListView.builder(
      itemCount: limitedSuggestions.length,
      itemBuilder: (context, index) {
        final barang = limitedSuggestions[index];
        return StokListItem(
          barang: barang,
          controller: controller,
        );
      },
    );
  }
}

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
