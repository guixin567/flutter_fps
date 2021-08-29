import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fps_test20/fps/config/color_cons.dart';
import 'package:fps_test20/fps/util/fps_manager.dart';

import 'fps_diagram.dart';

class FpsEntrance extends StatefulWidget {
  final Widget child;

  FpsEntrance(this.child);

  @override
  _FpsEntranceState createState() => _FpsEntranceState();
}

class _FpsEntranceState extends State<FpsEntrance> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget?.child,
        if (FpsManager.instance.isShowFpsPop) Column(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                     setState(() {
                       FpsManager.instance.isShowFpsPop = false;
                     });
                    },
                    child: Container(
                      color: ColorCons.translateGrey,
                    ),
                  )),
                  FpsDiagram(),
                ],
              ) else PositionedDirectional(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 2, top: 4, bottom: 4, right: 2),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.lock_open_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            FpsManager.instance.isShowFpsPop = true;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            FpsManager.instance.isFpsRunning = !FpsManager.instance.isFpsRunning;
                          });
                        },
                        child: Icon(
                          FpsManager.instance.isFpsRunning?Icons.play_arrow:Icons.pause,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: 20,
                end: 20,
              )
      ],
    );
  }
}
