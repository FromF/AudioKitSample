# AudioKitSampleProject

これは、 [AudioKit](https://github.com/AudioKit/AudioKit) を使ったサンプルコードです。  
AKPlayerとAKTimePitchを使って再生中の音楽の再生速度を変更します。  

---
This is sample code using [AudioKit](https://github.com/AudioKit/AudioKit).  
Use AKPlayer and AKTimePitch to change the playback speed of the music being played.  

## 一時停止できない不具合について(About troubles that can not be paused)

AKPlayerの`pause()` `resume()` が正しく動かないことがAudioKit 4.5.5では確認されています。  
本プロジェクトでは `pause`プロパティー及び `starTime`プロパティーを値代入で回避しています。  

---
AudioKit 4.5.5 has confirmed that AKPlayer `pause ()` `resume ()` does not work properly.  
In this project, the `pause` property and` starTime` property are avoided by value assignment.  

## アイコンなど使用リソースについて(About used resource such as icon)

* 再生ボタン(Play button)  
* 一時停止ボタン(Pause button)  
https://www.iconfinder.com/iconsets/freecns-cumulus  

* 亀とうさぎ(Turtles and rabbits)  
https://www.iconfinder.com/iconsets/free-android-icons-animals  

* Kisma - Fingertips [NCS Release]  
https://youtu.be/LJeiQw2RmSg

## Issue

* [AKPlayer (pause, isPaused) is broken #1566](https://github.com/AudioKit/AudioKit/issues/1566)  
* [AKPlayer Pause / Resume Capability? #1272](https://github.com/AudioKit/AudioKit/issues/1272)
