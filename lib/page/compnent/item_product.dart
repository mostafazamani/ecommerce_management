import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/page/compnent/product_dialog.dart';
import 'package:ecommerce_management/server/product_server.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product, required this.state});
  final ProductModel product;
  final Function state;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void refresh() {
    setState(() {
      widget.state();
    });
  }

  @override
  Widget build(BuildContext context) {
    String available = "";
    Uint8List bytes = base64.decode(widget.product.image);
    if (widget.product.available == 1) {
      available = "available";
    } else {
      available = "not available";
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(179, 251, 109, 0),
                    borderRadius: BorderRadius.circular(20)),
                width: 142,
                height: 133,
                padding: const EdgeInsets.all(10),
                child: Image.memory(
                  bytes,
                  width: 99,
                  height: 132,
                  fit: BoxFit.fill,
                ),
              ),
              IconButton(
                  onPressed: () {
                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: const Duration(milliseconds: 400),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return EditDialog(state: refresh, p: widget.product);
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.edit_document,
                    color: Color.fromARGB(255, 251, 109, 0),
                  )),
              IconButton(
                  onPressed: () async {
                    bool d = await ProductServer.deleteProduct(widget.product);
                    if (d) {
                      Fluttertoast.showToast(
                          msg: "Item deleted",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      widget.state();
                    } else {
                      Fluttertoast.showToast(
                          msg: "please try again",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Color.fromARGB(255, 251, 109, 0),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.product.name),
              Text(widget.product.price + "\$"),
              Text(available),
            ],
          ),
          Expanded(
            child: Text(
              widget.product.details,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
