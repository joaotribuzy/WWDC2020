//#-hidden-code
showClock()
sceneViewController.skScene.playButton.isHidden = true
for bt in sceneViewController.skScene.buttonsList{
    if bt == sceneViewController.skScene.firstButton{
        bt.isHidden = false
    }else {
        bt.isHidden = true
    }
}
sceneViewController.skScene.pointer.isHidden = true
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, showClock())
/*:
**Rhythm:** Let's see this by other way...

'Rhythm' is one of the three pilars of music('Harmony', 'Melody' and 'Rhythm') and commoly represented with others in a music score.
 
 But... let's do something... let's try to see a other way to "see" 'Rhythm'

 I'll show you some tools to help you to make this.
 
 First, when you press *"Run my Code"*, you'll see a clock and a little circle that have a sound into then.
 
 Try to drag the circle to one of positions of the clock. When you make this, you  are positioning a sound on a determinated beat of a rhythm... after you can go to next page...
*/
