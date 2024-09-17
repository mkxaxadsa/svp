import 'package:flutter/material.dart';

class SlotWidget extends StatelessWidget {
  const SlotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: 340,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffFF5E60),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        height: 326,
        width: 326,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: const Color(0xff441A5B),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff7E114D),
              Color(0xff56117E),
            ],
          ),
        ),
        child: const Column(
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(width: 4),
                _Slot(7),
                SizedBox(width: 4),
                _Slot(6),
                SizedBox(width: 4),
                _Slot(3),
                SizedBox(width: 4),
                _Slot(4),
                SizedBox(width: 4),
                _Slot(5),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(width: 4),
                _Slot(1),
                SizedBox(width: 4),
                _Slot(2),
                SizedBox(width: 4),
                _Slot(3),
                SizedBox(width: 4),
                _Slot(4),
                SizedBox(width: 4),
                _Slot(5),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(width: 4),
                _Slot(1),
                SizedBox(width: 4),
                _Slot(2),
                SizedBox(width: 4),
                _Slot(3),
                SizedBox(width: 4),
                _Slot(4),
                SizedBox(width: 4),
                _Slot(5),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(width: 4),
                _Slot(1),
                SizedBox(width: 4),
                _Slot(2),
                SizedBox(width: 4),
                _Slot(3),
                SizedBox(width: 4),
                _Slot(4),
                SizedBox(width: 4),
                _Slot(5),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(width: 4),
                _Slot(1),
                SizedBox(width: 4),
                _Slot(2),
                SizedBox(width: 4),
                _Slot(3),
                SizedBox(width: 4),
                _Slot(4),
                SizedBox(width: 4),
                _Slot(5),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot(this.id);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFAE00),
            Color(0xffFF5D60),
          ],
        ),
      ),
      child: Image.asset('assets/slot/$id.png'),
    );
  }
}
