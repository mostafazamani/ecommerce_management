import 'package:ecommerce_management/model/category_model.dart';
import 'package:ecommerce_management/server/catefory_server.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.state, required this.category});
  final Function state;
  final CategoryModel category;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.category.catname,
                style: const TextStyle(
                    color: Color.fromARGB(255, 251, 109, 0),
                    fontWeight: FontWeight.bold)),
          ),
          widget.category.catname == "All"
              ? SizedBox()
              : IconButton(
                  onPressed: () async {
                    bool del =
                        await CategoryServer.deleteCategory(widget.category);
                    if (del) {
                      Fluttertoast.showToast(
                          msg: "Item Deleted",
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
                  ),
                )
        ],
      ),
    );
  }
}
