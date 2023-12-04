import 'package:flutter/material.dart';
import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/widgets/custom_text_form_field.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: responsive.hp(100),
          child: Column(
            children: [
              const _ImageHead(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const _TextSection(),
                    const _FormContainer(),
                    SizedBox(height: responsive.hp(3),)
                  ],
                ),
              ),
            ],
          ),
        ),
      )
   );
  }
}

class _ImageHead extends StatelessWidget {
  const _ImageHead();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: responsive.hp(30),
          child: CustomPaint(
            painter: _CustomFigure(
              color: colors.secondary,
              scale: 2
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: responsive.hp(30),
          child: CustomPaint(
            painter: _CustomFigure(
              color: colors.primary,
              scale: 1
            ),
          ),
        ),
        ClipPath(
          clipper: _CustomFigureClipper(),
          child: SizedBox(
            width: double.infinity,
            height: responsive.hp(30),
            child: CustomPaint(
              foregroundPainter: _CustomFigure(color: colors.primary.withOpacity(0.5)),
              child: Image.asset('assets/images/campus_utpl.png', fit: BoxFit.cover,)
            ),
          )
        )
      ],
    );
  }
}

class _CustomFigure extends CustomPainter {
  // Definición del lienzo
  final _path = Path();
  final Color? color;
  final double scale;

  _CustomFigure({
    this.color, this.scale = 0.0
  }): assert( scale >= 0, 'The minimum scaling value is 0' ),  
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

class _CustomFigureClipper extends CustomClipper<Path> {
  _CustomFigure customFigure;

  _CustomFigureClipper(): customFigure = _CustomFigure();

  @override
  Path getClip(Size size) {
    return customFigure.getPath(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false; 
}

class _TextSection extends StatelessWidget {
  const _TextSection();

  @override
  Widget build(BuildContext context) {
    final texts = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'UTPL en la historia',
          style: texts.headlineMedium,
        ),
        Text(
          'Inicia sesión con tu correo institucional',
          style: texts.titleMedium,
        ),
      ],
    );
  }
}

class _FormContainer extends StatelessWidget {
  const _FormContainer();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.ip(5)),
      child: Form(
          // TODO: crear la llave del formulario
          // key: _formKey,
          child: Column(
            children: [
              const CustomTextFormField(
                label: 'Correo',
                hint: 'usuario@utpl.edu.ec'
              ),
              const SizedBox(height: 30,),
              const CustomTextFormField(
                label: 'Contraseña',
                hint: '********',
                noVisibility: true,
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Olvidaste tu contraseña?'),
                  onPressed: () {
                    // TODO: Navegar a la pantalla para restablecer la contraseña
                  },
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: responsive.ip(1), horizontal: responsive.ip(3))),
                ),
                child: const Text('Iniciar Sesión'),
                onPressed: () {
                  // TODO: Validate returns true if the form is valid, or false otherwise.
                  // if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                      // const SnackBar(content: Text('Processing Data')),
                    // );
                  // }
                },
              ),
            ],
          ),
        ),
    );
  }
}