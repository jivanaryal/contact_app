import 'dart:io';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/models/lat_lng_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  List<ContactModel> contacts = [];

  final ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  clearField() {
    image = null;
    fullNameController.clear();
    phoneController.clear();
  }

  selectAImage(ImageSource source, Function(void Function()) setState) async {
    try {
      Navigator.of(context).pop();
      XFile? pickedImage = await picker.pickImage(source: source);

      setState(() {
        image = File(pickedImage!.path);
      });
    } catch (err) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: ))
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.sizeOf(context).height;
    double deviceWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Icon(
          Icons.back_hand,
          color: Colors.white,
        ),
        title: Text(
          "contacts",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder:
                        (_) => StatefulBuilder(builder: (context, setState) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close))
                                        ],
                                      ),
                                      const Text(
                                        "Add Contact",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Container(
                                        height: 100,
                                        width: 90,
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            border: Border.all(
                                                color: Colors.black, width: 2)),
                                        child: image == null
                                            ? IconButton(
                                                onPressed: () async {
                                                  clearField();
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (_) => AlertDialog(
                                                                title: Text(
                                                                    "choose a source"),
                                                                content: Text(
                                                                    "camera or gallery"),
                                                                actions: [
                                                                  TextButton.icon(
                                                                      onPressed: () {
                                                                        selectAImage(
                                                                            ImageSource.camera,
                                                                            setState);
                                                                      },
                                                                      icon: Icon(Icons.camera),
                                                                      label: Text("camera")),
                                                                  TextButton.icon(
                                                                      onPressed: () {
                                                                        selectAImage(
                                                                            ImageSource.gallery,
                                                                            setState);
                                                                      },
                                                                      icon: Icon(Icons.image),
                                                                      label: Text("gallery"))
                                                                ],
                                                              ));
                                                },
                                                icon: Icon(Icons.add_a_photo))
                                            : Image.file(image!),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: deviceWidth * 0.15),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: fullNameController,
                                          decoration: InputDecoration(
                                              labelText: "Full Name"),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: deviceWidth * 0.15),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                              labelText: "Phone"),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            this.setState(() {
                                              contacts.add(ContactModel(
                                                  name: fullNameController.text,
                                                  phoneNumber:
                                                      phoneController.text,
                                                  image: image,
                                                  position: LatLngModel(
                                                      latitude: 112.33,
                                                      longitude: 23.221)));
                                            });
                                            clearField();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "contact added",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Contact Added",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white))));
                                          },
                                          child: Text("add contact"))
                                    ],
                                  ),
                                ),
                              );
                            }));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 38,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: contacts[index].image == null
                      ? Icon(Icons.person)
                      : Image.file(
                          contacts[index].image!,
                          fit: BoxFit.cover,
                        ),
                )),
            title: Text(contacts[index].name),
            subtitle: Text("98446079483"),
            trailing: IconButton(
              onPressed: () {
                _makePhoneCall("9844707947");
              },
              icon: Icon(Icons.phone),
            ),
          );
        },
      ),
    );
  }
}
