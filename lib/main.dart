import 'package:flutter/material.dart';
import 'package:folio/screens/puzzle_page.dart';
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
      color: Color.fromARGB(255, 248, 235, 199),
      home: GridAssembler(),
    );
  }
}

class GridAssembler extends StatelessWidget {
  const GridAssembler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: const Center(
          child: MenuSelection(),
        ),
      ),
    );
  }
}

class MenuSelection extends StatefulWidget {
  const MenuSelection({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuSelection> createState() => _MenuSelectionState();
}

class _MenuSelectionState extends State<MenuSelection> {
  bool clicked = false;

  void animator() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        clicked = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    animator();
    bool isScreenWide = MediaQuery.of(context).size.width >= 600;
    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: clicked ? 150 : 100,
          height: clicked ? 150 : 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 191, 243),
            borderRadius: BorderRadius.circular(15.8),
          ),
          child: Center(
            child: Container(
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
                  splashColor: const Color.fromARGB(40, 233, 30, 98),
                  hoverColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuzzlePage(puzzle: 1)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: isScreenWide
              ? const Icon(Icons.keyboard_arrow_left)
              : const Icon(Icons.keyboard_arrow_up),
        ),
        Text(
          "choose a puzzle",
          style: GoogleFonts.josefinSans(
            color: const Color.fromARGB(255, 27, 27, 27),
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: isScreenWide
              ? const Icon(Icons.keyboard_arrow_right)
              : const Icon(Icons.keyboard_arrow_down),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: clicked ? 150 : 100,
          height: clicked ? 150 : 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 191, 243),
            borderRadius: BorderRadius.circular(15.8),
          ),
          child: Center(
            child: Container(
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
                  splashColor: const Color.fromARGB(40, 233, 30, 98),
                  hoverColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuzzlePage(puzzle: 2)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: Grid(),
//     );
//   }
// }

// class Grid extends StatefulWidget {
//   @override
//   GridState createState() {
//     return new GridState();
//   }
// }

// class GridState extends State<Grid> {
  
// }


