import 'package:flutter/material.dart';

import 'package:history_app/config/theme/responsive.dart';

class CustomProgress extends StatelessWidget {
  final Color? textColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double valueProgress;
  final EdgeInsets? padding;

  const CustomProgress({
    super.key,
    this.textColor,
    this.backgroundColor,
    this.foregroundColor,
    required this.valueProgress,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tus puntos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 10,),
          ClipRRect(
            borderRadius: BorderRadius.circular(responsive.ip(1)),
            child: LinearProgressIndicator(
              minHeight: responsive.ip(1.5),
              backgroundColor: backgroundColor,
              color: foregroundColor,
              value: valueProgress,
            ),
          ),
        ],
      ),
    );
  }
}