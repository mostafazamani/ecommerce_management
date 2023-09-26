import 'package:ecommerce_management/server/notification_server.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotifDialog extends StatefulWidget {
  const NotifDialog({super.key, required this.textbtn, required this.fcm});
  final String textbtn;
  final String fcm;

  @override
  State<NotifDialog> createState() => _NotifDialogState();
}

class _NotifDialogState extends State<NotifDialog> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController msgcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Notification",
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
              child: Text('title : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: titlecontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "title",
                  hintText: "Enter title"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('message : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 251, 109, 0),
                      fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: msgcontroller,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "message",
                  hintText: "Enter message"),
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
            if (msgcontroller.text.toString() == "" ||
                titlecontroller.text.toString() == "") {
              Fluttertoast.showToast(
                  msg: "please fill notif message ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            if (widget.textbtn == "send to user") {
              bool send = await NotifServer.SendToUser(
                titlecontroller.text.toString(),
                msgcontroller.text.toString(),
                widget.fcm,
              );
              if (send) {
                Fluttertoast.showToast(
                    msg: "Notification Sent!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                if (context.mounted) {
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
                if (context.mounted) {
                  Navigator.pop(context, 'OK');
                }
              }
            } else {
              bool send = await NotifServer.SendToAll(
                titlecontroller.text.toString(),
                msgcontroller.text.toString(),
              );

              if (send) {
                Fluttertoast.showToast(
                    msg: "Notification Sent",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                if (context.mounted) {
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
                if (context.mounted) {
                  Navigator.pop(context, 'OK');
                }
              }
            }
          },
          child: Text(widget.textbtn,
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 109, 0),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
