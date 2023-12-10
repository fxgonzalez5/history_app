import 'package:flutter/material.dart';

import 'package:history_app/config/menu/menu_items.dart';
import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: const _HomeView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors.primary,
        iconSize: responsive.ip(3),
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            label: 'Mi Galería'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Información'
          ),
        ],
        onTap: (int index) {
          // TODO: Implementar la navegación entre pantallas
        },
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.exit_to_app_rounded),
              iconSize: responsive.ip(3.5),
              color: colors.secondary,
              onPressed: (){
                // TODO: Implementar el cierre de seisión
              },
            ),
          ),

          Column(
            children: [
              SizedBox(height: responsive.hp(5)),
              Text('UTPL en la historia', style: texts.headlineMedium,),
              CustomProgress(
                padding: EdgeInsets.symmetric(vertical: responsive.ip(3), horizontal: responsive.ip(5)),
                textColor: colors.secondary,
                backgroundColor: colors.primary.withOpacity(0.2),
                foregroundColor: colors.secondary,
                valueProgress: 0.3
              ),
              Divider(
                height: 10,
                thickness: 2,
                indent: responsive.ip(3),
                endIndent: responsive.ip(3),
              ),
              const _MenuOptions(),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuOptions extends StatelessWidget {
  const _MenuOptions();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          final menuItem = appMenuItems[index];
    
          return ListItem(
            label: Image.asset(menuItem.image, width: responsive.wp(35), height: responsive.hp(13),),
            title: menuItem.title,
            subTitle: Text(
              menuItem.subTitle,
              style: TextStyle(
                fontSize: responsive.ip(1.5),
                color: Colors.grey,
              ),
            ),
            linkText: menuItem.linkText ,
            link: menuItem.link,
            linkStyle: TextStyle(
              fontSize: responsive.ip(1.5),
              color: colors.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: colors.primary,
              decorationThickness: 2,
            ),
            route: menuItem.route,
            onTap: () {
              // TODO: Implementar la navegación entre pantallas
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 10,
          thickness: 2,
          indent: responsive.ip(3),
          endIndent: responsive.ip(3),
        ),
      ),
    );
  }
}