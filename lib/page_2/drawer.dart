import 'package:flutter/material.dart';
import 'package:project_escapism/page_1/main.dart';
import 'package:project_escapism/page_2/drawer_items.dart';
import 'package:project_escapism/page_3/gaming_centers.dart';
import 'package:project_escapism/page_3/my_account.dart';
import 'package:project_escapism/page_3/my_bookings.dart';
import 'package:project_escapism/page_3/people.dart';
import 'package:project_escapism/page_3/settings.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xff081427),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: IconButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   }, 
              //   icon: const Icon(Icons.arrow_back_ios,
              //   size: 20,
              //   color: Colors.white,),
              //   ),
              // ),
              // const SizedBox(height: 20,),
              headerWidget(),
              const SizedBox(height: 30,),
              const Divider(thickness: 2, height: 10, color: Colors.white,),
              const SizedBox(height: 30,),
              DrawerItems(
                name: 'People', 
                icon: Icons.people, 
                onPressed: ()=> onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 30,),
              DrawerItems(
                name: 'My Account', 
                icon: Icons.account_box_rounded, 
                onPressed: ()=> onItemPressed(context, index: 1),
              ),
              const SizedBox(height: 30,),
              DrawerItems(
                name: 'Gaming Centers', 
                icon: Icons.favorite_outline,
                onPressed: ()=> onItemPressed(context, index: 2),
              ),
              const SizedBox(height: 30,),
              DrawerItems(
                name: 'My Bookings', 
                icon: Icons.message_outlined, 
                onPressed: ()=> onItemPressed(context, index: 3),
              ),
              const SizedBox(height: 30,),
              const Divider(thickness: 2, height: 10, color: Colors.white,),
              const SizedBox(height: 30,),
              DrawerItems(
                name: 'Settings', 
                icon: Icons.settings, 
                onPressed: ()=> onItemPressed(context, index: 4),
              ),
              const SizedBox(height: 30,),
              DrawerItems(
                name: 'Logout', 
                icon: Icons.logout, 
                onPressed: ()=> onItemPressed(context, index: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const People()));
        break;

      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAccount()));
        break;

      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GamingCenters()));
        break;

      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBookings()));
        break;

      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
        break;

      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
    }
  }

  Widget headerWidget(){
    return const Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/snoopy.png'),
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Puttu', style: TextStyle(fontSize: 14, color: Colors.white),),
            SizedBox(height: 10,),
            Text('sonuputtoli@gmail.com', style: TextStyle(fontSize: 14, color: Colors.white),)
          ],
        )
      ],
    );
  }
}