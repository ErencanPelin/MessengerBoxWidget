import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String textValue = "Lorem Ipsum";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Input Text:"),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: TextField(onChanged: (value) => setState(() {
                textValue = value;
              })),
            ),
            const SizedBox(height: 30),
                BubbleWidget(textValue, 13),
          ],
        ),
      ),
    );
  }

  Widget BubbleWidget(String actualText, double textSize) {
    var fontWidthMultiplier = 0.4; //font multiplier for different fontstyles
    var fontHeightMultiplier = 1.5; //font multiplier for different fontstyles

    //total area in pixels for the text
    var textWidth = actualText.length * textSize * fontWidthMultiplier;

    //start at the minimum
    double desiredWidth = 72;
    double desiredHeight = 72;

    //text overflow cases
    if (textWidth >= 198) {
      var sub = (198 - textWidth).abs();
      desiredWidth = textWidth - sub;
      desiredHeight =
          (sub) * textSize * fontHeightMultiplier;
    }
    //check intermediate state 2
    if (textWidth >= 90) {
      var sub = (198 - textWidth).abs();
      desiredWidth = textWidth - sub;
      desiredHeight =
          (sub) * textSize * fontHeightMultiplier;
    }
    //intermediate state 1
    if (textWidth < 90) {
      desiredWidth = textWidth;
    } 

    double width = clampDouble(desiredWidth, 72, 198); // FIGURE OUT THIS VALUE
    double height = clampDouble(desiredHeight, 72, 90); // FIGURE OUT THIS VALUE
    int maxLines = clampDouble(height / (fontHeightMultiplier * textSize), 1,
                90 / (fontHeightMultiplier * textSize))
            .floor() -
        1; // FIGURE OUT THIS VALUE

    return Container(
      margin: EdgeInsets.only(
        top: 90.0 - height,
        left: 4.0,
      ),
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints(maxWidth: width + 2), // For border
      height: height,
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade700,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 4.0),
            constraints: const BoxConstraints(maxWidth: 198, maxHeight: 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: Text(
                    "Erencan",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 9, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Text(actualText,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: textSize, color: Colors.white)),
        ],
      ),
    );
  }
}
