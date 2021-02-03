import '../screens/place_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_provider.dart';
import '../screens/add_place_screen.dart';
import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
                // Provider.of<PlacesProvider>(context, listen: false)
                //     .delDatabase();
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, placesSnapShot) => placesSnapShot.connectionState ==
                ConnectionState.waiting
            ? Center(child: Text('retrieving places...'))
            : Consumer<PlacesProvider>(
                child: Center(
                    child: const Text('Got no places yet, start adding some')),
                builder: (ctx, places, childdd) => places.items.length <= 0
                    ? childdd
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(places.items[i].image),
                              ),
                              title: Text(places.items[i].title),
                              subtitle: Text(places.items[i].location.address),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PlaceDetailScreen.routeName,
                                    arguments: places.items[i].id);
                              },
                            )),
              ),
      ),
    );
  }
}
