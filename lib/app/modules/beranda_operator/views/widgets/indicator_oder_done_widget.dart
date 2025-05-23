import 'package:flutter/material.dart';

class IndicatorOderDoneWidget extends StatelessWidget {
  const IndicatorOderDoneWidget({
    super.key,

    required this.position,
    required this.title,
    required this.number,
  });

  final String position;
  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.grey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft:
                position == 'left' ? Radius.circular(10) : Radius.circular(0),
            bottomLeft:
                position == 'left' ? Radius.circular(10) : Radius.circular(0),
            topRight:
                position == 'right' ? Radius.circular(10) : Radius.circular(0),
            bottomRight:
                position == 'right' ? Radius.circular(10) : Radius.circular(0),
          ),
        ),
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    number,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
