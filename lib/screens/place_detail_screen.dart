import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_provider.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/placeDetail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedPlace =
        Provider.of<PlacesProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                          initialLocation: selectedPlace.location,
                        )),
              );
            },
            child: Text('View on Map'),
            textColor: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
