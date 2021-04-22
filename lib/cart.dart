import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:foodcardapp/bloc/card_list_bloc.dart';
import 'package:foodcardapp/bloc/color_bloc.dart';
import 'package:foodcardapp/models/food_item.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems;

    return StreamBuilder(
      stream: bloc.ListStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: CartBody(foodItems: foodItems),
              ),
            ),
            bottomNavigationBar: BottomBar(foodItems: foodItems,),
          );
        }
        else {
          return Container();
        }
      },
    );
  }
}


class BottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;

  BottomBar({this.foodItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25,bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          persons(),
          nextButtonBar(),
        ],
      ),
    );
  }


  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xfffeb324),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Next",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }


  Container totalAmount(List<FoodItem> foodItems) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "${returnTotalAmount(foodItems)}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  String returnTotalAmount(List<FoodItem> foodItems) {
    double totalAmount = 0;

    for (int i = 0;i < foodItems.length;i++) {
      totalAmount += foodItems[i].price * foodItems[i].quantity;
    }

    return totalAmount.toStringAsFixed(2);
  }

  Container persons () {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Persons",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          CustomPerson(),
        ],
      ),
    );
  }
}


class CustomPerson extends StatefulWidget {
  @override
  _CustomPersonState createState() => _CustomPersonState();
}

class _CustomPersonState extends State<CustomPerson> {
  int numOFPersons = 1;
  double buttonWidth = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2,color: Colors.grey[300]),
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: FlatButton(
              child: Text(
                "-",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
              onPressed: () {
                setState(() {
                  numOFPersons--;
                });
              },
            ),
          ),
          Text(
            numOFPersons.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
          ),
          SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: FlatButton(
              child: Text(
                "+",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
              onPressed: () {
                setState(() {
                  numOFPersons++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}



class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBody({this.foodItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
      child: Column(
        children: <Widget>[
          CustomeAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : nooItemsContainer(),
          )
        ],
      ),
    );
  }


  Container nooItemsContainer() {
    return Container(
      child: Center(
        child: Text(
          "No items in the cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }


  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (builder,index) {
        return CartListItem(foodItem: foodItems[index]);
      },
    );
  }
}


Widget title () {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 25),
    child: Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "My ",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35
              ),
            ),
            Text(
              "Order",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 35
              ),
            ),
          ],
        )
      ],
    ),
  );
}


class CustomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(CupertinoIcons.back,size: 30,),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        DragTargetWidget(),
      ],
    );
  }
}


class DragTargetWidget extends StatefulWidget {
  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();
  final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

  @override
  Widget build(BuildContext context) {
    return DragTarget<FoodItem>(
      onWillAccept: (FoodItem foodItem) {
        colorBloc.setColor(Colors.pink);
        return true;
      },
      onAccept: (FoodItem foodItem) {
        listBloc.removeFromList(foodItem);
        colorBloc.setColor(Colors.white);
      },
      onLeave: (foodItems) {
        colorBloc.setColor(Colors.white);
      },
      builder: (context, incoming, rejected) {
        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              CupertinoIcons.delete,
              size: 35,
            ),
          ),
          onTap: () {

          },
        );
      },
    );
  }
}



class CartListItem extends StatelessWidget {
  final FoodItem foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: foodItem,
      maxSimultaneousDrags: 1,
      child: DraggableChild(foodItem: foodItem),
      feedback: DraggableChildFeedback(foodItem: foodItem,),
      childWhenDragging: foodItem.quantity > 1 ? DraggableChild(foodItem: foodItem,) : Container(),
    );
  }
}


class DraggableChild extends StatelessWidget {
  const DraggableChild({Key key,@required this.foodItem}) : super(key: key);

  final FoodItem foodItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ItemContent(foodItem: foodItem),
    );
  }
}


class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({Key key,@required this.foodItem}) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: colorBloc.colorStream,
          builder: (context,snapshot) {
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ItemContent(foodItem: foodItem),
              decoration: BoxDecoration(
                color: snapshot.data != null ? snapshot.data : Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}


class ItemContent extends StatelessWidget {
  final FoodItem foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodItem.imgUrl,
              fit: BoxFit.fitHeight,
              height: 50,
              width: 75,
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: foodItem.quantity.toString()),
                TextSpan(text: " X "),
                TextSpan(text: foodItem.title),
              ]
            ),
          ),
          Text(
            "${foodItem.quantity * foodItem.price}",
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}