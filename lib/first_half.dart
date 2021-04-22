import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:foodcardapp/bloc/card_list_bloc.dart';
import 'package:foodcardapp/cart.dart';
import 'package:foodcardapp/models/food_item.dart';

class FirstHalf extends StatefulWidget {
  @override
  _FirstHalfState createState() => _FirstHalfState();
}

class _FirstHalfState extends State<FirstHalf> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35,25,0,0),
      child: Column(
        children: <Widget>[
          CustomeAppBar(),
          SizedBox(height: 30,),
          title(),
          SizedBox(height: 30,),
          searchBar(),
          SizedBox(height: 30,),
          categories(),
        ],
      ),
    );
  }
}


Widget categories () {
  return Container(
    height: 185,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Burgers",
          availability: 12,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Pizza",
          availability: 12,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Rolls",
          availability: 12,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Burgers",
          availability: 12,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Burgers",
          availability: 12,
          selected: false,
        ),
      ],
    ),
  );
}


Widget searchBar () {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(Icons.search,color: Colors.black54,),
      SizedBox(width: 20,),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search ...",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            helperStyle: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      )
    ],
  );
}


Widget title () {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        "Food",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
      Text(
        "Cart",
        style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 30,
        ),
      ),
    ],
  );
}


class CustomeAppBar extends StatefulWidget {
  @override
  _CustomeAppBarState createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15,top: 15,left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.ListStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;
              return buildGestureDetector(length, context, foodItems);
            },
          ),
        ],
      ),
    );
  }
}


GestureDetector buildGestureDetector(int length, BuildContext context, List<FoodItem> foodItems) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cart(),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(right: 30),
      child: Text(length.toString()),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}


class CategoryListItem extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  CategoryListItem({@required this.categoryIcon, @required this.categoryName, @required this.availability,
    @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Color(0xfffeb324) : Colors.white,
        border: Border.all(
          color: selected ? Colors.transparent : Colors.grey[200],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(25,0),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: selected ? Colors.transparent : Colors.grey,
                  width: 1.5
              ),
            ),
            child: Icon(categoryIcon,color: Colors.black,size: 30,),
          ),
          SizedBox(height: 10,),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}