import 'package:ecommerce_management/server/catefory_server.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Category",
          style: TextStyle(
              color: Color.fromARGB(255, 251, 109, 0),
              fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Category : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: namecontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "name",
                  hintText: "Enter Name"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text("cancel",
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () async {
            if (namecontroller.text.toString() == "") {
              Fluttertoast.showToast(
                  msg: "please fill category name ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            bool add = await CategoryServer.addCategory(
                namecontroller.text.toString());

            if (add) {
              Fluttertoast.showToast(
                  msg: "Item Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              if (mounted) {
                Navigator.pop(context, 'OK');
              }
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
          child: const Text("save",
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
