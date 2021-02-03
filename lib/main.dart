import 'screens/place_detail_screen.dart';
import 'screens/add_place_screen.dart';
import 'providers/great_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Color(0xffb39283),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen()
        },
      ),
    );
  }
}
