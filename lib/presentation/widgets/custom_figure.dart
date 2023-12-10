import 'package:flutter/material.dart';

import 'package:history_app/config/theme/responsive.dart';

class CustomFigure extends StatelessWidget {
  final Color? color;
  final double scale;
  final Widget? child;
  final Image? backgroundImage;
  final bool expand;

  const CustomFigure({
    super.key,
    this.color,
    this.scale = 0.0,
    this.child,
    this.backgroundImage,
    this.expand = false
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.hp(30),
      child: LayoutBuilder(
        builder: (context, constrainsts) => Stack(
          children: [
            SizedBox(
              width: constrainsts.maxWidth,
              height: constrainsts.maxHeight,
              child: CustomPaint(
                painter: Figure(color, scale),
                child: backgroundImage,   
              ),
            ),
            SizedBox(
              width: (expand) ? constrainsts.maxWidth : (constrainsts.maxWidth + (scale / 0.05)) * 0.75,
              height:(expand) ? constrainsts.maxHeight : (constrainsts.maxHeight + (scale / 0.05)) * 0.75,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}

class Figure extends CustomPainter {
  // Definición del lienzo
  final _path = Path();
  final Color? color;
  final double scale;

  Figure(
    this.color,
    this.scale
  ): assert( scale >= 0, 'The minimum scaling value is 0' ),  
      assert( scale <= 3,  'Maximum scaling value is 3');

  Path getPath(Size size) {
    final scaleMin = (scale / 0.05);
    final scaleY2 = (scale / 0.02);

    // Puntos a dibujar
    _path.lineTo(0, (size.height + scaleMin) * 0.85);

    _path.quadraticBezierTo(
      (size.width + scaleMin) * 0.8, (size.height + scaleMin) + 25,
      (size.width + scaleMin) * 0.8 , (size.height + scaleMin) * 0.6 
    );
    
    _path.quadraticBezierTo(
      (size.width + scaleMin) * 0.8, (size.height + scaleMin) * 0.4, 
      size.width, (size.height + scaleY2) * 0.32
    );
    
    _path.lineTo(size.width, 0);
    
    return _path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Configuración del lapiz/pincel
    final paint = Paint()
      ..strokeWidth = 1
      ..color = (color == null) ? Colors.transparent : color!
      ..style = PaintingStyle.fill;

    // Lugar donde se va ha dibujar
    canvas.drawPath(getPath(size), paint);
  } 
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}