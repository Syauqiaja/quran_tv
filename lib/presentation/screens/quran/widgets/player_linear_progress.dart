import 'package:flutter/material.dart';

class PlayerLinearProgress extends StatelessWidget {
  final double value;
  const PlayerLinearProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 2,
              width: double.infinity,
              color: Colors.white30,
            ),
          ),
          FractionallySizedBox(
            widthFactor: value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
