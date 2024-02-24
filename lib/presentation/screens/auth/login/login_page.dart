import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/services/firebase_auth_service.dart';
import 'package:history_app/presentation/widgets/widgets.dart';

part 'login_controller.dart';
part 'login_binding.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        CustomFigure(
          color: colors.secondary,
          scale: 2,
        ),
        CustomFigure(
          color: colors.primary,
          scale: 1,
        ),
        ClipPath(
          clipper: _CustomFigureClipper(),
          child: CustomFigure(
            backgroundImage: Image.asset('assets/images/campus_utpl.png', fit: BoxFit.cover),
            expand: true,
            child: Container(color: colors.primary.withOpacity(0.5),)
          )
        )
      ],
    );
  }
}

class _CustomFigureClipper extends CustomClipper<Path> {
  Figure figure;

  _CustomFigureClipper(): figure = Figure(null, 0);

  @override
  Path getClip(Size size) {
    return figure.getPath(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false; 
}

class _TextSection extends StatelessWidget {
  const _TextSection();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'UTPL en la historia',
          style: texts.headlineMedium,
        ),
        SizedBox(height: responsive.ip(1),),
        Text(
          'Inicia sesión con tu correo institucional',
          style: texts.titleMedium,
        ),
      ],
    );
  }
}

class _FormContainer extends GetView<LoginController> {
  const _FormContainer();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.ip(5)),
      child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.emailController,
                label: 'Correo',
                hint: 'usuario@utpl.edu.ec',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  String pattern =r'^[\w-\.0-9]+@utpl\.edu\.ec$';
                  RegExp regExp = RegExp(pattern);

                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el correo';
                  } else if (!regExp.hasMatch(value)) {
                    return 'El valor ingresado no tiene el formato adecuado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30,),
              CustomTextFormField(
                controller: controller.passwordController,
                label: 'Contraseña',
                hint: '********',
                noVisibility: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la contraseña';
                  } else if (value.length < 8) {
                    return 'Mínimo 8 caracteres';
                  }
                  return null;
                },
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
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    final firebaseAuthService = FirebaseAuthService();
                    firebaseAuthService.createAccount(controller.emailController.text, controller.passwordController.text)
                      .then((status) {
                        if (status) {
                          Get.offNamed('/navigation');
                        } else {
                          SnackBar snackBar = const SnackBar(
                            content: Text('Usuario o contraseña incorrectos'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    );
                  }
                },
              ),
            ],
          ),
        ),
    );
  }
}