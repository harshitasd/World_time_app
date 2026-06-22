import 'package:flutter/material.dart';
import 'package:world_time_app/widgets/avatar.dart';
import 'package:world_time_app/widgets/data/test.dart';

class AvatarTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('🟢 AVATAR TEST SCREEN BUILD START');
    return Scaffold(
      body: ListView.builder(
        itemCount: testContacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            minTileHeight: 80,
            title: Text(testContacts[index].name),
            leading: Avatar(
              shape: AvatarShape.hexagon,
              source:
                  testContacts[index].imageSource ?? testContacts[index].name,
            ),
          );
        },
      ),
    );
  }
}
