import '../widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../widgets/location_input.dart';
import '../providers/great_places_provider.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/addPlace';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _myPickedImage;
  PlaceLocation _myPickedLocation;

  void _selectImage(File myPickedImage) {
    _myPickedImage = myPickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _myPickedLocation = PlaceLocation(longitude: lng, latitude: lat);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _myPickedImage == null ||
        _myPickedLocation == null) {
      print('error');
      return;
    }
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _myPickedImage, _myPickedLocation);
    // Provider.of<PlacesProvider>(context, listen: false).delDatabase();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectPlace)
                ],
              ),
            ),
          )),
          Container(
            height: 80,
            child: RaisedButton.icon(
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
    );
  }
}
