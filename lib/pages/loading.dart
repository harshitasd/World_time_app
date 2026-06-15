import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//the blue spinkit page       Opens the app ✅
//* Fetches Berlin’s current time ✅
//* Hands the data to Home screen ✅
//* Disappears (pushReplacementNamed) ✅

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //
  setUpWorldTime() async {
    WorldTime instance = WorldTime(
      location: "berlin",
      flag: "berlin.jpg",
      url: 'Europe/Berlin',
    );

    await instance.getTime();
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'flag': instance.flag,
        'location': instance.location,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(child: SpinKitPulsingGrid(color: Colors.white, size: 50.0)),
    );
  }
}
