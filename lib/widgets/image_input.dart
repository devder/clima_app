import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final picker = ImagePicker();

  Future _takePicture() async {
    final imageFile =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);

    setState(() {
      if (imageFile != null) {
        //store the image gotten from the camera to the variable
        _storedImage = File(imageFile.path);
      } else {
        print('No image selected.');
        return;
      }
    });
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'no image selected',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
          onPressed: _takePicture,
          textColor: Theme.of(context).primaryColor,
          label: Text(
            'Take picture',
          ),
          icon: Icon(
            Icons.camera,
          ),
        ))
      ],
    );
  }
}
