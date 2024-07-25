import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class SelectAttachmentOptionsWidget extends StatelessWidget {
  const SelectAttachmentOptionsWidget({
    super.key,
    required this.onTap,
  });

  final Function(ImageSource source) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => onTap(ImageSource.camera),
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 50.w - 24,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(16),
              color: AppColors.colorSecondary,
              dashPattern: const [8, 4],
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    const Icon(IconlyLight.camera,
                        size: 55, color: AppColors.colorSecondary),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'txt_general_take_a_picture'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.textColour90),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => onTap(ImageSource.gallery),
          child: SizedBox(
            width: 50.w - 24,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(16),
              color: AppColors.colorSecondary,
              dashPattern: const [8, 4],
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    const Icon(IconlyLight.folder,
                        size: 55, color: AppColors.colorSecondary),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "txt_general_gallery".tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.textColour90),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
