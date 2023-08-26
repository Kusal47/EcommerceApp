import 'package:flutter/material.dart';

import '../Dimension/height_width.dart';
import 'small_font.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({super.key, required this.text});
  final String text;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String primary;
  late String secondary;

  double textHeight = 0.0;
  bool hiddenText = true;

  @override
  void initState() {
    super.initState();
    textHeight = Dimensions.screenHeight / 4.5;
    if (widget.text.length > textHeight) {
      primary = widget.text.substring(0, textHeight.toInt());
      secondary =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      primary = widget.text;
      secondary = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondary.isEmpty
          ? SmallTextSize(
              text: primary,
              size: Dimensions.font16,
              color: Colors.black87,
            )
          : Column(children: [
              SmallTextSize(
                color: Colors.black87,
                text: hiddenText ? (primary + "...") : (primary + secondary),
                size: Dimensions.font16,
                height: 1.4,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    hiddenText = !hiddenText;
                  });
                },
                child: Row(children: [
                  SmallTextSize(
                    text: hiddenText ? 'Show more' : 'Show less',
                    color: Color.fromARGB(255, 7, 10, 206),
                    size: Dimensions.font16,
                  ),
                  Icon(
                    hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    color: Color.fromARGB(255, 7, 10, 206),
                  ),
                ]),
              ),
            ]),
    );
  }
}
