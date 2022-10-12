import 'package:flutter/material.dart';

class SimpleMovesHistory extends StatelessWidget {
  final double fontSize;
  final List<String> movesSans;

  const SimpleMovesHistory({
    super.key,
    required this.movesSans,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (ctx2, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
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
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
