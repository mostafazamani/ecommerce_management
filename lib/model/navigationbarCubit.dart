import 'package:ecommerce_management/page/cartlist_page.dart';
import 'package:ecommerce_management/page/category_page.dart';
import 'package:ecommerce_management/page/product_page.dart';
import 'package:ecommerce_management/page/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class navigationbarCubit extends Cubit<Widget> {
  navigationbarCubit() : super(const ProductPage());

  void product() => emit(const ProductPage());
  void user() => emit(const UsertPage());
  void cartlist() => emit(const CartListPage());
  void category() => emit(const CategoryPage());
}
