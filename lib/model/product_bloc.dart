import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<int, int> {
  ProductBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    print(event);
    yield event;
  }
}
