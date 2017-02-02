//
//  ViewController.swift
//  Audio Player
//
//  Created by Jean-Marc Kampol Mieville on 10/13/2559 BE.
//  Copyright © 2559 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet weak var songName: UINavigationItem!
    @IBOutlet weak var currentPlayTime: UILabel!
    @IBAction func play(_ sender: AnyObject) {
        isPlaying = true
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateProgressSlider), userInfo: nil, repeats: true)
            pauseBtn.isEnabled = isPlaying
            pauseBtn.tintColor = UIColor.red
            stopBtn.isEnabled = isPlaying
            stopBtn.tintColor = UIColor.red
            playBtn.isEnabled = !isPlaying
            playBtn.tintColor = UIColor.clear
    }
    
    @IBAction func pause(_ sender: AnyObject) {
        player.pause()
        timer.invalidate()
        playBtn.isEnabled = isPlaying
        playBtn.tintColor = UIColor.red
    }
    @IBAction func stop(_ sender: AnyObject) {
        player.stop()
        timer.invalidate()
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
        }
        isPlaying = false
        progressBar.value = 0
        currentPlayTime.text = "0"
        pauseBtn.isEnabled = isPlaying
        pauseBtn.tintColor = UIColor.clear
        stopBtn.isEnabled = isPlaying
        stopBtn.tintColor = UIColor.clear
        playBtn.isEnabled = !isPlaying
        playBtn.tintColor = UIColor.red

    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        player.volume = slider.value
    }
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressBar: UISlider!
    @IBAction func progressChange(_ sender: AnyObject) {
        player.currentTime = TimeInterval(progressBar.value)
    }
    @IBOutlet weak var timePlay: UILabel!
    @IBOutlet weak var playBtn: UIBarButtonItem!
    @IBOutlet weak var pauseBtn: UIBarButtonItem!
    @IBOutlet weak var stopBtn: UIBarButtonItem!
    
    var player = AVAudioPlayer()
    var timer = Timer()
    let audioPath = Bundle.main.path(forResource: "Beethoven-Wind-Octet", ofType: "mp3")
    var isPlaying = false
    
    func updateProgressSlider() {
        progressBar.value = Float(player.currentTime)
        currentPlayTime.text = String(round(player.currentTime))
    }
    func updateProgress() {
        var progress = player.currentTime / player.duration
        progressBar.setValue(Float(progress), animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.timePlay.text = String(round(player.duration))
        self.currentPlayTime.text = "0"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isPlaying == false {
            pauseBtn.isEnabled = isPlaying
            pauseBtn.tintColor = UIColor.clear
            stopBtn.isEnabled = isPlaying
            stopBtn.tintColor = UIColor.clear
            playBtn.isEnabled = !isPlaying
            playBtn.tintColor = UIColor.red
        }
        self.timePlay.text = ""
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            progressBar.maximumValue = Float(player.duration)
        } catch {
        }
    }
}

