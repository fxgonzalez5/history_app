import 'package:flutter/material.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/widgets/widgets.dart';


class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomSliverAppBar(),

          SliverToBoxAdapter(
            child: Container(
              height: responsive.hp(60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(responsive.ip(3)),
                  topRight: Radius.circular(responsive.ip(3))
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2,
                  )
                ]
              ),
              child: const _BoxContent(),
            ),  
          ),
        ],
      )
    );
  }
}

class _BoxContent extends StatelessWidget {
  const _BoxContent();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.ip(1), horizontal: responsive.ip(3)),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedLine(
            width: responsive.wp(20),
            height: responsive.ip(0.25),
            color: Colors.grey[300]
          ),
          const _Heading(),
          const Divider(
            height: 10,
            thickness: 2,
            color: Colors.black12,
          ),
          SizedBox(height: responsive.ip(1.5),),
          Text('Descripción', style: texts.titleSmall,),
          SizedBox(height: responsive.ip(1.5),),
          Text('El 3 de mayo José María Velasco Ibarra, filósofo de virtudes extraordinarias y entonces presidente de la república, en Decreto Ejecutivo Nro. 646, faculta la creación de la UTPL.', style: texts.bodyLarge, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: responsive.ip(2)),
        child: SizedBox(
          width: responsive.wp(75),
          child: Column(
            children: [
              Text('Aprobación del Decreto de Creación de UTPL', style: TextStyle(fontSize: responsive.ip(2), height: 1.25), textAlign: TextAlign.center,),
              Text('Año: 1971', style: texts.titleSmall,),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SliverAppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        )
      ],
      backgroundColor: Colors.transparent,
      expandedHeight: responsive.hp(80),
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(responsive.ip(1)),
            child: Image.network(
              'https://picsum.photos/500/500',
              width: responsive.wp(70),
              height: responsive.hp(50),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}