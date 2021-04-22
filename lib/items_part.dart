import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:foodcardapp/bloc/card_list_bloc.dart';
import 'models/food_item.dart';
import 'package:progressive_image/progressive_image.dart';

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  ItemContainer({this.foodItem});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);

        final snackBar = SnackBar(
          content: Text("${foodItem.title} added to the cart"),
          duration: Duration(milliseconds: 550),
          backgroundColor: Colors.yellow[700],
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        hotel: foodItem.hotel,
        name: foodItem.title,
        price: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2 == 0) ? true : false,
      ),
    );
  }
}


class Items extends StatelessWidget {
  final String hotel;
  final String name;
  final double price;
  final String imgUrl;
  final bool leftAligned;

  Items({
    @required this.hotel,
    @required this.name,
    @required this.price,
    @required this.imgUrl,
    @required this.leftAligned,
  });

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerPaddingRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned ? Radius.circular(0) : Radius.circular(containerPaddingRadius),
                    right: leftAligned ? Radius.circular(containerPaddingRadius) : Radius.circular(0),
                  ),
                  child: ProgressiveImage(
                    height: 200,
                    width: double.infinity,
                    thumbnail: NetworkImage(
                      imgUrl,
                    ),
                    placeholder: NetworkImage(
                      imgUrl,
                    ),
                    image: NetworkImage(
                      imgUrl,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Text(
                          price.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(text: "by "),
                            TextSpan(
                              text: hotel,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: containerPadding,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}