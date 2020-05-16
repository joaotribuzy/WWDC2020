import AVFoundation
import UIKit

public class BeatPlayer {
    var audioFiles: [AVAudioFile] = []
    var engine: AVAudioEngine
    var audioAudioNodes = [AVAudioPlayerNode]()
    var mixer: AVAudioMixerNode
    var urls: [SoundElement] = []
    var isPlaying: Bool = true
    
    public init (urls: [SoundElement] = []) {
        audioFiles = urls.map { try! AVAudioFile(forReading: $0.file) }
        
        engine = AVAudioEngine()
        mixer = AVAudioMixerNode()
        
        engine.attach(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        self.urls = urls
        for _ in audioFiles {
            audioAudioNodes += [AVAudioPlayerNode()]
        }
    }
    
    public func start() {
        try! engine.start()
        
        for node in audioAudioNodes {
            engine.attach(node)
            engine.connect(node, to: mixer, format: nil)
        }
        try! engine.start()
    }
    
    public func playSequence(sequence: [PositionNode], totalTime: Double, quantity: Double){
        var interval = totalTime / quantity
        DispatchQueue.global().async { [unowned self] in
            while(self.isPlaying == true){
                for element in sequence {
                    Thread.sleep(forTimeInterval: interval)
                    var index: Int {
                        var value = -1
                        switch element.occupedWith {
                        case .kick:
                            value = 0
                        case .hihat:
                            value = 1
                        case .snare:
                            value = 2
                        default:
                            value = -1 
                        }
                        return value
                    }
                    if index != -1{
                        let node = self.audioAudioNodes[index]
                        node.scheduleFile(self.audioFiles[index], at: nil, completionHandler: nil)
                        node.play()
                    }
                }
            }
        }
    }
    
    public func playBeat(withIndex: Int){
        DispatchQueue.global().async{ [unowned self] in
            let node = self.audioAudioNodes[withIndex]
            node.stop()
            node.scheduleFile(self.audioFiles[withIndex], at: nil, completionHandler: nil)
            node.play()
        }
    }
    
    
}


