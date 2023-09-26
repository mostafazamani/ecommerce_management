import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/page/compnent/item_product.dart';
import 'package:ecommerce_management/page/compnent/product_dialog.dart';
import 'package:ecommerce_management/server/product_server.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  void refresh() {
    setState(() {});
  }

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
                        "Product list",
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
                  future: ProductServer.getProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 251, 88, 0)));
                    } else if (snapshot.hasData) {
                      List<ProductModel> list =
                          snapshot.data as List<ProductModel>;

                      if (list.isNotEmpty) {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 1.8,
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 1.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ProductItem(
                                    product: list[index], state: refresh),
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showGeneralDialog(
                barrierLabel: "Label",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: const Duration(milliseconds: 400),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return AddDialog(
                    state: refresh,
                  );
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                        .animate(anim1),
                    child: child,
                  );
                },
              );
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
