// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:http/http.dart' as http;
import 'package:mitane/comp/login.dart';
import 'package:mitane/util/favorites.dart';

import '../util/items.dart';
import 'details.dart';
import 'pending.dart';
import 'products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<Items> items;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    // var url = Uri.parse("http://192.168.208.32:3000/items");
    var url = Uri.parse("http://192.168.208.153:8080/items");

    var res = await http.get(url, headers: {"Accept": "application/json"});
    String resBody = res.body;

    var jsonbd = json.decode(resBody);

    print(jsonbd);

    for (var data in jsonbd) {
      if (data != null) {
        print(data['id'].runtimeType);
        items.add(Items(
          id: int.parse(data['id']),
          img: data?['img'],
          title: data?['title'],
          price: int.parse(data['price']),
        ));
      }
    }

    setState(() {});

    // items = (await Remote().getItems())!;
    // print(items);
  }

  var cart = FlutterCart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 242, 244),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: TextButton(
                child: const Text("Home"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomePage())));
                },
              ),
            ),
            ListTile(
              title: TextButton(
                child: const Text("Add item"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => About())));
                },
              ),
            ),
            Divider(),
            ListTile(
              title: TextButton(
                child: const Text("Sign Out"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.menu),
        // ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 241, 242, 244),
        // foregroundColor: Color.fromARGB(255, 41, 91, 132),
        foregroundColor: Color.fromARGB(255, 5, 147, 213),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Mitane",
              style: TextStyle(fontSize: 20),
            ),
            Badge(
              showBadge: (cart.cartItem.isNotEmpty) ? true : false,
              position: BadgePosition.topStart(start: 17),
              badgeStyle: BadgeStyle(
                badgeColor: Colors.green,
              ),
              badgeAnimation: BadgeAnimation.slide(),
              badgeContent: Text('${cart.cartItem.length}'),
              child: IconButton(
                  padding: const EdgeInsets.only(right: 29),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Pending()));
                  },
                  icon: const Icon(Icons.shopping_cart_checkout_outlined)),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 215, 203, 198),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            children: [
              const SizedBox(height: 29),
              Text(
                "Explore",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 41, 91, 132),
                    ),
              ),
              const Text(
                "Your meal",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 5, 147, 213),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white54,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      items.length,
                      (index) => Fav(
                        image: items[index].img,
                        title: items[index].title,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => Details(
                                  id: items[index].id,
                                  img: items[index].img,
                                  title: items[index].title,
                                  price: items[index].price)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 29),
              Center(
                child: Wrap(
                  children: List.generate(
                    items.length,
                    (index) => ProductCard(
                      image: items[index].img,
                      title: items[index].title,
                      price: items[index].price,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Details(
                                id: items[index].id,
                                img: items[index].img,
                                title: items[index].title,
                                price: items[index].price)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _namecont = TextEditingController();
  final _imgcont = TextEditingController();
  final _titlecont = TextEditingController();
  final _pricecont = TextEditingController();
  final _discont = TextEditingController();

  Future AddItem() async {
    items.add(Items(
        id: 1334,
        price: int.parse(_pricecont.text),
        img: _imgcont.text,
        title: _titlecont.text));

    setState(() {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _namecont.dispose();
    _imgcont.dispose();
    _titlecont.dispose();
    _pricecont.dispose();
    _discont.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: TextField(
                  controller: _titlecont,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _imgcont,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image link',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _pricecont,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _discont,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    AddItem();
                  },
                  child: Text(
                    'Add Item',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
