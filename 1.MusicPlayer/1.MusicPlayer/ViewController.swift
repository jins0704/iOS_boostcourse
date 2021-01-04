//
//  ViewController.swift
//  1.MusicPlayer
//
//  Created by 홍진석 on 2021/01/04.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK:- Properties
    var player : AVAudioPlayer!
    var timer : Timer!
    
    // MARK:- IBOutlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK:- Methods
    func initialPlayer(){
        guard let soundAsset = NSDataAsset(name: "sound")else{
            print("Error")
            return
        }
        do{
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        }catch _ as NSError{
            print("Error")
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }
    
    func updateTime(time : TimeInterval){
        let minute : Int = Int(time/60)
        let second : Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond : Int = Int(time.truncatingRemainder(dividingBy: 1)*100)
        let timeText : String = String(format: "%02ld:%02ld:%02ld",minute,second,milisecond)
        timeLabel.text = timeText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPlayer()
    }
    
    func invalidateTimer(){
        self.timer.invalidate()
        self.timer = nil
    }
    
    func makeFireTimer(){
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block:{ (timer : Timer) in
            
            if self.progressSlider.isTracking {return}
            
            self.updateTime(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
            
        })
        self.timer.fire()
    }
    // MARK:- IBActions
    @IBAction func playAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{
            self.player?.play()
            
        }else{
            self.player?.pause()
        }
        
        if sender.isSelected{
            self.makeFireTimer()
            
        }else{
            self.invalidateTimer()
        }
    }
    
    @IBAction func moveSlider(_ sender: UISlider) {
        self.updateTime(time: TimeInterval(sender.value))
        if sender.isTracking {return}
        self.player.currentTime = TimeInterval(sender.value)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTime(time: 0)
        self.invalidateTimer()
        
        let message = "종료되었습니다."
        let alert : UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction(title: "확인", style: .default,handler: nil)
        alert.addAction(okAction)
        self.present(alert,animated: true,completion: nil)
    }
}

