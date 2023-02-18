import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homePage.dart';

class Pending extends StatelessWidget {
  Pending({super.key});
  var cart = FlutterCart();
  void pressed(context, index) {
    cart.deleteItemFromCart(index);
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => Pending())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Center(
          child: Text(
            "Cart",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cart.cartItem.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: ((context) => pressed(context, index)),
                      icon: Icons.fire_extinguisher,
                      backgroundColor: Colors.red.shade400,
                    ),
                  ],
                ),
                child: Cont(cart: cart, index: index),
              ));
        },
      ),
      bottomSheet: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            // height: 100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount - ${cart.getTotalAmount()}',
                    style: GoogleFonts.lato(fontSize: 23)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Payment()));
                    },
                    child: const Text(
                      "Check Out",
                      style: TextStyle(fontSize: 25),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cont extends StatelessWidget {
  const Cont({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);

  final FlutterCart cart;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 238, 238, 238),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 167, 167, 167),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${cart.cartItem[index].productName}',
            style: GoogleFonts.lato(fontSize: 25),
          ),
          Text(
            '${cart.cartItem[index].unitPrice} Birr/KG',
            style: GoogleFonts.lato(fontSize: 15),
          ),
          Chip(
            label: Text('${cart.cartItem[index].quantity} X'),
          ),
        ],
      ),
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Payment')),
    );
  }
}
