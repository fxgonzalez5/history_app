import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/domain/services/firestore_service.dart';
import 'package:history_app/infraestructure/models/hito_model.dart';
import 'package:history_app/presentation/widgets/widgets.dart';

part 'gallery_controller.dart';
part 'gallery_binding.dart';

class GalleryScreen extends GetView<GalleryController> {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            _Head(controller.hitos.length, controller.totalHitos),
            Container(height: responsive.hp(1.3)),
            if (controller.isVisibility)
              if (controller.hitos.isEmpty)
                const Expanded(child: Center(child: Text('Escanea los QR y revela la historia')),)
              else
                _GalleryView(controller.hitos)
            else
              const _AchievementView()
          ],
        ),
      ),
    );
  }
}

class _GalleryView extends StatelessWidget {
  final List<HitosModel> hitos; 

  const _GalleryView(this.hitos);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: hitos.length,
        itemBuilder: (context, index) {
          final hito = hitos[index];

          return ListItem(
            label: SizedBox(
              width: responsive.wp(35),
              child: Center(
                child: Image.network(
                  hito.image,
                  width: responsive.wp(20),
                  height: responsive.hp(12.5),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: hito.title,
            subTitle: Row(
              children: [
                Text('Año: ', style: TextStyle(fontSize: responsive.ip(1.4), color: Colors.grey)),
                Text('${hito.date}', style: TextStyle(fontSize: responsive.ip(1.4), fontWeight: FontWeight.w500)),
              ],
            ),
            linkText: 'Ver más',
            linkStyle: TextStyle(
              fontSize: responsive.ip(1.5),
              color: colors.secondary,
            ),
            onTap: () => Get.toNamed('/information', arguments: hito),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class _AchievementView extends StatelessWidget {
  const _AchievementView();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return FadeOut(
      delay: const Duration(seconds: 5),
      animate: true,
      child: Column(
        children: [
          SizedBox(
            height: responsive.hp(3.5),
          ),
          Text(
            '¡Felicidades!',
            style: texts.headlineLarge,
          ),
          SizedBox(
            height: responsive.hp(1),
          ),
          Text(
            'Encontraste',
            style: texts.titleLarge,
          ),
          SizedBox(
            height: responsive.hp(1),
          ),
          const _CustomCard()
        ],
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;
    final hito = Get.find<GalleryController>().newHito;

    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      child: SizedBox(
        width: responsive.wp(80),
        child: Padding(
          padding: EdgeInsets.all(responsive.wp(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CustomImage(hito!.image),
              SizedBox(height: responsive.ip(2)),
              Text(
                hito.title,
                style: texts.headlineSmall,
              ),
              Row(
                children: [
                  TextButton(
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: responsive.ip(1))),
                          minimumSize:
                              const MaterialStatePropertyAll(Size.zero),
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent)),
                      onPressed: () => Get.toNamed('/information', arguments: hito),
                      child: Text('Ver más...',
                          style: TextStyle(
                              fontSize: responsive.ip(1.35),
                              color: colors.secondary))),
                  const Spacer(),
                  Text('Ganaste 10 pts.',
                      style: TextStyle(
                          fontSize: responsive.ip(1.35),
                          color: Colors.black54)),
                  Icon(
                    Icons.star_rounded,
                    color: colors.secondary,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomImage extends StatelessWidget {
  final String image;

  const _CustomImage(this.image);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsive.ip(1)),
        child: Image.network(
          image,
          width: responsive.wp(48),
          height: responsive.hp(28),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  final int found;
  final int total;

  const _Head(this.found, this.total);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return CustomFigure(
      color: colors.primary,
      scale: 2,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: responsive.ip(2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _UserInformation(),
              SizedBox(
                height: responsive.ip(2),
              ),
              CustomProgress(
                textColor: colors.secondary,
                backgroundColor: Colors.white,
                foregroundColor: colors.secondary,
                valueProgress: found / total,
              ),
              Text('$found de $total', style: TextStyle(fontSize: responsive.ip(1.3), fontWeight: FontWeight.w500, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(responsive.ip(0.75)),
          width: responsive.wp(18),
          height: responsive.wp(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.secondary, width: 2),
            image: const DecorationImage(
              image: NetworkImage(
                'https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.webp'
              ),
            ),
          ),
        ),
        SizedBox(
          width: responsive.ip(1),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre Apellido',
              style: TextStyle(
                  fontSize: responsive.ip(1.6),
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text(
              'Estudiante',
              style: TextStyle(
                  fontSize: responsive.ip(1.3),
                  fontWeight: FontWeight.w500,
                  color: Colors.white70),
            ),
          ],
        )
      ],
    );
  }
}
