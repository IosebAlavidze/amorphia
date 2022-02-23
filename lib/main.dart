import 'package:flutter/material.dart';
import 'package:folio/widgets/tileGenerator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "amorphia",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> puzzleTiles = [];
    generateTiles() {
      var list = List<int>.generate(15, (int index) => index + 1);
      list.shuffle();

      for (var i = 0; i < 15; i++) {
        var index = list[i];
        puzzleTiles.add("assets/Tile_$index.jpg");
      }
    }

    generateTiles();
    return Container(
      color: const Color.fromARGB(255, 248, 235, 199),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 248, 235, 199),
          // drawer: const ClipRRect(
          //   borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(14.0),
          //       bottomRight: Radius.circular(14.0)),
          //   child: Drawer(
          //     backgroundColor: Color.fromARGB(255, 248, 235, 199),
          //   ),
          // ),
          appBar: AppBar(
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return Tooltip(
            //       message: 'open navigation menu',
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(25),
            //           color: Colors.grey),
            //       textStyle: GoogleFonts.josefinSans(
            //         color: const Color.fromARGB(255, 255, 255, 255),
            //         fontSize: 12,
            //         fontWeight: FontWeight.w300,
            //       ),
            //       child: IconButton(
            //         icon: const Icon(Icons.menu),
            //         onPressed: () {
            //           Scaffold.of(context).openDrawer();
            //         },
            //       ),
            //     );
            //   },
            // ),
            toolbarHeight: 80,
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 27, 27, 27)),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Text(
              "amorphia",
              style: GoogleFonts.josefinSans(
                color: const Color.fromARGB(255, 27, 27, 27),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Center(
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
        ),
      ),
    );
  }
}
