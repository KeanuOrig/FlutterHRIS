import 'package:flutter/material.dart';

class SunMoonSwitchTile extends StatefulWidget {
  final bool isAfternoon;
  final ValueChanged<bool> onChanged;

  const SunMoonSwitchTile({
    super.key, 
    required this.isAfternoon,
    required this.onChanged,
  });

  @override
  SunMoonSwitchTileState createState() => SunMoonSwitchTileState();
}

class SunMoonSwitchTileState extends State<SunMoonSwitchTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: ListTile(
        title: Text(widget.isAfternoon ? 'Afternoon' : 'Morning'),
        trailing: GestureDetector(
          onTap: () {
            widget.onChanged(!widget.isAfternoon);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 53.0,
            height: 33.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: widget.isAfternoon ? Colors.blueGrey : Colors.orange[300],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  left: widget.isAfternoon ? 25.0 : 0.0,
                  right: widget.isAfternoon ? 0.0 : 25.0,
                  top: 5.0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: widget.isAfternoon
                        ? Icon(
                            Icons.nights_stay,
                            color: Colors.white,
                            size: 24.0,
                            key: UniqueKey(),
                          )
                        : Icon(
                            Icons.wb_sunny,
                            color: Colors.white,
                            size: 24.0,
                            key: UniqueKey(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
