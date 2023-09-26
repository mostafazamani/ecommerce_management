import 'dart:convert';

import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/server/product_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({super.key, required this.state, required this.p});
  final ProductModel p;

  final Function state;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  bool check = true;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController dispricecontroller = TextEditingController();
  TextEditingController discontcontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController availablecontroller = TextEditingController();
  TextEditingController detailscontroller = TextEditingController();

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String base64string = "";

  @override
  void initState() {
    check = widget.p.available == 1 ? true : false;
    base64string = widget.p.image;

    namecontroller.text = widget.p.name;
    pricecontroller.text = widget.p.price;
    dispricecontroller.text = widget.p.disprice;
    discontcontroller.text = widget.p.discont;
    categorycontroller.text = widget.p.category;
    availablecontroller.text =
        widget.p.available == 0 ? " not available" : "available";
    detailscontroller.text = widget.p.details;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edite Information',
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
              child: Text('Name : ',
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('price : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: pricecontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "price",
                  hintText: "Enter product price"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('discount : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: discontcontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "discount",
                  hintText: "Enter the product discount"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('price with discount : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: dispricecontroller,
              obscureText: false, //for password

              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "",
                  hintText: "Enter the price of the product with a discount"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('category : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: categorycontroller,
              obscureText: false, //for password

              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "category",
                  hintText: "Enter product category"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('details : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: detailscontroller,
              obscureText: false, //for password
              maxLines: 4,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "details",
                  hintText: "Enter the price details"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('available : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            Checkbox(
              activeColor: const Color.fromARGB(179, 251, 109, 0),
              value: check,
              onChanged: (value) {
                setState(() {
                  check = value!;
                });
              },
            ),
            Row(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('image : ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 251, 109, 0),
                              fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                      onPressed: () {
                        openImage();
                      },
                      icon: const Icon(
                        Icons.image_search,
                        color: Color.fromARGB(255, 251, 109, 0),
                        size: 30,
                      ),
                    ),
                  ],
                ),
                base64string != ""
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Image.memory(
                          base64.decode(base64string),
                          width: 99,
                          height: 132,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () async {
            if (namecontroller.text.toString() == "" ||
                pricecontroller.text.toString() == "" ||
                categorycontroller.text.toString() == "" ||
                detailscontroller.text.toString() == "") {
              Fluttertoast.showToast(
                  msg: "please fill name , price , category and details filed!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            if (base64string == "") {
              Fluttertoast.showToast(
                  msg: "please select image!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            ProductModel p = ProductModel(
                id: widget.p.id,
                name: namecontroller.text.toString(),
                price: pricecontroller.text.toString(),
                disprice: dispricecontroller.text.toString(),
                discont: discontcontroller.text.toString(),
                category: categorycontroller.text.toString(),
                available: check ? 1 : 0,
                details: detailscontroller.text.toString(),
                image: base64string);
            bool add = await ProductServer.updateProduct(p);
            if (add) {
              Fluttertoast.showToast(
                  msg: "Item Updated",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              if (context.mounted) {
                Navigator.pop(context, 'OK');
              }
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
          child: const Text('Edite',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  openImage() async {
    try {
      //var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      final XFile? pickedFile =
          await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagepath = pickedFile.path;

        var result = await FlutterImageCompress.compressWithFile(
          imagepath,
          quality: 10,
          rotate: 0,
        );

        int s1 = result!.lengthInBytes;
        double sc = s1 / 1024;

        if (sc < 64) {
          base64string = base64.encode(result);
          setState(() {
            widget.state();
          });
        } else {
          Fluttertoast.showToast(
              msg: "The image size is large",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        // Uint8List decodedbytes = base64.decode(base64string);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print(e);
    }
  }
}

class AddDialog extends StatefulWidget {
  const AddDialog({super.key, required this.state});

  final Function state;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  bool check = true;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController dispricecontroller = TextEditingController();
  TextEditingController discontcontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController availablecontroller = TextEditingController();
  TextEditingController detailscontroller = TextEditingController();

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String base64string = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edite Information',
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
              child: Text('Name : ',
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('price : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: pricecontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "price",
                  hintText: "Enter product price"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('discount : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: discontcontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "discount",
                  hintText: "Enter the product discount"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('price with discount : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: dispricecontroller,
              obscureText: false, //for password

              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "",
                  hintText: "Enter the price of the product with a discount"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('category : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: categorycontroller,
              obscureText: false, //for password

              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "category",
                  hintText: "Enter product category"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('details : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: detailscontroller,
              obscureText: false, //for password

              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "details",
                  hintText: "Enter the price details"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('available : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            Checkbox(
              activeColor: const Color.fromARGB(179, 251, 109, 0),
              value: check,
              onChanged: (value) {
                setState(() {
                  check = value!;
                });
              },
            ),
            Row(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('image : ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 251, 109, 0),
                              fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                      onPressed: () {
                        openImage();
                      },
                      icon: const Icon(
                        Icons.image_search,
                        color: Color.fromARGB(255, 251, 109, 0),
                        size: 30,
                      ),
                    ),
                  ],
                ),
                base64string != ""
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Image.memory(
                          base64.decode(base64string),
                          width: 99,
                          height: 132,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () async {
            if (namecontroller.text.toString() == "" ||
                pricecontroller.text.toString() == "" ||
                categorycontroller.text.toString() == "" ||
                detailscontroller.text.toString() == "") {
              Fluttertoast.showToast(
                  msg: "please fill name , price , category and details filed!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            if (base64string == "") {
              Fluttertoast.showToast(
                  msg: "please select image!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            ProductModel p = ProductModel(
                id: "4",
                name: namecontroller.text.toString(),
                price: pricecontroller.text.toString(),
                disprice: dispricecontroller.text.toString(),
                discont: discontcontroller.text.toString(),
                category: categorycontroller.text.toString(),
                available: check ? 1 : 0,
                details: detailscontroller.text.toString(),
                image: base64string);
            bool add = await ProductServer.addProduct(p);
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
          child: const Text('Add',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  openImage() async {
    try {
      //var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      final XFile? pickedFile =
          await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagepath = pickedFile.path;

        var result = await FlutterImageCompress.compressWithFile(
          imagepath,
          quality: 10,
          rotate: 0,
        );

        int s1 = result!.lengthInBytes;
        double sc = s1 / 1024;

        if (sc < 64) {
          base64string = base64.encode(result);
          setState(() {
            widget.state();
          });
        } else {
          Fluttertoast.showToast(
              msg: "The image size is large",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        // Uint8List decodedbytes = base64.decode(base64string);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print(e);
    }
  }
}
