import PlaygroundSupport
import UIKit

public var scene = RhythmGameViewController()

/// Show a circular representation of Rhythm
public func showClock(){
    PlaygroundPage.current.needsIndefiniteExecution = true

    PlaygroundPage.current.setLiveView(scene)
}
