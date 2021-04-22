import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:foodcardapp/bloc/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/food_item.dart';

class CartListBloc extends BlocBase{

  CartListBloc();

  var listContoller = BehaviorSubject<List<FoodItem>>.seeded([]); // 9anat

  CartProvider cartProvider = CartProvider();

  Stream<List<FoodItem>> get ListStream => listContoller.stream; // sortie

  Sink<List<FoodItem>> get ListSink => listContoller.sink; // entree

  addToList(FoodItem foodItem) {
    ListSink.add(cartProvider.addToList(foodItem));
  }

  removeFromList(FoodItem foodItem) {
    ListSink.add(cartProvider.removeFromList(foodItem));
  }

  @override
  void dispose() {// will be called automatically
    listContoller.close();
    super.dispose();
  }

}