import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_escapism/page_5/booking.dart';

class TimeSlot extends StatelessWidget {
  const TimeSlot({super.key, required this.img, required this.title});

  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    List<DateTime> weekDates = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = currentDate.add(Duration(days: i));
      weekDates.add(date);
    }

    List<String> timeSlots = [
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '02:00 PM',
      '03:00 PM',
      '05:00 PM',
      '06:00 PM'
    ];

    return Scaffold(
      backgroundColor: const Color(0xff081427),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
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
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Miyapur, Hyderabad',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      const SliverToBoxAdapter(
        child: SizedBox(height: 20),
      ),
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Date',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showDates(context, weekDates[index]);
                  },
                  child: dateItem(weekDates[index]),
              );
            },
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(height: 20),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Time',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showAvailableBookings(context, timeSlots[index], weekDates[index]);
                      },
                      child: timeSlotItem(timeSlots[index]),
                  );
                },
              ),
            ),
          ),
        ]
      ),
    );
  }

  void _showDates(BuildContext context, DateTime weekDate) {
  String formattedDate = DateFormat('EEE, dd MMM').format(weekDate);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('selected date:\n$formattedDate', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('select date'),
            ),
          ],
        );
      },
    );
  }

  void _showAvailableBookings(BuildContext context, String timeSlot, DateTime weekDate) {
    int availableSlots = 10;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedSlots = 1;
        return AlertDialog(
          title: Text('Available Bookings for\n$timeSlot', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Available: $availableSlots'),
              const SizedBox(height: 20),
              const Text('Select no.of players: '),
              const SizedBox(height: 10),
              DropdownButton<int>(
                value: selectedSlots,
                onChanged: (newValue) {
                  selectedSlots = newValue!;
                },
                items: List.generate(
                  availableSlots,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Booking(selectedDate: weekDate, selectedTime: timeSlot, selectedSlots: selectedSlots, gamingZone: title,)));
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        );
      },
    );
  }

  Widget dateItem(DateTime date) {
    String formattedDate = DateFormat('EEE\ndd\nMMM').format(date);
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        formattedDate,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget timeSlotItem(String time) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        time,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}