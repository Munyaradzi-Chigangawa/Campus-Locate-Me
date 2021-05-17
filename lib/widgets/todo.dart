import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:campus_locate_me/models/place.dart';
import 'package:campus_locate_me/pages/comments.dart';
import 'package:campus_locate_me/pages/guide.dart';
import 'package:campus_locate_me/utils/next_screen.dart';
import 'package:campus_locate_me/pages/map.dart';

class TodoWidget extends StatelessWidget {
  final Place placeData;
  const TodoWidget({Key key, @required this.placeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('ToDo',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                )) ,
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: 3,
          width: 50,
          
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40)),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: GridView.count(
            padding: EdgeInsets.all(0),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.blueAccent[400],
                                      offset: Offset(5, 5),
                                      blurRadius: 2)
                                ]),
                            child: Icon(
                              LineIcons.arrow_up,
                              size: 30,
                            ),
                          ),
                          
                          Text(
                              'Navigation Guide',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ) ,
                          
                        ])),
                onTap: () => nextScreen(context, GuidePage(d: placeData)),
              ),
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.blueAccent[400],
                                      offset: Offset(5, 5),
                                      blurRadius: 2)
                                ]),
                            child: Icon(
                              LineIcons.map,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Map',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ) ,
                        ])),
                onTap: () => nextScreen(context, MapPage()),
              ),
              // InkWell(
              //   child: Container(
              //       padding: EdgeInsets.all(15),
              //       decoration: BoxDecoration(
              //         color: Colors.pinkAccent,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: <Widget>[
              //             Container(
              //               height: 50,
              //               width: 50,
              //               decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.white,
              //                   boxShadow: <BoxShadow>[
              //                     BoxShadow(
              //                         color: Colors.pinkAccent[400],
              //                         offset: Offset(5, 5),
              //                         blurRadius: 2)
              //                   ]),
              //               child: Icon(
              //                 Icons.restaurant_menu,
              //                 size: 30,
              //               ),
              //             ),
              //             Text(
              //                 'nearby restaurants',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 15),
              //               ) ,
                          
              //           ])),
              //   onTap: () => nextScreen(context, RestaurantPage(placeData: placeData,)),
              // ),
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.blueAccent[400],
                                      offset: Offset(5, 5),
                                      blurRadius: 2)
                                ]),
                            child: Icon(
                              LineIcons.comments,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ) ,
                        ])),
                onTap: () => nextScreen(context, CommentsPage(collectionName: 'places', timestamp: placeData.timestamp,)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
