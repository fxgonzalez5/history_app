import 'package:flutter/material.dart';
import 'package:history_app/config/theme/responsive.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: responsive.hp(5),),
            SizedBox(
              width: responsive.wp(50),
              child: Text(
                'Escanea el código QR de tu hallazgo',
                style: TextStyle(
                  fontSize: responsive.ip(1.6),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
     ),
   );
  }
}