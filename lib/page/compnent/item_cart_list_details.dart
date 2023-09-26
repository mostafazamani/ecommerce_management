import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/server/cart_list_server.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.itemid, required this.num});
  final String itemid;
  final String num;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: FutureBuilder(
          future: CartServer.itemdetails(widget.itemid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 251, 88, 0)));
            } else if (snapshot.hasData) {
              ProductModel p = snapshot.data as ProductModel;
              Uint8List bytes = base64.decode(p.image);

              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(179, 251, 109, 0),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Image.memory(
                      bytes,
                      width: 99,
                      height: 132,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.num} pieces",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            p.price + "\$",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Image.asset('assets/image/profile.png'));
            }
          },
        ));
  }
}
