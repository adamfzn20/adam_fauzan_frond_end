import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/resources/resources.dart';

enum ShapeImage { oval, react }

class ImageLoad extends StatefulWidget {
  final String? image;
  final ImageProvider? placeholder;
  final ShapeImage shapeImage;
  final BoxFit fit;
  final Widget? errorWidget;
  final double radius;
  final double? height;
  final double? width;

  ImageLoad({
    Key? key,
    required this.image,
    this.placeholder,
    this.shapeImage = ShapeImage.react,
    this.fit = BoxFit.fill,
    this.errorWidget,
    this.radius = 10.0,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _ImageLoadState createState() => _ImageLoadState();
}

class _ImageLoadState extends State<ImageLoad> {
  @override
  Widget build(BuildContext context) {
    // debugPrint("{Image: ${widget.image}");
    if (widget.image != null &&
        widget.image!.isNotEmpty &&
        widget.image != "null") {
      // debugPrint("NOT empty}");
      return getOvalOrReact(getImageNetwork());
    } else {
      // debugPrint("IS empty}");
      return getOvalOrReact(getPlaceholder());
    }
  }

  Widget getOvalOrReact(Widget child) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: widget.shapeImage == ShapeImage.react
            ? ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                child: child,
              )
            : ClipOval(child: child));
  }

  Widget getImageNetwork() {
    return FadeInImage(
      image: NetworkImage(widget.image!),
      fit: widget.fit,
      placeholder: widget.placeholder != null
          ? widget.placeholder!
          : AppImages.imgError.image().image,
      imageErrorBuilder: (context, _, stackTrace) {
        return widget.errorWidget ?? getPlaceholder();
      },
    );
  }

  Widget getPlaceholder() {
    return widget.placeholder != null
        ? Image(
            image: widget.placeholder!,
            color: AppColors.grey,
            fit: widget.fit,
          )
        : SvgPicture.asset(
            AppImages.svgEmpty,
            color: AppColors.grey,
            fit: widget.fit,
          );
  }
}
