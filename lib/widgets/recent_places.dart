import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_locate_me/blocs/recent_places_bloc.dart';
import 'package:campus_locate_me/models/place.dart';
import 'package:campus_locate_me/pages/more_places.dart';
import 'package:campus_locate_me/pages/place_details.dart';
import 'package:campus_locate_me/utils/next_screen.dart';
import 'package:campus_locate_me/widgets/custom_cache_image.dart';
import 'package:campus_locate_me/utils/loading_cards.dart';



class RecentPlaces extends StatelessWidget {
  RecentPlaces({Key key}) : super(key: key);

  


  
  @override
  Widget build(BuildContext context) {
   final rb = context.watch<RecentPlacesBloc>();
    
    

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10,),
          child: Row(children: <Widget>[
            Text('Recently Added', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.grey[800]),) ,
            Spacer(),
            IconButton(icon: Icon(Icons.arrow_forward),
              onPressed: () => nextScreen(context, MorePlacesPage(title: 'Recently Added', color: Colors.blueGrey[600],)), 
            )
          ],),
        ),
        

        Container(
          height: 220,
          //color: Colors.green,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 15, right: 15),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: rb.data.isEmpty ? 3 : rb.data.length,
            itemBuilder: (BuildContext context, int index) {
              if(rb.data.isEmpty) return LoadingPopularPlacesCard();
              return ItemList(d: rb.data[index],);
              //return LoadingCard1();
           },
          ),
        )
        
        
      ],
    );
  }
}


class ItemList extends StatelessWidget {
  final Place d;
  const ItemList({Key key, @required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
                margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                  
                ),
                child: Stack(
                   children: [
                     Hero(
                       tag: 'recent${d.timestamp}',
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCacheImage(imageUrl: d.imageUrl1)
                       ),
                     ),
                     Align(
                       alignment: Alignment.bottomLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                         child: Text(d.name, 
                         maxLines: 2,
                         style: TextStyle(
                           fontSize: 16,
                           color: Colors.white,
                           fontWeight: FontWeight.w500
                         ),),
                       ),
                     ),

                   ],
                ),
                
              ),

              onTap: () => nextScreen(context, PlaceDetails(data: d, tag: 'recent${d.timestamp}')),
    );
  }
}

