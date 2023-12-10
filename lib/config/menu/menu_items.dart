class MenuItem {
  final String image;
  final String title;
  final String subTitle;
  final String? linkText;
  final String? link;
  final String route;

  const MenuItem({
    required this.image,
    required this.title,
    required this.subTitle,
    this.linkText,
    this.link,
    required this.route
  });

}

const List<MenuItem> appMenuItems = [
  MenuItem(
    image: 'assets/images/qr.png',
    title: 'Escanea la historia',
    subTitle: 'Escanea el código QR aquí',
    route: '/qr'
  ),
  MenuItem(
    image: 'assets/images/gallery.png',
    title: 'Tus hallazgos',
    subTitle: 'Galería de tus hallazgos',
    route: '/gallery'
  ),
  MenuItem(
    image: 'assets/images/logo_utpl.png',
    title: 'Historia UTPL',
    subTitle: 'Ingresa a la base de datos de la historia UTPL',
    linkText: 'conoce mas +',
    link: 'https://www.utpl.edu.ec/historia',
    route: ''
  ),


];