import 'package:ecommerce_management/model/user_model.dart';
import 'package:ecommerce_management/page/compnent/notifcation_dialog.dart';
import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});
  final UserModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40),
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Name :",
                          style: TextStyle(
                              color: Color.fromARGB(179, 251, 109, 0)),
                        ),
                        Text(widget.user.name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 251, 109, 0),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Email :",
                            style: TextStyle(
                                color: Color.fromARGB(179, 251, 109, 0))),
                        Text(widget.user.email,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 251, 109, 0),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Address :",
                            style: TextStyle(
                                color: Color.fromARGB(179, 251, 109, 0))),
                        Text(widget.user.address,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 251, 109, 0),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Number :",
                            style: TextStyle(
                                color: Color.fromARGB(179, 251, 109, 0))),
                        Text(widget.user.number,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 251, 109, 0),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(179, 251, 109, 0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: TextButton(
                      onPressed: () {
                        showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: const Duration(milliseconds: 400),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return NotifDialog(
                              textbtn: "send to user",
                              fcm: widget.user.fcmtoken,
                            );
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
                      child: const Text("Send notification"),
                    ),
                  )
                ],
              )),
        ));
  }
}
