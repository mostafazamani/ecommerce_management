import 'package:ecommerce_management/model/cart_list_model.dart';
import 'package:ecommerce_management/page/compnent/item_cart_list.dart';
import 'package:ecommerce_management/server/cart_list_server.dart';
import 'package:flutter/material.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({super.key});

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(31, 131, 128, 128),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Cart list",
                        style: TextStyle(
                          color: Color.fromARGB(179, 251, 109, 0),
                          fontSize: 25,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                child: FutureBuilder(
                  future: CartServer.getCartList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 251, 88, 0)));
                    } else if (snapshot.hasData) {
                      List<CartListModel> list =
                          snapshot.data as List<CartListModel>;

                      if (list.isNotEmpty) {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.8,
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 1.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CartListItem(cartListModel: list[index]),
                              );
                            });
                      } else {
                        return Center(
                            child: Image.asset('assets/image/wish.png'));
                      }
                    } else {
                      return Center(
                          child: Image.asset('assets/image/wish.png'));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
