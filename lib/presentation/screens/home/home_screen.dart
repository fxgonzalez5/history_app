import 'package:flutter/material.dart';
import 'package:history_app/config/menu/menu_items.dart';
import 'package:history_app/config/theme/responsive.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    // final String svgIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"><path fill="currentColor" d="M9 2a4 4 0 1 0 0 8a4 4 0 0 0 0-8Zm-4.991 9A2.001 2.001 0 0 0 2 13c0 1.691.833 2.966 2.135 3.797C5.417 17.614 7.145 18 9 18c.41 0 .816-.019 1.21-.057A5.477 5.477 0 0 1 9 14.5c0-1.33.472-2.55 1.257-3.5H4.01ZM14.5 19a4.5 4.5 0 1 0 0-9a4.5 4.5 0 0 0 0 9Zm-.896-6.396l-.897.896h1.543A2.75 2.75 0 0 1 17 16.25v.25a.5.5 0 0 1-1 0v-.25a1.75 1.75 0 0 0-1.75-1.75h-1.543l.897.896a.5.5 0 0 1-.708.708l-1.752-1.753a.499.499 0 0 1 .002-.705l1.75-1.75a.5.5 0 0 1 .708.708Z"/></svg>';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            color: colors.secondary,
            iconSize: responsive.ip(4),
            onPressed: () {
              // TODO: Implementar el cierre se sesión
            },
          )
        ],
      ),
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

    return Center(
      child: Column(
        children: [
          SizedBox(height: responsive.hp(2.5)),
          Text('UTPL en la historia', style: texts.headlineMedium,),

          Padding(
            padding: EdgeInsets.symmetric(vertical: responsive.ip(3), horizontal: responsive.ip(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tus puntos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.secondary)),
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(responsive.ip(1)),
                  minHeight: responsive.ip(1.5),
                  backgroundColor: colors.primary.withOpacity(0.2),
                  color: colors.secondary,
                  value: 0.3,
                ),
              ],
            ),
          ),
          
          Divider(
            height: 10,
            thickness: 2,
            indent: responsive.ip(3),
            endIndent: responsive.ip(3),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              itemBuilder: (context, index) {
                final menuItem = appMenuItems[index];

                return _ListItem(
                  image: menuItem.image,
                  title: menuItem.title,
                  subTitle: menuItem.subTitle,
                  linkText: menuItem.linkText ,
                  link: menuItem.link,
                  color: colors.primary,
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
          )
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String? linkText;
  final String? link;
  final Color? color;
  final String route;
  final VoidCallback? onTap;

  const _ListItem({
    required this.image,
    required this.title,
    required this.subTitle,
    this.linkText,
    this.link,
    this.color,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    Future<void> openUrl(String link) async {
      final Uri url = Uri.parse(link);

      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: responsive.hp(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image, width: responsive.wp(30), height: responsive.hp(10),),
      
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: texts.titleLarge,),
                SizedBox(
                  width: responsive.wp(60),
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: responsive.ip(1.5),
                      color: Colors.grey,
                    ),
                  ),
                ),
      
                if (linkText != null)
                  InkWell(
                    child: Text(
                      linkText!,
                      style: TextStyle(
                        fontSize: responsive.ip(1.5),
                        color: color,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: color,
                        decorationThickness: 2,
                      ),
                    ),
                    onTap: () => openUrl(link!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}