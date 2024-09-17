import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RulesDialog extends StatelessWidget {
  const RulesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            Container(
              // height: 510,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffFF8E8E),
                    blurRadius: 25,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 475,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 25),
                      decoration: const BoxDecoration(),
                      child: Container(
                        height: 500,
                        decoration: const BoxDecoration(),
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xffE2229C),
                                Color(0xffE22225),
                              ],
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff007FFF),
                                  Color(0xff003C78),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -13,
                    child: CupertinoButton(
                      onPressed: () {
                        context.pop();
                      },
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset('assets/close.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CupertinoButton(
                onPressed: () {
                  context.pop();
                },
                padding: EdgeInsets.zero,
                child: SvgPicture.asset('assets/ok.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
