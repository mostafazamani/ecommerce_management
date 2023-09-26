import 'package:ecommerce_management/model/cart_list_model.dart';
import 'package:ecommerce_management/page/cartlist_details_page.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatefulWidget {
  const CartListItem({super.key, required this.cartListModel});
  final CartListModel cartListModel;

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CartDetails(cartListModel: widget.cartListModel);
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("#${widget.cartListModel.id}",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.cartListModel.email,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 251, 109, 0),
                        fontWeight: FontWeight.bold)),
                Text("${widget.cartListModel.total} \$",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 251, 109, 0),
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
