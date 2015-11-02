//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Anton Vasilyev on 10/19/15.
//  Copyright © 2015 Anton Vasilyev. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    var receivedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("%@", receivedAudio.filePathUrl)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlow(sender: AnyObject) {
        playWithRate(0.5)
    }
    
    func playWithRate(rate: Float) {
        stopAudio()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }

    @IBAction func playFast(sender: AnyObject) {
        playWithRate(2.0)
    }
    
    @IBAction func stopAll(sender: AnyObject) {
        stopAudio()
    }
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playHighPitch(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playLowPitch(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playWithReverb(sender: AnyObject) {
        playAudioWithReverb()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playSound(changePitchEffect)
    }
    
    func playAudioWithReverb() {
        let unitReverb = AVAudioUnitReverb()
        unitReverb.wetDryMix = 50
        playSound(unitReverb)
    }
    
    func playSound(audioEffectNode: AVAudioNode) {
        stopAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(audioEffectNode)
        
        audioEngine.connect(audioPlayerNode, to: audioEffectNode, format: nil)
        audioEngine.connect(audioEffectNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
}
