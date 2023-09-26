import 'package:ecommerce_management/model/user_model.dart';
import 'package:ecommerce_management/page/compnent/item_user.dart';
import 'package:ecommerce_management/page/compnent/notifcation_dialog.dart';
import 'package:ecommerce_management/server/user_server.dart';
import 'package:flutter/material.dart';

class UsertPage extends StatefulWidget {
  const UsertPage({super.key});

  @override
  State<UsertPage> createState() => _UsertPageState();
}

class _UsertPageState extends State<UsertPage> {
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
                        "Users",
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
                  future: UserServer.getuser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 251, 88, 0)));
                    } else if (snapshot.hasData) {
                      List<UserModel> list = snapshot.data as List<UserModel>;

                      if (list.isNotEmpty) {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 1.2,
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 1.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: UserItem(
                                  user: list[index],
                                ),
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
              ),
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
                  return NotifDialog(
                    textbtn: "send to all",
                    fcm: "",
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
