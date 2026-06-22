import 'package:flutter/material.dart';
import 'dart:math';

// ----------  Enums ----------
enum AvatarShape { circle, square, hexagon }

enum AvatarSourceType { asset, network, initials }

// ----------  detect what kind of source string we got ----------
AvatarSourceType detectSourceType(String source) {
  if (source.startsWith('http')) {
    return AvatarSourceType.network;
  } else if (source.endsWith('.png') ||
      source.endsWith('.jpg') ||
      source.endsWith('.jpeg')) {
    return AvatarSourceType.asset;
  } else {
    return AvatarSourceType.initials;
  }
}

// ----------  turn a name into initials ----------

String getInitials(String name) {
  if (name.isEmpty) {
    return '#';
  }
  String cleanedName = name.trim().replaceAll(RegExp(r'\s+'), ' ');
  List<String> words = cleanedName.split(' ');
  if (words.length == 1) {
    return words[0][0];
  } else {
    return words[0][0] + words[1][0];
  }
}

// ----------  Hexagon shape math (built earlier) ----------
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    for (int i = 0; i < 6; i++) {
      double angle = (60 * i) * pi / 180;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
  //shouldReclip returns false → "nope, same cutter as always" (reuses cached shape — efficient)
}

// ---------- the Avatar widget/class itself ----------
class Avatar extends StatelessWidget {
  AvatarShape? shape;
  String? source;

  Avatar({super.key, required this.shape, required this.source});

  //---------------build function--------------------------------
  @override
  Widget build(BuildContext context) {
    if (source == null) {
      return const Text('#');
    }
    //if AvatarSourceType.network||AvatarSourceType.asset || AvatarSourceType.initials
    AvatarSourceType type = detectSourceType(source!);
    print('source:$source, detected type: $type');

    ImageProvider getImageProvider() {
      if (type == AvatarSourceType.asset) {
        return AssetImage('assets/$source');
      } else if (type == AvatarSourceType.network) {
        return NetworkImage(source!);
      } else {
        //it will never run but still
        throw Exception("getImageProvider called with initials --- bug ");
      }
    }

    //-----------------------circle logic---------------------------
    switch (shape) {
      case AvatarShape.circle:
        if (type == AvatarSourceType.initials) {
          return CircleAvatar(radius: 30, child: Text(getInitials(source!)));
        }

        return CircleAvatar(radius: 30, backgroundImage: getImageProvider());
      //---------------------square logic------------------------

      case AvatarShape.square:
        return Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: type == AvatarSourceType.initials
              ? BoxDecoration(color: Colors.grey[300])
              : BoxDecoration(
                  image: DecorationImage(
                    image: getImageProvider(),
                    fit: BoxFit.cover,
                  ),
                ),
          child: type == AvatarSourceType.initials
              ? Text(getInitials(source!))
              : null,
        );
      //-------------- Hexagon logic------------------------
      case AvatarShape.hexagon:
        return SizedBox(
          height: 60,
          width: 60,
          child: ClipPath(
            clipper: HexagonClipper(),
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: type == AvatarSourceType.initials
                  ? BoxDecoration(color: Colors.grey[300])
                  : BoxDecoration(
                      image: DecorationImage(
                        image: getImageProvider(),
                        fit: BoxFit.cover,
                      ),
                    ),
              child: type == AvatarSourceType.initials
                  ? Text(getInitials(source!))
                  : null,
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
