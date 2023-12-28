import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/models/lat_lng_model.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
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
                    context: context,
                    builder: (_) => BottomSheet(
                        onClosing: () {},
                        builder: (_) => Column(
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
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                )
                              ],
                            )));
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
