import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:all_sensors/all_sensors.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push It Up! by asmy.dev',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _proximityValues = false;
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];
  int _counter = 0;

  void _incrementCounter() {
    if (_proximityValues == true) {
      setState(() {
      _counter++;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("💪🏻💪🏼💪🏽💪🏾💪🏿"),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          )
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_proximityValues == true) 
            Text('PUSH UP!!!', 
                  textScaleFactor: 5,
                  style: GoogleFonts.baloo(),            
                  textAlign: TextAlign.center,) 
            else 
            Text('GO DOWN...', 
                  textScaleFactor: 2, 
                  style: GoogleFonts.baloo(),
                  textAlign: TextAlign.center,),
            Text(
              '$_counter Push Ups',
              style: Theme.of(context).textTheme.headline4,
              textScaleFactor: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
              setState(() {
                _counter = 0;
              });
        }, 
        label: Text('RESET'),
        icon:  Icon(Icons.all_inclusive),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Text("asmy.dev", textAlign: TextAlign.center,), 
      ),
    );
  }

    @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }


   @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(proximityEvents.listen((ProximityEvent event) {
      setState(() {
        _proximityValues = event.getValue();
        _incrementCounter();
      });
    }));
  }
}
