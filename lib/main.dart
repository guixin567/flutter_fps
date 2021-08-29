import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fps_test20/fps/entity/fps_entity.dart';
import 'package:fps_test20/fps/util/fps_manager.dart';
import 'package:fps_test20/fps/widget/fps_entrance.dart';
import 'package:fps_test20/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.light()),
      home: MyHomePage(),
      builder: (context,child){
        return FpsEntrance(child);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addTimingsCallback((timings) {
      timings.forEach((element) {
        FpsManager.instance.addFrame(FpsEntity()..value = element.totalSpan.inMilliseconds.toDouble());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("fps current count:${FpsManager.instance.currentFrameCount}");
    print("fps average time:${FpsManager.instance.getAverageFrameTime()}");
    print("fps smooth count:${FpsManager.instance.smoothFrameCount}");
    print("fps normal count:${FpsManager.instance.normalFrameCount}");
    print("fps slight count:${FpsManager.instance.slightSlowFrameCount}");
    print("fps slow count:${FpsManager.instance.slowFrameCount}");
    return Scaffold(
      appBar: AppBar(
        title: Text("test fps"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return SecondPage();
                  }));
                });
              },
              child: Text("on press")),
        ],
      ),
    );
  }
}
