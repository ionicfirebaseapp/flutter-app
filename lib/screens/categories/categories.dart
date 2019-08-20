import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../screens/categories/category_expanded.dart';
import '../../widgets/categoryCard.dart';
import '../../services/json.dart';

class Categories extends StatefulWidget {
  static String tag = "categories";
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgGrey,
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: GridView.builder(
                  itemCount: data['category'].length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CategoryExpanded(
                                title: data['category'][index]['title'],
                                time: data['category'][index]['time'],
                              ),
                            ),
                          );
                        },
                        child: CategoryCard(
                            title: data['category'][index]['title'],
                            icon: data['category'][index]['icon'],
                            isLast: data['category'][index]['isLast']));
                  }),
            )));
  }
}
