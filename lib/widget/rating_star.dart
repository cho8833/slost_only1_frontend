import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingStar extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  final Color? borderColor;
  final double size;
  final bool allowHalfRating;
  final IconData? filledIconData;
  final IconData? halfFilledIconData;
  final IconData? defaultIconData; //this is needed only when having fullRatedIconData && halfRatedIconData
  final double minValue;
  final double spacing;
  const RatingStar({super.key,
    this.minValue = 0,
    this.starCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.defaultIconData,
    this.onRatingChanged,
    this.color,
    this.borderColor,
    this.size = 25,
    this.filledIconData,
    this.halfFilledIconData,
    this.allowHalfRating = true,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        defaultIconData ?? Icons.star_border,
        color: borderColor ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else if (index >= rating - (allowHalfRating ? 0.5 : 1.0) &&
        index < rating) {
      icon = Icon(
        halfFilledIconData ?? Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = Icon(
        filledIconData ?? Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    }

    return GestureDetector(
      onTap: () {
        if (onRatingChanged != null) onRatingChanged!(index + 1.0);
      },
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject() as RenderBox;
        var pos = box.globalToLocal(dragDetails.globalPosition);
        var i = pos.dx / size;
        var newRating = allowHalfRating ? roundToHalf(i) : i.round().toDouble();
        if (newRating > starCount) {
          newRating = starCount.toDouble();
        }
        if (newRating < minValue) {
          newRating = minValue;
        }
        if (onRatingChanged != null) onRatingChanged!(newRating);
      },
      child: icon,
    );
  }

  double roundToHalf(double value) {
    return (value * 2).round() / 2.0;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: spacing,
        children: List.generate(
          starCount,
              (index) => buildStar(context, index),
        ),
      ),
    );
  }
}