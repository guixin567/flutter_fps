import 'package:flutter/material.dart';
import 'package:fps_test20/fps/entity/fps_entity.dart';
import 'package:fps_test20/fps/util/fps_manager.dart';

class FpsPainter extends CustomPainter {
  FpsPainter();

  double maxYData = 140;

  @override
  void paint(Canvas canvas, Size size) {
    ///坐标
    drawAxisDiagram(canvas, size);

    ///Y轴文本
    drawAxisText(canvas, size);

    drawBar(canvas, size);

    ///帧流畅度数据
    /// 是否卡顿的支撑是数据 流畅比 最大耗时 平均耗时 平均帧率
    drawDescription(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  ///坐标图
  void drawAxisDiagram(Canvas canvas, Size size) {
    canvas.drawCircle(Offset.zero, 4, Paint());

    var paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var path = Path()
      ..moveTo(0, 10)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);

    canvas..drawPath(path, paint);
  }

  ///Y 轴文字和横线
  void drawAxisText(Canvas canvas, Size size) {
    final List<int> yData = [16, 33, 66, 100];
    yData.asMap().forEach((key, value) {
      var textPainter = TextPainter(
          text: TextSpan(
              text: value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 10)),
          textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: 24);

      double offsetX = -textPainter.size.width - 6;
      double offsetY = (1 - value / maxYData) * size.height;
      double offsetTextY = offsetY - textPainter.size.height / 2;
      textPainter..paint(canvas, Offset(offsetX, offsetTextY));

      canvas.drawLine(
          Offset(0, offsetY), Offset(-4, offsetY), Paint()..strokeWidth = 1);
    });
  }

  ///柱状图
  void drawBar(Canvas canvas, Size size) {
    double rectWidth = ((size.width - 10) / FpsManager.instance.maxFrameCount);
    final List<int> yData =
        FpsManager.instance.fpsList.map((e) => e.value.toInt()).toList();
    yData.asMap().forEach((index, value) {
      double offsetY = (1 - value / maxYData) * size.height;
      double yHeight = (value / maxYData) * size.height;
      var paint = Paint();
      if (value < 18) {
        paint.color = Colors.green;
      } else if (value < 33) {
        paint.color = Colors.blue;
      } else if (value < 66) {
        paint.color = Colors.yellow;
      } else {
        paint.color = Colors.red;
      }
      canvas.drawRect(
          Rect.fromLTWH(
              (index + 1).toDouble() * rectWidth, offsetY, 1, yHeight),
          paint);
    });
  }

  /// 流畅比 最大耗时 平均耗时
  void drawDescription(Canvas canvas, Size size) {
    String description = "平均耗时:${FpsManager.instance.getAverageFrameTime()} 最大耗时:${FpsManager.instance.maxFrameTime} 流畅比:${FpsManager.instance.getSmoothPercent()}";
    TextPainter(text: TextSpan(text: description,style: TextStyle(color: Colors.grey,fontSize: 12)),textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, Offset(20,20));
  }
}
