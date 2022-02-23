import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';

class TileGenerator extends StatefulWidget {
  const TileGenerator({
    Key? key,
    required this.tileList,
  }) : super(key: key);
  final List<String> tileList;

  @override
  State<TileGenerator> createState() => _TileGeneratorState();
}

class _TileGeneratorState extends State<TileGenerator> {
  int currentHoverIndex = 0;
  int currentDragStartIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tileList = widget.tileList;
    var size = MediaQuery.of(context).size;
    final assetsAudioPlayer = AssetsAudioPlayer();

    onSwapColor(index) {
      setState(() {
        Swap(tileList, currentHoverIndex, index);
      });
      assetsAudioPlayer.open(
        Audio("assets/click2.wav"),
      );
    }

    onPickupSound() {
      assetsAudioPlayer.open(
        Audio("assets/click1.wav"),
      );
    }

    return Stack(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
            childAspectRatio: 1,
          ),
          itemCount: 16,
          itemBuilder: (context, index) {
            if (index == 15) {
              return Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.north_outlined,
                      size: 40,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "skip here",
                      style: GoogleFonts.josefinSans(
                        color: const Color.fromARGB(255, 27, 27, 27),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.west_outlined,
                        size: 40,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Neumorphic(
                style: NeumorphicStyle(
                  surfaceIntensity: 0.4,
                  shadowLightColorEmboss:
                      const Color.fromARGB(255, 199, 199, 199),
                  shadowDarkColorEmboss:
                      const Color.fromARGB(255, 109, 109, 109),
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15.8)),
                  depth: -2.5,
                  lightSource: LightSource.topLeft,
                  color: const Color.fromARGB(255, 241, 239, 239),
                ),
              );
            }
          },
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
            childAspectRatio: 1,
          ),
          itemCount: tileList.length,
          itemBuilder: (context, index) {
            if (tileList[index] == "assets/Tile_15.jpg") {
              return Draggable(
                onDragEnd: (details) {
                  onSwapColor(index);
                },
                onDragStarted: () {
                  currentDragStartIndex = index;
                  onPickupSound();
                },
                childWhenDragging: Container(),
                feedback: Neumorphic(
                  style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    surfaceIntensity: 0.61,
                    shadowLightColor: Color.fromARGB(255, 255, 248, 248),
                    shadowDarkColor: Color.fromARGB(255, 155, 155, 155),
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 0,
                    lightSource: LightSource.topLeft,
                  ),
                  child: Container(
                    height: (size.width) > 600 ? 150 : 80,
                    width: (size.width) > 600 ? 150 : 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(tileList[index].toString()),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.control_camera_outlined,
                        color: const Color.fromARGB(255, 56, 56, 56),
                        size: (size.width > 600) ? 70 : 50,
                      ),
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.8),
                    image: DecorationImage(
                      image: AssetImage(tileList[index].toString()),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 3),
                        blurRadius: 10,
                        spreadRadius: -5,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.8),
                      onTap: () {},
                      onHover: (hovering) {
                        hovering
                            ? currentHoverIndex = index
                            : currentHoverIndex = currentDragStartIndex;
                      },
                      child: Stack(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          // child: Text(
                          //   (index + 1).toString(),
                          //   style: GoogleFonts.josefinSans(
                          //     color: const Color.fromARGB(255, 248, 235, 199),
                          //     fontSize: size.width > 600 ? 20 : 15,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          // ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.control_camera_outlined,
                              color: const Color.fromARGB(255, 56, 56, 56),
                              size: (size.width > 600) ? 70 : 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(tileList[index].toString()),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15.8),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(2, 3),
                      blurRadius: 10,
                      spreadRadius: -5,
                      color: Colors.black,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(15.8),
                    onTap: () {},
                    onHover: (hovering) {
                      hovering
                          ? currentHoverIndex = index
                          : currentHoverIndex = currentDragStartIndex;
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

Swap<T>(List<T> list, int indexA, int indexB) {
  if ((indexA == 0) && (indexB == 4 || indexB == 1)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 1) && (indexB == 0 || indexB == 2 || indexB == 5)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 2) && (indexB == 1 || indexB == 3 || indexB == 6)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 3) && (indexB == 2 || indexB == 7)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 4) && (indexB == 0 || indexB == 5 || indexB == 8)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 5) &&
      (indexB == 4 || indexB == 1 || indexB == 9 || indexB == 6)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 6) &&
      (indexB == 5 || indexB == 2 || indexB == 10 || indexB == 7)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 7) && (indexB == 3 || indexB == 6 || indexB == 11)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 8) && (indexB == 4 || indexB == 9 || indexB == 12)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 9) &&
      (indexB == 8 || indexB == 10 || indexB == 5 || indexB == 13)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 10) &&
      (indexB == 9 || indexB == 11 || indexB == 6 || indexB == 14)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 11) && (indexB == 10 || indexB == 7 || indexB == 14)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 12) && (indexB == 13 || indexB == 8)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 13) && (indexB == 9 || indexB == 14 || indexB == 12)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  } else if ((indexA == 14) && (indexB == 11 || indexB == 13 || indexB == 10)) {
    T tmp = list[indexA];
    list[indexA] = list[indexB];
    list[indexB] = tmp;
  }
}
