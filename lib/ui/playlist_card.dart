import 'package:flutter/material.dart';
import 'package:movpedia/theme.dart';

class PlaylistCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String thumbnails;
  final int exerciseNumber;
  final bool isPlayed;
  final Function(String) onPlayButtonPressed;
  PlaylistCard({
    @required this.id,
    @required this.onPlayButtonPressed,
    @required this.title,
    @required this.thumbnails,
    @required this.description,
    @required this.exerciseNumber,
    this.isPlayed = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      height: 90.0,
      width: double.infinity,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise: ${exerciseNumber.toString()}: ',
                  style: AppTheme.smallRegularBold,
                ),
                
                  Text(
                    title,
                    style: AppTheme.smallRegularBold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
              ],
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              if (!isPlayed) {
                onPlayButtonPressed(id);
              }
            },
            elevation: 1,
            shape: CircleBorder(),
            fillColor: isPlayed ? AppTheme.colorGrey128 : AppTheme.colorPrimary,
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
