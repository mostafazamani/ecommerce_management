// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecommerce_management/model/product_model.dart';
import 'package:ecommerce_management/page/compnent/item_product.dart';
import 'package:ecommerce_management/server/product_server.dart';

class MySearch extends SearchDelegate {
  MySearch({
    required this.refresh,
  });
  Function refresh;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> list =[];
    return FutureBuilder(
      future: ProductServer.searchProduct(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 251, 88, 0)),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            list = snapshot.data as List<ProductModel>;
            if(list.isNotEmpty) {
              return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ProductItem(product: list[index], state: refresh),
                    );
                  });
            }else{
              return const Center(child: Text('No Product Found'));
            }
          } else {
            return const Center(child: Text('No Product Found'));
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 251, 88, 0)),
          );
        }
      },
    );
  }
}
