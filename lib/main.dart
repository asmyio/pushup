import 'package:flutter/material.dart';
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
      home: MyHomePage(title: 'Push it Up!')
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
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          child: Container (color: Colors.redAccent,height: 4.0,), preferredSize: Size.fromHeight(4.0)),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ahmad Siraj MY wants you to',
            ),
            if (_proximityValues == true) Text('PUSH UP!!!', textScaleFactor: 5,) else Text('GO DOWN...', textScaleFactor: 2,),
            Text(
              'you have pushed up about...',
            ),
            Text(
              '$_counter times',
              style: Theme.of(context).textTheme.display1,
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
