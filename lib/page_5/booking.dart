import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final int selectedSlots;
  final String gamingZone;

  const Booking({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedSlots,
    required this.gamingZone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff081427),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff081427),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Confirm Booking",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              gamingZone,
              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Time: $selectedTime',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'No.of Players: $selectedSlots',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 60),
            MaterialButton(
              minWidth: 200,
              height: 60,
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Blockchain()));
              },
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Make Payment",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}