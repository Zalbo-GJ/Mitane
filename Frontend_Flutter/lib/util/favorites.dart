import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fav extends StatelessWidget {
  const Fav({
    super.key,
    required this.image,
    required this.title,
    required this.press,
  });

  final String image, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Image.network(image),
          ),
          Text(
            "$title",
            style:
                GoogleFonts.lato(color: const Color.fromARGB(255, 41, 91, 132)),
          )
        ],
      ),
    );
  }
}
