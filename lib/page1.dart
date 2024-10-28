import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              StackContainer(),
              LastSurah(),
              Container(
                width: double.infinity,
                height: 20,
                child: Stack(
                  children: [
                    Positioned(
                      left: 25,
                      child: Text(
                        "MAKKAH LIVE",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 15),
                child: Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        offset: Offset(0, 0.7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () async {
                        const String url =
                            'https://www.youtube.com/live/G0PC9JDC-2Y?si=3z2S4nAjQwUCdjmj'; // Replace with your YouTube link
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage("images/kaabaLive.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StackContainer extends StatefulWidget {
  const StackContainer({super.key});

  @override
  State<StackContainer> createState() => _StackContainerState();
}

class _StackContainerState extends State<StackContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(37),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 17,
                    left: 25,
                    right: 25,
                    child: Container(
                      height: 150,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/dark_bg.png"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 30,
                            child: Text(
                              "Assalomu alaykum",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Positioned(
                            right: 25,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/boy.png"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
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
          _4in1Rectangle(),
        ],
      ),
    );
  }
}

class _4in1Rectangle extends StatefulWidget {
  const _4in1Rectangle();

  @override
  State<_4in1Rectangle> createState() => __4in1RectangleState();
}

class __4in1RectangleState extends State<_4in1Rectangle> {
  String fajr = "";
  String sunrise = "";
  String dhuhr = "";
  String asr = "";
  String maghrib = "";
  String isha = "";

  void apiFunc() async {
    String apiUrl =
        "https://api.aladhan.com/v1/timingsByAddress/present?address=kokand";
    Response response = await get(Uri.parse(apiUrl));
    var timeData = jsonDecode(response.body);
    setState(() {
      fajr = timeData["data"]["timings"]["Fajr"];
      sunrise = timeData["data"]["timings"]["Sunrise"];
      dhuhr = timeData["data"]["timings"]["Dhuhr"];
      asr = timeData["data"]["timings"]["Asr"];
      maghrib = timeData["data"]["timings"]["Maghrib"];
      isha = timeData["data"]["timings"]["Isha"];
    });
  }

  @override
  void initState() {
    super.initState();
    apiFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 90),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black, blurRadius: 2.0, offset: Offset(0.5, 1.5)),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 5,
              ),
              child: Container(
                height: 60,
                width: double.infinity,
                // color: Colors.red,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.clock,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Text(
                              "  Fajr time",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        Text(
                          fajr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                      ],
                    ),
                    Expanded(child: Text("")),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Text(
                              "  Uzbekistan",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        Text(
                          "Kokand",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/masjid.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Mosque",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/quran.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Al-Qur'an",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/tasbeeh.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Tasbeeh",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/kaaba.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Kaaba",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LastSurah extends StatefulWidget {
  const LastSurah({super.key});

  @override
  State<LastSurah> createState() => _LastSurahState();
}

class _LastSurahState extends State<LastSurah> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30, top: 15),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 15, 15, 15),
                blurRadius: 2.5,
                offset: Offset(0.5, 1))
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 15,
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(17),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/star.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 88,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The last surah you read.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 3.5),
                  Text(
                    "AL-BAQARAH",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 15,
              top: 33,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
