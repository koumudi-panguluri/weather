import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final searchController = TextEditingController();
  final getCity;
  Search(this.getCity);
  void _submitField(context) {
    final city = searchController.text;

    if (city.isNotEmpty) {
      print("city searched $city");
      getCity(city);
    } else {
      print("type something");
      final scaff = Scaffold.of(context);
      scaff.showSnackBar(SnackBar(
        content: Text("Please enter the city"),
        backgroundColor: Color(0xffAA6373),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: scaff.hideCurrentSnackBar,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black12),
        child: TextField(
          controller: searchController,
          onSubmitted: (_) => _submitField(context),
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
              labelText: "Search For the City", icon: Icon(Icons.search)),
        ));
  }
}
