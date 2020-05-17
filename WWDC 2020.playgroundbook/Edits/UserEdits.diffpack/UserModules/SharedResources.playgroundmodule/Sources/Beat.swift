import AVFoundation
import UIKit
import Foundation

//  public enum SoundElement{
//      case kick
//      case snare
//      case hihat
//      case cowbell
//      case conga
//      case conga2
//      
//      public var description: String {
//          switch self {
//          case .kick: return "kick"
//          case .hihat: return "hihat"
//          case .snare: return "snare"
//          case .cowbell: return "cowbell"
//          case .conga: return "conga"
//          case .conga2: return "conga2"
//          }
//      }
//      
//      public var file: URL{
//          let bundle = Bundle.main
//          switch self {
//          case .kick:
//              return bundle.url(forResource: "kick", withExtension: "mp3")!
//          case .snare:
//              return bundle.url(forResource: "snare", withExtension: "mp3")!
//          case .hihat:
//              return bundle.url(forResource: "hihat", withExtension: "mp3")!
//          case .cowbell:
//              return bundle.url(forResource: "cowbell", withExtension: "mp3")!
//          case .conga:
//              return bundle.url(forResource: "conga", withExtension: "mp3")!
//          case .conga2:
//              return bundle.url(forResource: "conga2", withExtension: "mp3")!
//          default:
//              break
//          }
//      }
//  }

public class BeatPlayer {
    var audioFiles: [AVAudioFile] = []
    var engine: AVAudioEngine
    var audioAudioNodes = [AVAudioPlayerNode]()
    var mixer: AVAudioMixerNode
    var urls: [SoundElement] = []
    var isPlaying: Bool = false
    
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
        for node in audioAudioNodes {
            engine.attach(node)
            engine.connect(node, to: mixer, format: nil)
        }
        try! engine.start()
    }

    public func stop(){
        try! engine.stop()
    }
    
    public func playSequence(sequence: [PositionNode], totalTime: Double, quantity: Double){
        var interval = totalTime / quantity
        DispatchQueue.global().async { [unowned self] in
            while(self.isPlaying == true){
                for element in sequence {
                    guard self.isPlaying == true else {
                        break
                        return
                    }
                    var index: Int {
                        var value = -1
                        switch element.occupedWith {
                        case .kick: value = 0
                        case .hihat: value = 1
                        case .snare: value = 2
                        case .cowbell: value = 3
                        case .conga: value = 4
                        case .conga2: value = 5
                        default: value = -1
                        }
                        return value
                    }
                    if index != -1{
                        let node = self.audioAudioNodes[index]
                        node.scheduleFile(self.audioFiles[index], at: nil, completionHandler: nil)
                        node.play()
                    }
                    Thread.sleep(forTimeInterval: interval)
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

