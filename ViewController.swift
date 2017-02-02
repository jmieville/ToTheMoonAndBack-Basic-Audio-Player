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
    
    
    var timer = Timer()
    let audioPath = Bundle.main.path(forResource: "Beethoven-Wind-Octet", ofType: "mp3")
    
   

    @IBOutlet weak var currentPlayTime: UILabel!
    
    func updateProgressSlider() {
        progressBar.value = Float(player.currentTime)
        currentPlayTime.text = String(round(player.currentTime))
    }
    
    @IBAction func play(_ sender: AnyObject) {
        player.play()
//        var progress = player.currentTime / player.duration
//        progressBar.setValue(Float(progress), animated: false)

//        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateProgressSlider), userInfo: nil, repeats: true)

    }
    
    func updateProgress() {
        var progress = player.currentTime / player.duration
        progressBar.setValue(Float(progress), animated: false)
    }
    
    @IBAction func pause(_ sender: AnyObject) {
        player.pause()
        timer.invalidate()
        
    }
    @IBAction func stop(_ sender: AnyObject) {
        player.stop()
        
        timer.invalidate()
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            
        } catch {
            // process any error
            
        }
        
        progressBar.value = 0
        currentPlayTime.text = "0"
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        player.volume = slider.value
    }
    @IBOutlet weak var slider: UISlider!
    var player = AVAudioPlayer()
    
    @IBOutlet weak var progressBar: UISlider!
    @IBAction func progressChange(_ sender: AnyObject) {

        player.currentTime = TimeInterval(progressBar.value)
        
        
        
    }
    
    
    
    @IBOutlet weak var timePlay: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.timePlay.text = String(round(player.duration))
        self.currentPlayTime.text = "0"

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timePlay.text = ""
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
      
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            progressBar.maximumValue = Float(player.duration)
            

        } catch {
            // process any error
            
        }
        
        //_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.progressChange(_:)), userInfo: nil, repeats: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

