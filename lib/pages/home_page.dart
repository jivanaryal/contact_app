import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/models/lat_lng_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contacts = [
    ContactModel(
        name: "jivan aryal",
        phoneNumber: "9844707947",
        image:
            "https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&w=600",
        position: LatLngModel(latitude: 27.6866, longitude: 82.4323)),
    ContactModel(
        name: "himal fullel",
        phoneNumber: "9867398339",
        image:
            "https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&w=600",
        position: LatLngModel(latitude: 27.6866, longitude: 82.4323)),
    ContactModel(
        name: "manoj belbase",
        phoneNumber: "9823847399",
        image:
            "https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&w=600",
        position: LatLngModel(latitude: 27.6866, longitude: 82.4323)),
  ];

  final ImagePicker picker = ImagePicker();
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
                    // isDismissible: false,
                    isScrollControlled:
                        true, //this is used to scroll the container with swiping
                    context: context,
                    builder: (_) => Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                Text(
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
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: IconButton(
                                      onPressed: () async {
                                        XFile? pickedImage =
                                            await picker.pickImage(
                                                source: ImageSource.camera);

                                        print(pickedImage!.path);
                                      },
                                      icon: Icon(Icons.add_a_photo)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.15),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        InputDecoration(labelText: "Full Name"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.15),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        InputDecoration(labelText: "Phone"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.15),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        InputDecoration(labelText: "Address"),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text("add contact"))
                              ],
                            ),
                          ),
                        ));
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
                  child: Image.network(
                    contacts[index].image,
                    fit: BoxFit.cover,
                  ),
                )),
            title: Text(contacts[index].name),
            subtitle: Text("98446079483"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone),
            ),
          );
        },
      ),
    );
  }
}
