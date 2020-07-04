import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Time Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = "";
  bool checktimer = true;
  @override
  void initState() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + (sec));
    // debugPrint(timeForTimer.toString());
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || checktimer == false) {
          t.cancel();
          checktimer = true;
          timeToDisplay = "";
          started = true;
          stopped = true;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
  }

////////////////StopWatch/////////////

bool startispressed = true ;
bool stopispressed = true ;
bool resetispressed = true ;
String stoptimetodispay = "00:00:00";
var swatch = Stopwatch();
final dur = const Duration(seconds: 1);


void keeprunning(){
      if(swatch.isRunning){
        starttimer();
      }
      setState(() { 
        stoptimetodispay = swatch.elapsed.inHours.toString().padLeft(2,"0") + ":"
                          +  (swatch.elapsed.inMinutes % 60 ).toString().padLeft(2,"0") + ":"
                          + (swatch.elapsed.inSeconds% 60 ).toString().padLeft(2,"0") ;
      });
}
void starttimer(){
      Timer(dur, keeprunning);
}
void startstopwatch(){
    setState(() {
      stopispressed = false ;
      startispressed = false ;
    });
    swatch.start();
    starttimer();
}

void resetstopwatch(){
      setState(() {
        startispressed = true;
        resetispressed = true ;

      });
      swatch.reset();
      stoptimetodispay = "00:00:00";
}

void stopstopwatch(){
  setState(() {
    stopispressed = true ;
    resetispressed = false ;
  });
  swatch.stop();

}
 
  Widget stopwatch() {
    return Container(
      child: Column(
        children: [
          Expanded(
              flex: 6,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    stoptimetodispay,
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.w700),
                  ))),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: stopispressed ? null : stopstopwatch,
                        color: Colors.red,
                        child: Text(
                          "Stop",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      RaisedButton(
                        onPressed: resetispressed ? null : resetstopwatch,
                        color: Colors.teal,
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ],
                  ),
                   RaisedButton(
                  onPressed: startispressed ? startstopwatch :null ,
                  color: Colors.green,
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white
                    ),
                  ),
                    padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
                ],
              ))
        ],
      ),
    );
  }

  Widget timer() {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      listViewWidth: 60.0,
                      minValue: 0,
                      maxValue: 23,
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      listViewWidth: 60.0,
                      maxValue: 59,
                      onChanged: (val) {
                        setState(() {
                          min = val;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      listViewWidth: 60.0,
                      maxValue: 59,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    )
                  ],
                )
              ],
            )),
        Expanded(
            flex: 1,
            child: Text(
              timeToDisplay,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
              ),
            )),
        Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: started ? start : null,
                  color: Colors.green,
                  child: Text(
                    "Start",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  color: Colors.red,
                  child: Text(
                    "Stop",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                )
              ],
            )),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Text("Timer"),
              Text("Stopwatch"),
            ],
            labelPadding: EdgeInsets.only(bottom: 10.0),
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: Colors.white60,
            controller: tb,
          )),
      body: TabBarView(
        children: <Widget>[timer(), stopwatch()],
        controller: tb,
      ),
    );
  }
}
