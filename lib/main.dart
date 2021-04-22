import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:foodcardapp/bloc/card_list_bloc.dart';
import 'package:foodcardapp/bloc/color_bloc.dart';
import 'package:foodcardapp/first_half.dart';
import 'package:foodcardapp/items_part.dart';
import 'package:foodcardapp/models/food_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(),
              SizedBox(height: 45,),
              for (var foodItem in foodItemList.foodItems)
                ItemContainer(
                  foodItem: foodItem,
                )
            ],
          ),
        ),
      ),
    );
  }
}