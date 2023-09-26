import 'dart:convert';

import 'package:ecommerce_management/model/cart_list_model.dart';
import 'package:ecommerce_management/model/user_model.dart';
import 'package:ecommerce_management/page/compnent/item_cart_list_details.dart';
import 'package:ecommerce_management/server/user_server.dart';
import 'package:flutter/material.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({super.key, required this.cartListModel});
  final CartListModel cartListModel;

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<String> list = getItems();
    List<String> listnum = getnum();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 251, 88, 0)));
                        } else if (snapshot.hasData) {
                          UserModel user = snapshot.data as UserModel;

                          return Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 40),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Name :",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        179, 251, 109, 0)),
                                              ),
                                              Text(user.name,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 251, 109, 0),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Email :",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          179, 251, 109, 0))),
                                              Text(user.email,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 251, 109, 0),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Address :",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          179, 251, 109, 0))),
                                              Text(user.address,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 251, 109, 0),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Number :",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          179, 251, 109, 0))),
                                              Text(user.number,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 251, 109, 0),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ));
                        } else {
                          return Center(
                              child: Image.asset('assets/image/wish.png'));
                        }
                      },
                      future: UserServer.getuserwithemail(
                          widget.cartListModel.email),
                    ),
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: size.width * (2 / 3),
                    height: 4,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(179, 193, 111, 48),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ItemDetails(
                              itemid: list[index], num: listnum[index]),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }

  List<String> getItems() {
    List<dynamic> list = json.decode(widget.cartListModel.item);
    List<String> l = [];

    for (var i = 0; i < list.length; i++) {
      l.add(list[i].toString());
    }
    return l;
  }

  List<String> getnum() {
    List<dynamic> list = json.decode(widget.cartListModel.num);
    List<String> l = [];

    for (var i = 0; i < list.length; i++) {
      l.add(list[i].toString());
    }
    return l;
  }
}
