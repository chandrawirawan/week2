import 'package:flutter/material.dart';
import 'package:movpedia/theme.dart';

class HomeScreenCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnails;
  final bool halfSize;
  HomeScreenCard({ this.halfSize = false, @required this.title, @required this.thumbnails, @required this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      height: halfSize ? 295.0 / 2 : 295.0,
      width: halfSize ? (MediaQuery.of(context).size.width / 2) - 20 : double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: halfSize ? 190.0 / 2 : 190,
                color: Colors.black26,
                width: double.infinity,
                child: Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(thumbnails),
                ),
              ),
              Positioned(
                top: halfSize ? 20 :45,
                child: Container(
                  width: (halfSize ? (MediaQuery.of(context).size.width / 2) - 20 : MediaQuery.of(context).size.width) - 20,
                  height: halfSize ? 10 : 100,
                  child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: halfSize ? 50 : 80,
                    ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: halfSize ? 25 :  75,
                width: halfSize ? 25 :  75,
                decoration: BoxDecoration(
                  color: AppTheme.colorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title.toUpperCase(),
                      style: halfSize ? AppTheme.cardSmallHomeTitle : AppTheme.cardHomeTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                    ),
                    !halfSize ? Column(
                      children: [
                        Text(
                          description,
                          style: AppTheme.cardHomeDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          // softWrap: false,
                        ),
                      ],
                    ) : SizedBox(width: 0,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
