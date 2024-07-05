import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int milliseconds = 0;
  String digitMilliseconds = "00", digitSeconds = "00", digitMinutes = "00";
  Timer? timer;
  bool started = false;
  List<String> laps = [];

  // Start function
  void start() {
    if (!started) {
      setState(() {
        started = true;
      });
      timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        int localMilliseconds = milliseconds + 1;
        int localSeconds = localMilliseconds ~/ 1000;
        int localMinutes = localSeconds ~/ 60;

        setState(() {
          milliseconds = localMilliseconds;
          digitMilliseconds = (localMilliseconds % 1000).toString().padLeft(3, '0');
          digitSeconds = (localSeconds % 60).toString().padLeft(2, '0');
          digitMinutes = (localMinutes % 60).toString().padLeft(2, '0');
        });
      });
    }
  }

  // Stop function
  void stop() {
    if (started) {
      timer?.cancel();
      setState(() {
        started = false;
      });
    }
  }

  // Reset function
  void reset() {
    timer?.cancel();
    setState(() {
      milliseconds = 0;
      digitMilliseconds = "00";
      digitSeconds = "00";
      digitMinutes = "00";
      started = false;
    });
  }

  //laps delete function
  void lapDelete(int index){
    setState(() {
      laps.removeAt(index);
    });

  }

  // Laps function
  void addLaps() {
    String lap = "$digitMinutes:$digitSeconds:$digitMilliseconds";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Center(
          child:Text(
          'Stopwatch App',
          style: TextStyle(color: Colors.blueGrey.shade50,fontSize: 23),
        ),
      ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Center(
                child: Text(
                  '$digitMinutes:$digitSeconds:$digitMilliseconds',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade50,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade600,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ${index + 1}",
                            style: TextStyle(
                              color: Colors.blueGrey.shade50,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.blueGrey.shade50,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            color: Colors.blueGrey.shade50,
                            onPressed: () {
                              lapDelete(index);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      fillColor: Colors.blueGrey.shade50,
                      shape: StadiumBorder(),
                      child: Text(
                        (!started) ? "Start" : "Pause",
                        style: TextStyle(color: Colors.blueGrey.shade800,fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Added for spacing between buttons
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blueGrey.shade50,
                      shape: StadiumBorder(),
                      child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.blueGrey.shade800,fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Added for spacing between buttons
                  IconButton(
                    color: Colors.blueGrey.shade50,

                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(Icons.add ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
