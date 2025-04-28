import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PantallasMenu extends StatelessWidget {
  const PantallasMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white), // Para textos de botones
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}




class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

 @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width; // obtenemos el ancho de la pantalla

  return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/fondo3.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Container(
              height: 38,
              margin: EdgeInsets.only(left: 20, top: 32, right: 20, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // cambiamos a even spacing
                children: [
                  Image.asset('assets/images/icono1.png', width: screenWidth * 0.2),
                  Text(
                  'Minecraft Skins',
                  style: TextStyle(
                    fontSize: 34, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white, 
                  ),
                ),
                  Image.asset('assets/images/ssa.png', width: screenWidth * 0.2),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 100),
                  itemBuilder: (context, index) {
                    final juice = juiceList[index];
                    return JuiceWidget(
                      juice,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => JuiceDetailsPage(juice)),
                        );
                      },
                    );
                  },
                  itemCount: juiceList.length,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            child: Container(
              color: Colors.white.withOpacity(0.2),
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // cambiamos también aquí
                  children: [
                    Image.asset('assets/images/casa.png', width: screenWidth * 0.1),
                    Image.asset('assets/images/emoji.png', width: screenWidth * 0.1),
                    Image.asset('assets/images/corazon.png', width: screenWidth * 0.1),
                    Image.asset('assets/images/user.png', width: screenWidth * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}

class MyButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const MyButton({
    super.key,
    required this.text,
    this.bgColor = Colors.white,
    this.textColor = const Color.fromARGB(255, 17, 17, 17),
  });

  @override
Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      backgroundColor: bgColor,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    ),
  );
}

}

final juiceList = [
  JuiceEntity(
    name: 'Skin Alex',
    image: 'assets/images/skin1.png',
    fullImage: 'assets/images/skin1.png',
    price: '159.99',
    backgroundImage: 'assets/images/bg1.jpg',
    color: Color.fromARGB(234, 0, 0, 0), 
  ),
  JuiceEntity(
    name: 'Greseilla Skin +',
    image: 'assets/images/skin5.png',
    fullImage: 'assets/images/skin5.png',
    price: '235.99',
    backgroundImage: 'assets/images/bg2.jpeg',
    color: Color.fromARGB(234, 1, 3, 29),
  ),
  JuiceEntity(
    name: 'Humanoid Blank',
    image: 'assets/images/skin2.png',
    fullImage: 'assets/images/skin2.png',
    price: '319.99',
    backgroundImage: 'assets/images/bg3.jpg',
    color: Color.fromARGB(234, 30, 1, 37),
  ),
  JuiceEntity(
    name: 'Ultra Skin Alex',
    image: 'assets/images/skin3.png',
    fullImage: 'assets/images/skin3.png',
    price: '345.99',
    backgroundImage: 'assets/images/bg4.jpg',
    color: Color.fromARGB(234, 31, 1, 1),
  ),
];


class JuiceEntity {
  final String name;
  final String image;
  final String fullImage;
  final String price;
  final String backgroundImage; 
  final Color color;

 JuiceEntity({
  required this.name,
  required this.image,
  required this.fullImage,
  required this.price,
  required this.backgroundImage,
  required this.color, 
});

}


class JuiceWidget extends StatelessWidget {
  final JuiceEntity juice;
  final VoidCallback? onTap;

  const JuiceWidget(this.juice, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    return AspectRatio(
      aspectRatio: 1.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = constraints.maxHeight * 0.2;
          final leftPadding = constraints.maxWidth * 0.1;
          final imageWidth = constraints.maxWidth * 0.35;
          return GestureDetector(
            onTap: onTap,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: topPadding),
                  decoration: BoxDecoration(color: juice.color, borderRadius: BorderRadius.circular(24)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: topPadding,
                          left: leftPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              juice.name,
                              style: textStyle.copyWith(fontSize: 24),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$',
                                    style: textStyle.copyWith(fontSize: 19),
                                  ),
                                  TextSpan(
                                    text: juice.price,
                                    style: textStyle.copyWith(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35,
                              width: 150,
                              child: MyButton(
                                text: 'Adquirir Skin',
                                textColor: juice.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: imageWidth,
                      child: Image.asset(juice.image),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class JuiceDetailsPage extends StatefulWidget {
  final JuiceEntity juice;

  const JuiceDetailsPage(this.juice, {super.key});

  @override
  _JuiceDetailsPageState createState() => _JuiceDetailsPageState();
}

class SimpleRatingBar extends StatelessWidget {
  const SimpleRatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: Color.fromARGB(176, 8, 7, 1),
          size: 18,
        ),
      ),
    );
  }
}

final List<String> reviewImages = [
  'assets/images/review.jpg',
  'assets/images/review2.jpg',
  'assets/images/review3.jpg',
  'assets/images/review5.jpeg',
];

final addImageUrl = 'assets/images/nueva.png';


class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) => SizedBox(width: 18),
        itemBuilder: (_, index) {
          if (index == reviewImages.length) {
            return Image.asset(addImageUrl);
          }
           
          return  Image.asset(reviewImages[index]);
        },
        itemCount: reviewImages.length + 1,
      ),
    );
  }
}

class _JuiceDetailsPageState extends State<JuiceDetailsPage> {
  var count = 0;
  double bottomSectionHeight = 100;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Fondo de pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo5.jpg', 
              fit: BoxFit.cover, 
            ),
          ),
          ListView(
            padding: EdgeInsets.only(bottom: bottomSectionHeight),
            children: [
              AspectRatio(
                aspectRatio: 0.86,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final imageHeight = constraints.maxHeight * 0.7;
                    final imageHorizontalMargin = constraints.maxWidth * 0.15;
                    final imageBottomMargin = constraints.maxHeight * 0.07;
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.juice.color,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: imageHorizontalMargin,
                                right: imageHorizontalMargin,
                                bottom: imageBottomMargin,
                              ),
                              child: Image.asset(
                                'assets/images/skin3.png',
                                height: imageHeight,
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 26),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CounterWidget(
                            currentCount: count,
                            color: widget.juice.color,
                            onIncreaseClicked: () {
                              setState(() {
                                count++;
                              });
                            },
                            onDecreaseClicked: () {
                              setState(() {
                                count--;
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Centramos el título
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Características del skin:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SimpleRatingBar()
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      '¡Haz que tu personaje se vea increíble en cada aventura con este exclusivo skin diseñado especialmente para ti! Con detalles únicos, colores vibrantes y un estilo totalmente único, este skin te permitirá destacar entre otros jugadores.',
                      style: TextStyle(color: Color(0xFFB0B1B4), fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reseñas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Ver mas',
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 9, 109),
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    ReviewsList(),
                  ],
                ),
              )
            ],
          ),
          // Header: Centrado
          Container(
            color: widget.juice.color,
            padding: EdgeInsets.only(left: 24, right: 24, top: 26, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Image.asset(
                    'assets/images/atras.png',
                    width: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Ultra Skin',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  'assets/images/corazon.png',
                  width: 32,
                )
              ],
            ),
          ),
          // Parte inferior: Centrado
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomSectionHeight,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '\$',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '425.99',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.3, // Ajustamos el tamaño del botón al ancho
                    height: 48,
                    child: MyButton(
                      text: 'Compra Ahora',
                      bgColor: widget.juice.color,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class CounterWidget extends StatelessWidget {
  final int currentCount;
  final Color color;
  final VoidCallback? onIncreaseClicked;
  final VoidCallback? onDecreaseClicked;
  final textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);

  CounterWidget({super.key, 
    required this.currentCount,
    required this.color,
    this.onIncreaseClicked,
    this.onDecreaseClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16),
          GestureDetector(onTap: onDecreaseClicked, child: Icon(Icons.remove, color: Colors.white)),
          SizedBox(width: 10),
          SizedBox(
            width: 30,
            child: Text(
              currentCount.toString(),
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(onTap: onIncreaseClicked, child: Icon(Icons.add, color: Colors.white)),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}