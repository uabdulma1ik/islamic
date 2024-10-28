import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Page2 extends StatefulWidget {
  Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Location(),
              Padding(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 8, bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black)),
                ),
              ),
              WeekDays(),
              RectangleContainer(),
              Rectangles(),
            ],
          ),
        ),
      ),
    );
  }
}

class Location extends StatefulWidget {
  Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 25, right: 25),
      child: Container(
        width: double.infinity,
        height: 45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.amber,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Uzbekistan",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Text(
                    "Kokand",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekDays extends StatefulWidget {
  const WeekDays({super.key});

  @override
  State<WeekDays> createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDays> {
  List<String> weekDays = [];
  List<int> dates = [];

  @override
  void initState() {
    super.initState();
    _fetchWeekDays();
  }

  Future<void> _fetchWeekDays() async {
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return; // Check if the widget is still mounted

    DateTime today = DateTime.now();
    int currentDay = today.weekday;

    DateTime startOfWeek = today.subtract(Duration(days: currentDay - 1));

    weekDays.clear();
    dates.clear();
    for (int i = 0; i < 7; i++) {
      weekDays
          .add(DateFormat('EEE').format(startOfWeek.add(Duration(days: i))));
      dates.add(startOfWeek.add(Duration(days: i)).day);
    }

    if (mounted) setState(() {}); // Only call setState if still mounted
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(7, (index) {
          return Expanded(
            child: Column(
              children: [
                Text(
                  weekDays.isNotEmpty ? weekDays[index] : '',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 13.2),
                ),
                SizedBox(height: 5),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: (index == DateTime.now().weekday - 1)
                      ? Colors.green
                      : Colors.grey[300],
                  child: Center(
                    child: Text(
                      dates.isNotEmpty ? dates[index].toString() : '',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class RectangleContainer extends StatefulWidget {
  RectangleContainer({super.key});

  @override
  State<RectangleContainer> createState() => _RectangleContainerState();
}

class _RectangleContainerState extends State<RectangleContainer> {
  bool volumeBool = true;
  void volumeFunc() {
    setState(() {
      volumeBool = !volumeBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 126, 120, 120),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 13,
              left: 20,
              child: InkWell(
                onTap: () {
                  volumeFunc();
                },
                child: Container(
                  height: 35,
                  width: 37,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(volumeBool
                                    ? "images/volumeOff.png"
                                    : "images/volumeOn.png"),
                                fit: BoxFit.contain),
                          ))),
                ),
              ),
            ),
            Positioned(
              top: 19,
              left: 65,
              child: Text(
                volumeBool ? "OFF" : "ON",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Positioned(
              top: 18,
              right: 20,
              child: Text(
                "01:024:06 to Duhr",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              top: 53,
              left: 20,
              child: Text(
                "Mon, 10 Aug 2024",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Positioned(
              top: 75,
              left: 18,
              child: Text(
                "12:59",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 140,
              left: 20,
              child: Text(
                "Next namaz time",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 20,
              child: Container(
                height: 27,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Look Qibla",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              right: 30,
              child: Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.green,
                    Colors.white,
                    Colors.green,
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
                child: Center(
                  child: Container(
                    height: 77,
                    width: 77,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/mosque.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Rectangles extends StatefulWidget {
  Rectangles({super.key});

  @override
  State<Rectangles> createState() => _RectanglesState();
}

class _RectanglesState extends State<Rectangles> {
  List<bool> volumeStates = List.filled(6, false);

  bool hasError = false;

  String fajr = "";
  String sunrise = "";
  String dhuhr = "";
  String asr = "";
  String maghrib = "";
  String isha = "";

  Timer? apiTimer;

  Future<void> apiFunc() async {
    setState(() {
      hasError = false;
    });

    try {
      String apiUrl =
          "https://api.aladhan.com/v1/timingsByAddress/present?address=kokand";
      Response response = await get(Uri.parse(apiUrl));

      if (!mounted) return; // Check if widget is still mounted

      var timeData = jsonDecode(response.body);
      setState(() {
        fajr = timeData["data"]["timings"]["Fajr"] ?? "N/A";
        sunrise = timeData["data"]["timings"]["Sunrise"] ?? "N/A";
        dhuhr = timeData["data"]["timings"]["Dhuhr"] ?? "N/A";
        asr = timeData["data"]["timings"]["Asr"] ?? "N/A";
        maghrib = timeData["data"]["timings"]["Maghrib"] ?? "N/A";
        isha = timeData["data"]["timings"]["Isha"] ?? "N/A";
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          hasError = true;
        });
      }
    }
  }

  void volumeFunc(int index) {
    setState(() {
      volumeStates[index] = !volumeStates[index];
    });
  }

  @override
  void initState() {
    super.initState();
    apiFunc();
    apiTimer = Timer.periodic(Duration(hours: 10), (Timer t) => apiFunc());
  }

  @override
  void dispose() {
    apiTimer?.cancel(); // Ensure the timer is canceled
    super.dispose();
  }

  Widget buildPrayerTile(String prayerName, String prayerTime, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
      child: GestureDetector(
        onTap: () => print('$prayerName tile tapped'),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 1, offset: Offset(0.6, 0.8))
            ],
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 17,
                left: 22,
                child: Text(prayerName,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500)),
              ),
              Positioned(
                top: 18,
                right: 75,
                child: Text(
                  prayerTime,
                  style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ),
              Positioned(
                top: 18,
                right: 22,
                child: InkWell(
                  onTap: () => volumeFunc(index),
                  child: Icon(
                      volumeStates[index] ? Icons.volume_off : Icons.volume_up,
                      color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Center(
          child: Text("Error loading data. Please check your connection."));
    }

    return Column(
      children: [
        buildPrayerTile("Fajr", fajr, 0),
        buildPrayerTile("Sunrise", sunrise, 1),
        buildPrayerTile("Dhuhr", dhuhr, 2),
        buildPrayerTile("Asr", asr, 3),
        buildPrayerTile("Maghrib", maghrib, 4),
        buildPrayerTile("Isha", isha, 5),
      ],
    );
  }
}
