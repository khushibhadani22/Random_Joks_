import 'package:exam/apiHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? time;
  String? date;
  String? obTime;
  String? fTime;
  DateTime today = DateTime.now();
  @override
  void initState() {
    super.initState();
    date = "${today.day}-${today.month}-${today.year}";
    time =
        "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    super.initState();
    fiTime();
  }

  fiTime() async {
    final prefs = await SharedPreferences.getInstance();
    obTime = prefs.getString('time');
    fTime = prefs.getString('date');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "RANDOM JOK",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          "DATE & TIME",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "DATE :-  $obTime",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "TIME :- $fTime ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.watch_later_outlined,
              color: Colors.white,
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: APIHelper.apiHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "ERROR :- ${snapshot.error}",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          } else if (snapshot.hasData) {
            RanDom? data = snapshot.data;
            return (data != null)
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          height: 350,
                          width: 450,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 3, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "CREATED AT :- ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data.createdAt}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "UPDATED AT :- ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data.updatedAt}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "JOK :- ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${data.value}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                backgroundColor: Colors.black),
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              setState(() async {
                                await prefs.setString('time', '$time');
                                await prefs.setString('date', '$date');
                                print(obTime);
                              });
                            },
                            child: const Text(
                              "Fetch My Laugh",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                : const Text(
                    "No Data...",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }

  void currentTime() {
    setState(() {
      time =
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
      date = "${today.day}-${today.month}-${today.year}";
    });
  }
}
