import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ExpansionTileAbout extends StatelessWidget {
  const ExpansionTileAbout(
      {super.key,
      required this.title,
      required this.image,
      required this.isLink,
      this.appVersion});

  final image;
  final String title;
  final bool isLink;
  final String? appVersion;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [AppElevation.elevation4px],
      ),
      child: Column(
        children: [
          ExpansionTile(
            textColor: AppColors.textColour80,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            childrenPadding: const EdgeInsets.only(bottom: 12),
            tilePadding: EdgeInsets.zero,
            title: Row(
              children: [
                Image.asset(image),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  // "txt_profile_privacy_policy".tr,
                  title.tr,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColour80,
                      ),
                )
              ],
            ),
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.colorSecondary,
              ),
              const SizedBox(
                height: 16,
              ),
              isLink
                  ? Row(
                      children: [
                        Text(
                          "txt_profile_read_more".tr,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.textColour60,
                                  ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          title.tr,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.colorPrimary,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "txt_profile_scm_hub_version".tr,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.textColour60,
                                  ),
                        ),
                        Text(appVersion == null ? "1.0.100" : appVersion!,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColour60))
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
