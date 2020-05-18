//#-hidden-code
import SpriteKit
showClock()
currentPage = Page.second
for bt in sceneViewController.skScene.buttonsList{
    if bt == sceneViewController.skScene.firstButton{
        bt.isHidden = false
    }else {
        bt.isHidden = true
    }
}
sceneViewController.skScene.playButton.fillColor = .white
sceneViewController.skScene.playButton.fillTexture = SKTexture.init(image: UIImage(named: "Play")!)
//#-end-hidden-code
//#-code-completion(everything, show)
/*:
 **Rhythm:** Can we play something?
 
 Ok, now you know how to position a sound circle in a specific beat.
 
 Now you can play the rhythm to verify if it's in your wanted tempo.
 
 To play tap the play button and to stop tap the stop in the same button.
 
 When you tap play, the clock pointer will move to indicate the progress of our rhythm.
 
 After this, you can to to the [Next Page](@next).
*/
