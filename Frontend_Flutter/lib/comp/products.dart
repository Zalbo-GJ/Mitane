import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 200,
        height: 280,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                image,
                height: 200,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 41, 91, 132)),
                ),
                Chip(
                  label: Text(
                    price.toString() + " Birr/KG",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                  // labelPadding: EdgeInsets.all(2),
                  backgroundColor: Color.fromARGB(255, 43, 171, 230),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
