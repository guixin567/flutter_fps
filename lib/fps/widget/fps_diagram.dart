import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fps_test20/fps/widget/fps_painter.dart';
import 'package:fps_test20/fps/widget/group/group_page.dart';

class FpsDiagram extends StatefulWidget {
  @override
  _FpsDiagramState createState() => _FpsDiagramState();
}

class _FpsDiagramState extends State<FpsDiagram> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 340,
          width: double.infinity,
          padding: EdgeInsets.only(left: 25,right: 20),
          child: CustomPaint(
            painter: FpsPainter(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 10,),
            Expanded(child: ElevatedButton(onPressed: () {

            }, child: Text("添加分组"))),
            SizedBox(width: 6,),
            Expanded(child: Builder(
              builder: (context){
               return ElevatedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return GroupPage();
                  }));
                }, child: Text("分组列表"));

                // return GestureDetector(
                //   onTap: (){
                //        Navigator.of(context).push(MaterialPageRoute(builder: (context)
                //        {
                //          return GroupPage();
                //        }));
                //   },
                //   child: Text("分组列表"),
                // );
              },
            )),
            SizedBox(width: 10,),
            // ElevatedButton(onPressed: () {}, child: Text("添加分组")),
            // ElevatedButton(onPressed: () {}, child: Text("分组列表")),
          ],
        ),
      ],
    );
  }
}
