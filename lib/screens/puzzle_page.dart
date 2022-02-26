import 'package:flutter/material.dart';
import 'package:folio/widgets/tileGenerator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PuzzlePage extends StatefulWidget {
  PuzzlePage({Key? key, required this.puzzle}) : super(key: key);
  int puzzle;
  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  List<String> puzzleTiles = [];
  var list = List<int>.generate(15, (int index) => index + 1);
  generateTilesFor1() {
    assetsAudioPlayer.open(
      Audio("assets/click1.wav"),
    );
    puzzleTiles = [];
    list.shuffle();

    for (var i = 0; i < 15; i++) {
      var index = list[i];
      puzzleTiles.add("assets/Tile_$index.jpg");
    }
  }

  generateTilesFor2() {
    assetsAudioPlayer.open(
      Audio("assets/click1.wav"),
    );
    puzzleTiles = [];
    list.shuffle();

    for (var i = 0; i < 15; i++) {
      var index = list[i];
      puzzleTiles.add("assets/Mile_$index.jpg");
    }
  }

  rebuildBoard1() {
    setState(() {
      generateTilesFor1();
      widget.puzzle = 1;
    });
  }

  rebuildBoard2() {
    setState(() {
      generateTilesFor2();
      widget.puzzle = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.puzzle < 2 ? rebuildBoard1() : rebuildBoard2();
    return SafeArea(
      child: Scaffold(
        drawer: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 235, 199),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
                child: Text(
                  "choose a different puzzle\nor click to reshuffle",
                  style: GoogleFonts.josefinSans(
                    color: const Color.fromARGB(255, 27, 27, 27),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/Puzzle_1.jpg'),
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
                      hoverColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.8),
                      onTap: () {
                        rebuildBoard1();
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/Puzzle_2.jpg'),
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
                      hoverColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.8),
                      onTap: () {
                        rebuildBoard2();
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 235, 199),
        appBar: AppBar(
          toolbarHeight: 80,
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 27, 27, 27)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Hero(
            tag: 'label',
            child: Text(
              "amorphia",
              style: GoogleFonts.josefinSans(
                color: const Color.fromARGB(255, 27, 27, 27),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      Expanded(child: TileGenerator(tileList: puzzleTiles)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
