import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class TileGenerator extends StatefulWidget {
  TileGenerator({
    Key? key,
    required this.tileList,
  }) : super(key: key);
  List<String> tileList;

  @override
  State<TileGenerator> createState() => _TileGeneratorState();
}

class _TileGeneratorState extends State<TileGenerator> {
  int pointerOnIndex = 0;
  final key = GlobalKey();

  _detectTapedItem(PointerEvent event) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    var result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        final target = hit.target;
        if (target is _OverlapDetector) {
          _selectIndex(target.index);
          print(target.index);
        }
      }
    }
  }

  _selectIndex(int index) {
    setState(() {
      pointerOnIndex = index;
    });
  }

  int currentHoverIndex = 0;
  int currentDragStartIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tileList = widget.tileList;
    var size = MediaQuery.of(context).size;
    final assetsAudioPlayer = AssetsAudioPlayer();

    onPickupSound() {
      assetsAudioPlayer.open(
        Audio("assets/click1.wav"),
      );
    }

    onDropSound() {
      assetsAudioPlayer.open(
        Audio("assets/click2.wav"),
      );
    }

    return Listener(
      // onPointerDown: _detectTapedItem,
      onPointerUp: _detectTapedItem,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: size.width - 70,
            width: size.width - 70,
            child: Stack(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                          Align(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: size.width > 600 ? 35 : 25,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: size.width > 600
                                ? Text(
                                    "skip here",
                                    style: GoogleFonts.josefinSans(
                                      color:
                                          const Color.fromARGB(255, 27, 27, 27),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Text(
                                    "skip\nhere",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.josefinSans(
                                      color:
                                          const Color.fromARGB(255, 27, 27, 27),
                                      fontSize: size.width < 500 ? 14 : 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: size.width > 600 ? 35 : 25,
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
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15.8)),
                          depth: -2.5,
                          lightSource: LightSource.topLeft,
                          color: const Color.fromARGB(255, 241, 239, 239),
                        ),
                      );
                    }
                  },
                ),
                GridView.builder(
                  key: key,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: tileList.length,
                  itemBuilder: (context, index) {
                    if (tileList[index] == "assets/Tile_15.jpg" ||
                        tileList[index] == "assets/Mile_15.jpg") {
                      return Draggable(
                        onDragEnd: (details) {
                          Swap(tileList, index, pointerOnIndex);
                          onDropSound();
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
                            shadowLightColor:
                                Color.fromARGB(255, 255, 248, 248),
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
                                color: (tileList[index] == "assets/Tile_15.jpg")
                                    ? const Color.fromARGB(255, 56, 56, 56)
                                    : const Color.fromARGB(255, 211, 211, 211),
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
                            borderRadius: BorderRadius.circular(15.8),
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
                                  Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.control_camera_outlined,
                                      color: (tileList[index] ==
                                              "assets/Tile_15.jpg")
                                          ? const Color.fromARGB(
                                              255, 56, 56, 56)
                                          : const Color.fromARGB(
                                              255, 211, 211, 211),
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
                      return OverlapDetector(
                        index: index,
                        child: Container(
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
                            borderRadius: BorderRadius.circular(15.8),
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
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
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

class OverlapDetector extends SingleChildRenderObjectWidget {
  final int index;

  const OverlapDetector({required Widget child, required this.index, Key? key})
      : super(child: child, key: key);

  @override
  _OverlapDetector createRenderObject(BuildContext context) {
    return _OverlapDetector()..index = index;
  }

  @override
  void updateRenderObject(BuildContext context, _OverlapDetector renderObject) {
    renderObject.index = index;
  }
}

class _OverlapDetector extends RenderProxyBox {
  late int index;
}
