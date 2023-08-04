import 'package:flutter/material.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  SeeMoreText({required this.text, this.maxLines = 2});

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      style: TextStyle(fontSize: 16),textAlign: TextAlign.start,
      maxLines: _isExpanded ? null : widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: textWidget,
          secondChild: Text(
            widget.text,
            style: TextStyle(fontSize: 16),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              Text(
                _isExpanded ? 'See less' : 'See more',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFF8000) ,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(_isExpanded ? Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined, color: Color(0xFFFF8000) ,size: 15,)
            ],
          ),
        ),
      ],
    );
  }
}
