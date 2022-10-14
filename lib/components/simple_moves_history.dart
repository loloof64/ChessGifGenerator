import 'package:flutter/material.dart';

class SimpleMovesHistory extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final List<String> movesSans;

  const SimpleMovesHistory({
    super.key,
    required this.width,
    required this.height,
    required this.movesSans,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.amber.shade300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 10.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: movesSans
                  .map(
                    (currentSan) => Text(
                      currentSan,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: 'Free Serif',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
