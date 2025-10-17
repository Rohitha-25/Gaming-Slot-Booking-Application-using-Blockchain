import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:project_escapism/page_2/drawer.dart';
import 'package:project_escapism/page_2/location.dart';
import 'package:project_escapism/page_4/time_slot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String buttonText = 'Access Current Location';

  Future<String> getCurrentLocation() async {
    try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark placemark = placemarks.first;
      String street = placemark.street ?? '';
      String locality = placemark.locality ?? '';
      return '$street, $locality';
  } catch (e) {
    print('Error getting location: $e');
    return 'Unknown Location';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      init: LocationController(),
      builder: (controller) {
        return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff081427),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff081427),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: Text(
                  '    Hello Puttu!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                    onTap: () async {
                      String currentLocation = await getCurrentLocation();
                      setState(() {
                          buttonText = currentLocation;
                      });
                    },
                    child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.my_location, color: Colors.white),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        buttonText,
                        style: const TextStyle(color: Colors.white,fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                width: 360,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                    icon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    for (var item in _getFilteredItems())
                      CategoryCard(
                        img: item.img,
                        title: item.title,
                        press: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TimeSlot(img: item.img, title: item.title)));
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  },
  );
}

  List<CategoryItem> _getFilteredItems() {
    if (_searchQuery.isEmpty) {
      return _allItems;
    } else {
      return _allItems.where((item) => item.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
  }
}

class CategoryItem {
  final String img;
  final String title;
  const CategoryItem(this.img, this.title);
}

// Define your category items outside the widget
final List<CategoryItem> _allItems = [
  const CategoryItem('assets/1.png', 'VR Gaming'),
  const CategoryItem('assets/2.png', 'Rebellion eSports'),
  const CategoryItem('assets/3.png', 'Rox Gaming'),
  const CategoryItem('assets/4.png', 'Gamers Guild'),
  const CategoryItem('assets/5.png', 'Clutch Den'),
  const CategoryItem('assets/6.png', 'Xtreme Gamerz Arena'),
];

class CategoryCard extends StatelessWidget {
  final String img;
  final String title;
  final VoidCallback press;
  const CategoryCard({
    super.key, required this.img, required this.title, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Image.asset(img),
                  const Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}