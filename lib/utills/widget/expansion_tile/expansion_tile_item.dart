import 'package:adam_fauzan_frond_end/resources/resources.dart';
import 'package:flutter/material.dart';

class ExpansionTileItem extends StatelessWidget {
  const ExpansionTileItem({
    super.key,
    required this.title,
    required this.widget,
    required this.onDelete,
  });

  final String title;
  final Widget widget;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.colorSecondary, width: 1)),
      child: ExpansionTile(
        textColor: AppColors.textColour80,
        childrenPadding: const EdgeInsets.only(bottom: 12),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.textColour70),
            ),
            InkWell(
              onTap: onDelete,
              child: const Icon(
                Icons.delete,
                color: AppColors.danger,
              ),
            )
          ],
        ),
        children: [
          Container(
            height: 1,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: AppColors.colorSecondary,
          ),
          const SizedBox(
            height: 16,
          ),
          widget
        ],
      ),
    );
  }
}
