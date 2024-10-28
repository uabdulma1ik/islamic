import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Location(),
              Padding(
                //Chiziq
                padding: const EdgeInsets.only(
                    left: 35, right: 35, top: 8, bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black)),
                ),
              ),
              WeekDays(),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Container(
                  height: 17,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                ),
              ),
              AchievementContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
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
            Container(
              height: 27,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  "Look Qibla",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
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
    _initializeWeekDays();
  }

  void _initializeWeekDays() {
    // Simulated network call delay
    Future.delayed(Duration(seconds: 1), () {
      DateTime today = DateTime.now();
      int currentDay = today.weekday;

      DateTime startOfWeek = today.subtract(Duration(days: currentDay - 1));

      // Populate the weekDays and dates lists
      for (int i = 0; i < 7; i++) {
        weekDays
            .add(DateFormat('EEE').format(startOfWeek.add(Duration(days: i))));
        dates.add(startOfWeek.add(Duration(days: i)).day);
      }

      // Update the state after fetching data
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
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
                      : Colors.grey[300], // Highlight today
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

class Achievement extends StatelessWidget {
  final int percentage;

  const Achievement({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        height: 50,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Achievement : $percentage%", // Display the percentage
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Expanded(child: Text("")),
                Text(
                  "All (5)", // Assuming there are 5 items
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth =
                    constraints.maxWidth * (percentage / 100);

                return Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(6.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 2.5),
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 14,
                      width: containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6.5)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementContainer extends StatefulWidget {
  const AchievementContainer({super.key});

  @override
  State<AchievementContainer> createState() => _AchievementContainerState();
}

class _AchievementContainerState extends State<AchievementContainer> {
  bool fajrCheck = false;
  bool dhuhrCheck = false;
  bool asrCheck = false;
  bool maghribCheck = false;
  bool ishaCheck = false;

  String fajr = "";
  String dhuhr = "";
  String asr = "";
  String maghrib = "";
  String isha = "";

  Timer? resetTimer;

  @override
  void initState() {
    super.initState();
    loadCheckboxStates();
    apiFunc();
    scheduleMidnightReset();
  }

  void scheduleMidnightReset() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final timeUntilMidnight = tomorrow.difference(now);

    resetTimer = Timer(timeUntilMidnight, resetCheckboxes);
  }

  void resetCheckboxes() {
    setState(() {
      fajrCheck = false;
      dhuhrCheck = false;
      asrCheck = false;
      maghribCheck = false;
      ishaCheck = false;
    });
    saveCheckboxStates();
    scheduleMidnightReset();
  }

  int calculatePercentage() {
    int totalPrayers = 5;
    int checkedPrayers = (fajrCheck ? 1 : 0) +
        (dhuhrCheck ? 1 : 0) +
        (asrCheck ? 1 : 0) +
        (maghribCheck ? 1 : 0) +
        (ishaCheck ? 1 : 0);

    return (checkedPrayers / totalPrayers * 100).round();
  }

  void apiFunc() async {
    String apiUrl =
        "https://api.aladhan.com/v1/timingsByAddress/present?address=kokand";
    Response response = await get(Uri.parse(apiUrl));
    var timeData = jsonDecode(response.body);
    setState(() {
      fajr = timeData["data"]["timings"]["Fajr"];
      dhuhr = timeData["data"]["timings"]["Dhuhr"];
      asr = timeData["data"]["timings"]["Asr"];
      maghrib = timeData["data"]["timings"]["Maghrib"];
      isha = timeData["data"]["timings"]["Isha"];
    });
  }

  void loadCheckboxStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fajrCheck = prefs.getBool('fajrCheck') ?? false;
      dhuhrCheck = prefs.getBool('dhuhrCheck') ?? false;
      asrCheck = prefs.getBool('asrCheck') ?? false;
      maghribCheck = prefs.getBool('maghribCheck') ?? false;
      ishaCheck = prefs.getBool('ishaCheck') ?? false;
    });
  }

  void saveCheckboxStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fajrCheck', fajrCheck);
    await prefs.setBool('dhuhrCheck', dhuhrCheck);
    await prefs.setBool('asrCheck', asrCheck);
    await prefs.setBool('maghribCheck', maghribCheck);
    await prefs.setBool('ishaCheck', ishaCheck);
  }

  @override
  void dispose() {
    resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Achievement(percentage: calculatePercentage()),
        SizedBox(height: 45),
        buildPrayerTile(
          "Fajr",
          fajr,
          fajrCheck,
          () {
            setState(() {
              fajrCheck = !fajrCheck;
              saveCheckboxStates();
            });
          },
        ),
        buildPrayerTile(
          "Dhuhr",
          dhuhr,
          dhuhrCheck,
          () {
            setState(() {
              dhuhrCheck = !dhuhrCheck;
              saveCheckboxStates();
            });
          },
        ),
        buildPrayerTile(
          "Asr",
          asr,
          asrCheck,
          () {
            setState(() {
              asrCheck = !asrCheck;
              saveCheckboxStates();
            });
          },
        ),
        buildPrayerTile(
          "Maghrib",
          maghrib,
          maghribCheck,
          () {
            setState(() {
              maghribCheck = !maghribCheck;
              saveCheckboxStates();
            });
          },
        ),
        buildPrayerTile(
          "Isha",
          isha,
          ishaCheck,
          () {
            setState(() {
              ishaCheck = !ishaCheck;
              saveCheckboxStates();
            });
          },
        ),
      ],
    );
  }

  Widget buildPrayerTile(String prayerName, String prayerTime, bool isChecked,
      VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, top: 25),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayerName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, color: Colors.grey, size: 20),
                    SizedBox(width: 10),
                    Text(
                      prayerTime,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: onTap,
              child: Icon(
                isChecked ? Icons.check_circle : Icons.check_circle_outline,
                color: Colors.green,
                size: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
