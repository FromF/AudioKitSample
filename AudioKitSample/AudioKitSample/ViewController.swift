//
//  ViewController.swift
//  AudioKitSample
//
//  Created by 藤　治仁 on 2019/01/02.
//  Copyright © 2019 FromF.github.com. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var playInfoLabel: UILabel!
    
    private var bgmPlayer : AKPlayer!
    private var timePitch : AKTimePitch!
    private var intervalTimer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupAudioKit()
        startTimer()
    }

    // MARK: - Audiokit
    private func setupAudioKit() {
        //mp3ファイル名を指定する
        let bgmfile = try! AKAudioFile(readFileName: "Kisma - Fingertips [NCS Release].mp3")
        
        //mp3ファイルを読み込みする
        bgmPlayer = AKPlayer(audioFile: bgmfile)
        bgmPlayer.completionHandler = {
            print("Playback completed.")
            //不具合対策:再生終了した時点でpauseTimeプロパティーを初期化する
            self.bgmPlayer.pauseTime = self.bgmPlayer.loop.start
        }
        
        //BGMは再生速度を変更するのでAKTimePitchにinputする
        timePitch = AKTimePitch(bgmPlayer, rate: 1.0, pitch: 0.0, overlap: 8.0)
        
        //AudioKitにAKTimePitchの結果を入れる
        AudioKit.output = timePitch
        try! AudioKit.start()
    }
    
    private func changePlaySpeed(rate:Double) {
        //音程を変えずに再生速度変える
        timePitch.rate = rate
        timePitch.pitch = (rate - 1.0) * -100
    }
    
    // MARK: - Timer
    private func startTimer() {
        intervalTimer = Timer.scheduledTimer(timeInterval: 0.05,
                                             target: self,
                                             selector: #selector(self.timerInterrupt(_:)),
                                             userInfo: nil,
                                             repeats: true)
        if let timer = intervalTimer {
            timerInterrupt(timer)
        }
    }
    
    private func stopTimer() {
        if let timer = intervalTimer {
            if timer.isValid == true {
                timer.invalidate()
            }
        }
    }
    
    @objc func timerInterrupt(_ timer:Timer) {
        let pauseTime = bgmPlayer.pauseTime ?? bgmPlayer.currentTime
        let currentTime = bgmPlayer.currentTime > pauseTime ? bgmPlayer.currentTime : pauseTime
        let totalTime = bgmPlayer.duration
        
        playInfoLabel.text = "\(String(format: "%.01f", currentTime))/\(String(format: "%.01f", totalTime)) (\(String(format: "%.01f", timePitch.rate))x)"
    }
    
    // MARK: - ButtonDisplayUpdate
    private func playStopButtonUpdate() {
        let isStarted = bgmPlayer.isStarted
        
        if !isStarted {
            startStopButton.setImage(UIImage(named: "BtnPlay"), for: .normal)
        } else {
            startStopButton.setImage(UIImage(named: "BtnPause"), for: .normal)
        }
    }

    // MARK: - Button
    @IBAction func startStopButtonAction(_ sender: Any) {
        let isStarted = bgmPlayer.isStarted
        if !isStarted {
            bgmPlayer.resume()
            //不具合対策:pauseTimeプロパーティの影響で書き換わるプロパティーを補正する
            bgmPlayer.startTime = bgmPlayer.loop.start
        } else {
            //不具合対策:現在再生時間を一時停止後にpauseTimeプロパティーに設定する
            let currentTime = bgmPlayer.currentTime
            bgmPlayer.stop()
            bgmPlayer.pauseTime = currentTime
        }
        playStopButtonUpdate()
    }
    
    // MARK: - Slider
    @IBAction func speedSliderAction(_ sender: UISlider) {
        changePlaySpeed(rate: Double(sender.value))
    }
    
}

