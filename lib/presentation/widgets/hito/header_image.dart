import 'package:flutter/material.dart';
import 'package:history_app/config/theme/responsive.dart';

class HeaderImage extends StatelessWidget {
  final String image;

  const HeaderImage(this.image, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);  

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsive.ip(1)),
        child: Image.network(
          image,
          width: responsive.wp(70),
          height: responsive.hp(50),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
