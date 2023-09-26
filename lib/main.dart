import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_management/model/navigationbarCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ecommerce management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navigationbar = navigationbarCubit();

  @override
  void dispose() {
    navigationbar.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            Icon(
              Icons.featured_play_list_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.category_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.production_quantity_limits_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.supervised_user_circle_outlined,
              color: Colors.white,
            )
          ],
          onTap: (inedx) {
            switch (inedx) {
              case 3:
                navigationbar.user();
                break;
              case 1:
                navigationbar.category();
                break;
              case 0:
                navigationbar.product();
                break;
              case 2:
                navigationbar.cartlist();
                break;
              default:
            }
          },
          animationCurve: Curves.fastLinearToSlowEaseIn,
          color: const Color.fromARGB(179, 251, 109, 0),
          backgroundColor: const Color.fromARGB(95, 219, 218, 218),
        ),
        body: BlocBuilder(
          bloc: navigationbar,
          builder: (context, state) {
            return state as Widget;
          },
        ));
  }
}
