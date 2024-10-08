import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:adam_fauzan_frond_end/utills/widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FloatingSubmitButton extends StatelessWidget {
  const FloatingSubmitButton({
    super.key,
    required this.onPressed,
    this.textButton,
  });

  final Function()? onPressed;
  final String? textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
          color: AppColors.surface, boxShadow: [AppElevation.elevation4px]),
      child: PrimaryButton(
          title: textButton ?? "txt_button_submit_request".tr,
          onPressed: onPressed),
    );
  }
}
