import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homePage.dart';

class Details extends StatefulWidget {
  const Details(
      {super.key,
      required this.title,
      required this.img,
      required this.price,
      required this.id});
  final String title, img;
  final int id, price;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var count = 1;

  var cart = FlutterCart();

  void pressed() {
    cart.addToCart(
        productId: widget.id,
        unitPrice: widget.price,
        productName: widget.title,
        quantity: count);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: AlignmentDirectional.topStart,
            margin: EdgeInsets.only(top: 40, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 40,
                color: Colors.black,
              ),
            ),
          ),
          Image.network(
            widget.img,
            width: 400,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: 450,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 215, 203, 198),
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w300)),
                      ),
                      Text(
                        widget.price.toString() + " Birr/KG",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    width: 170,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              count--;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 36,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                          child: Text(
                            '${count}',
                            style: TextStyle(color: Colors.black, fontSize: 36),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              count++;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 36,
                            )),
                      ],
                    ),
                  ),
                ]),
          )
        ],
      ),

      floatingActionButton: ElevatedButton(
        child: const Text("ADD TO CART"),
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(165, 65),
          backgroundColor: Colors.red,
          // onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // ElevatedButton(onPressed: pressed, child: const Icon(Icons.add)),
    );
  }
}
