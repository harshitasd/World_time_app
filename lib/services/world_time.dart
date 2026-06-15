import 'package:http/http.dart';
import "dart:convert";
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for ui
  String time = ''; //the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for location endpoints
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
        Uri.parse('https://time.now/developer/api/timezone/$url'),
      );
      //print(response.statusCode);
      //print(response.body);

      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      //print(now);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(offset);
      //print(now);

      time = DateFormat.jm().format(now); //by intel package
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      print(isDayTime);
    }
    //catch
    catch (e) {
      print('caught error $e');
      print(time = 'could not get time data:(  ');
    }
  }
}
