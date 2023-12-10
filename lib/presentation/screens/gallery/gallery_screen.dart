import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/widgets/widgets.dart';


class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isVisibility = true;

    return Scaffold(
      body: Column(
        children: [
          const _Head(),
          if (isVisibility)
            const _GalleryView()
          else
            const _AchievementView()
        ],
      ),
   );
  }
}

class _GalleryView extends StatelessWidget {
  const _GalleryView();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: ListView.separated(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListItem(
            label: SizedBox(
              width: responsive.wp(35),
              child: Image.network('https://placeholder.com/160x200', width: responsive.wp(22), height: responsive.hp(13),),
            ),
            title: 'Aprobación del Decreto de Creación de UTPL',
            subTitle: Row(
              children: [
                Text('Año: ', style: TextStyle(fontSize: responsive.ip(1.4), color: Colors.grey),),
                Text('1971', style: TextStyle(fontSize: responsive.ip(1.4), fontWeight: FontWeight.w500),),
              ],
            ),
            linkText: 'Ver más',
            linkStyle: TextStyle(
              fontSize: responsive.ip(1.5),
              color: colors.secondary,
            ),
            route: '/detail',
            onTap: () {
              // TODO: Implementar la navegación a la pantalla de información del registro
            },
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
          SizedBox(height: responsive.hp(3.5),),
          Text('¡Felicidades!', style: texts.headlineLarge,),
          SizedBox(height: responsive.hp(1),),
          Text('Encontraste', style: texts.titleLarge,),
          SizedBox(height: responsive.hp(1),),
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
              const _CustomImage(),
              SizedBox(height: responsive.ip(2)),
              Text('Aprobación del Decreto de Creación de UTPL', style: texts.headlineSmall,),
              SizedBox(height: responsive.ip(2)),
              Row(
                children: [
                  Text('Ver más...', style: TextStyle(fontSize: responsive.ip(1.35), color: Colors.black54)),
                  const Spacer(),
                  Text('Ganaste 10 pts.', style: TextStyle(fontSize: responsive.ip(1.35), color: Colors.black54)),
                  Icon(Icons.star_rounded, color: colors.secondary,)
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
  const _CustomImage();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsive.ip(1)),
        child: Image.network(
          'https://picsum.photos/500/500',
          width: responsive.wp(50),
          height: responsive.hp(32.5),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  const _Head();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return CustomFigure(
      color: colors.primary,
      scale: 2,
      child: Padding(
        padding: EdgeInsets.only(left: responsive.ip(2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _UserInformation(),
            SizedBox(height: responsive.ip(2),),
            CustomProgress(
              textColor: colors.secondary,
              backgroundColor: Colors.white,
              foregroundColor: colors.secondary,
              valueProgress: 0.3
            ),
          ],
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.secondary,
              width: 2
            )
          ),
          child: Icon(
            Icons.person,
            size: responsive.ip(5),
            color: colors.secondary,
          ),
        ),
        SizedBox(width: responsive.ip(1),),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre Apellido', style: TextStyle(fontSize: responsive.ip(1.6), fontWeight: FontWeight.w500, color: Colors.white),),
            Text('Estudiante', style: TextStyle(fontSize: responsive.ip(1.3), fontWeight: FontWeight.w500, color: Colors.white70),),
          ],
        )
      ],
    );
  }
}