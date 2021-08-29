import 'dart:math';

import 'package:fps_test20/fps/entity/fps_entity.dart';

class FpsManager{

  ///单例
  static FpsManager _instance;
  static FpsManager get instance{
    if(_instance == null){
      _instance = FpsManager._();
    }
    return _instance;
  }
  FpsManager._();

  ///展开Fps弹窗
  bool isShowFpsPop = false;

  ///Fps正在运行
  bool isFpsRunning = false;

  ///最大帧数
  int maxFrameCount = 200;
  ///一帧最大耗时
  double maxFrameTime = 0;
  ///总耗时
  double totalFrameTime = 0;

  ///当前总帧数
  int currentFrameCount = 0;
  ///流畅帧数
  int smoothFrameCount = 0;
  ///一般帧数
  int normalFrameCount = 0;
  ///轻微卡顿帧数
  int slightSlowFrameCount = 0;
  ///卡顿帧数
  int slowFrameCount = 0;

  ///所有帧数据
  List<FpsEntity> fpsList = [];

  ///添加帧
  addFrame(FpsEntity entity){
    if(fpsList.length == maxFrameCount){
      var removeFrameTime = fpsList.removeAt(0).value;
      totalFrameTime -= removeFrameTime;
      updateFrameClass(removeFrameTime, false);
      currentFrameCount -= 1;
    }

    updateFrameClass(entity.value,true);
    currentFrameCount += 1;
    fpsList.add(entity);
    totalFrameTime += entity.value;
    maxFrameTime = max(maxFrameTime, entity.value);
  }


  ///平均每帧耗时
  getAverageFrameTime() => (totalFrameTime/currentFrameCount).toStringAsFixed(1);

  ///流畅比
  getSmoothPercent() => (smoothFrameCount/currentFrameCount).toStringAsFixed(2);

  ///对数据进行 流畅 一般 轻微卡顿 卡顿 划分
  void updateFrameClass(double frameTime,bool isAdd) {
    if(frameTime <= 18){
      isAdd ? smoothFrameCount += 1 : smoothFrameCount -= 1;
    }else if(frameTime <= 33){
      isAdd ? normalFrameCount += 1 : normalFrameCount -= 1;
    }else if(frameTime <= 66){
      isAdd ? slightSlowFrameCount += 1 : slightSlowFrameCount -= 1;
    }else{
      isAdd ? slowFrameCount += 1 : slowFrameCount -= 1;
    }
  }











}