import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/screens/gallery_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

List<String> listImagePath = [];

class GalleryHome extends StatefulWidget {
  const GalleryHome({Key? key}) : super(key: key);

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  Directory? directory;
  File? image;

  @override
  void initState() {
    Directory dir = Directory.fromUri(
      Uri.parse(
        '/storage/emulated/0/Android/data/com.example.gallery/files',
      ),
    );
    super.initState();
    _imageFiles(dir);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(76, 109, 106, 106),
        title: const Text(
          'Gallery',
        ),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 160,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.amber[700],
          onPressed: () {
            takecamera();
          },
          child: const Icon(
            Icons.camera_alt_rounded,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: listImagePath.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => GalleryScreen(
                        image: listImagePath[index],
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: listImagePath[index],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(
                          File(
                            listImagePath[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> takecamera() async {
    var result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result == null) {
      return;
    }
    image = File(result.path);
    directory = await getExternalStorageDirectory();
    await image!.copy('${directory!.path}/${DateTime.now()}.jpg');
    Directory dir = directory!;
    _imageFiles(dir);
    setState(() {});
  }

  _imageFiles(Directory dir) async {
    listImagePath.clear();
    var value = await dir.list().toList();
    for (int i = 0; i < value.length; i++) {
      if (value[i].path.substring(
                (value[i].path.length - 4),
                (value[i].path.length),
              ) ==
          ".jpg") {
        listImagePath.add(
          value[i].path,
        );
      }
    }
    setState(() {});
  }
}
