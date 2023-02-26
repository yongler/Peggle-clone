# CS3217 Problem Set 4

**Name:** Lee Yong Ler

**Matric No:** A0219859J


## Tips
1. CS3217's docs is at https://cs3217.github.io/cs3217-docs. Do visit the docs often, as
   it contains all things relevant to CS3217.
2. A Swiftlint configuration file is provided for you. It is recommended for you
   to use Swiftlint and follow this configuration. We opted in all rules and
   then slowly removed some rules we found unwieldy; as such, if you discover
   any rule that you think should be added/removed, do notify the teaching staff
   and we will consider changing it!

   In addition, keep in mind that, ultimately, this tool is only a guideline;
   some exceptions may be made as long as code quality is not compromised.
3. Do not burn out. Have fun!

## Notes
If you have changed the specifications in any way, please write your
justification here. Otherwise, you may discard this section.

how one aims the cannon in the rules of the game.

exact rules of the game modes that you end up implementing and how a player chooses them, always document them with the greatest detail in your Developer Guide

You are free to decide how they look, the resulting animations or transitions, or any extensions you would like to implement. Remember to document them with the greatest detail in your Developer Guide.

Own behaviours added: 
1. Player can drag the ball around and tap it to launch the ball. Magnitude and direction is controlled by relative position of ball to top center of screen. 

## Dev Guide
You may put your dev guide either in this section, or in a new file entirely.
You are encouraged to include diagrams where appropriate in order to enhance
your guide.

### Class diagrams
Code now follows MVVM structure for better seperation of code as compared to previous MV pattern. 

### Models
![image](https://user-images.githubusercontent.com/68801331/218320230-46683487-d5a6-420a-b7f7-118e69d29075.png)


Model objects and physics objects that represent them are seperated to provide an abstraction and seperation of code. i.e. the model does not need to know about the physics object representation. Example would be peg object in board has a corresponding pegphysics object belonging in gameengine. This introduces loose coupling. 

Models are split into 3 main category, game engine, board and board store. 
1. Game engine category consists of `GameEngine` and `PeggleGameEngine`, which is in charge of all the kinematics and dynamics.  GameEngine moves PhysicsObjects based on their Acceleration and Velocity. PeggleGameEngine then adds adiditional peggle specify behaviours such as lighting up pegs that are hit, triggering power ups, keeping the score and determining win lose. 
2. CirclePHysicsObject and RectanglePhysicsObject inherit from PhsyicsObject. 
3. Board object have their own associated PhysicsObject acting as a wrapper to be process in the GameEngine. i.e. Peg is wrapped with PegPhysicsObject by PeggleGameEngine before passing into GameEngine for processing. 

### ViewModels 


GameViewModel acts as the entry point of view to model for game related mechanics. It also acts as the view model for game related tasks that correspond to UI actions from game related views. i.e. 

1. launching ball, 
2. choosing game mode. 
3. initailizing `PeggleGameEngine`, `CADisplayLink` and call the update function from `PeggleGameEngine` every frame. on every update, update the board with the new one from `PeggleGameEngine`. 
5. initializing and maintaing timer 
6. stopping the game when user win or lose
7. telling the views what images to show, the size, appeareance and also location. i.e. GamePegView, BlockView, BucketView

PaletteViewModel acts as the view model for palette related tasks that correspond to UI actions from palette related views. i.e. 
1. load, save, reset board actions
2. adding, removing, rotating, resizing actions 
3. telling the views what images to show, the size, appeareance and also location. i.e. PalettePegView, BlockView



### Views 


Views are seperated into smaller views responsible for rendering 1 component. Main view then overlays all the smaller views. i.e. PaletteView overlays PaletteBoardView, PaletteActionButtonsView, PaletteDesignBUttonsViews.
1. PaletteBoardView overlays the smaller views, resulting in rendering the background, board pegs, board blocks
2. PaletteActionButtonsView have the load, save, reset, save buttons. 
3. PaletteDesignBUttonsViews have the game assets related buttons for user to add or edit the game area assets. 

GameBoardVIew overlays GamePegView, BlockView, GameBallView,GameHeaderView, GameMenuView, BucketView, CannonView.
1. GameHeaderView renders the top most game details such as score, timer and orange pegs left. It also shows the score for the beat the score game mode. 
2. GameMenuView shows the game modes available for user to choose before starting to play. 



### Sequence diagrams
Observer pattern is used. Whenever the board model instance changes, views that observes it will be automatically rerendered to update. (functionality of `@Published` and `ObservedObject` in SwiftUI) 

- Entering the app 
1. In the menu, user can choose to play or design 
2. Play shows all levels that are playable
3. design shows all levels and a createnew level button

- Designing and save level
1. User can click on any existing level to edit or click on create new level to create new level. 
2. In palette, user can click on the assets related buttons and tap on the game area to add the game asset at the tapped location if it is valid. 
3. user can tap on existing asset on game area and slide the resize or rotate slider to adjust the asset 
4. user tap save to save level
5. user sees level in levels menu 

- Playing a game
1. User click on 'play' in main menu
2. user selects level to play
3. user select game mode
4. user play by dragging the cannon to the direction to launch and on released, ball is launched
5. user can launch ball again when ball exits game area
6. user wins or lose depending on game mode when `PeggleGameEngine` pass the current score, timeleft and board. 

- Game loop
1. When a board is rendered, it autmotically calls `PeggleGameEngine.updateGameArea` which updates gameArea of the board, set ball to initial position, set board objects into phsyics objects into game engine
2. In `GameViewModel`, `createDisplayLink()` then sets up a CADisplayLink that is tied to device screen and calls `update` every frame. 
3. `update` gets the frame duration and calls `PeggleGameEngine.update` which calls `gameEngine.moveAll(time: frameDuration)` to simulate kinematics of all game objects. 
4. The returned list of collided physics objects is taken as input for `PeggleGameEngine.updateBoardWithGameEngine(collidedObjects: collidedObjects)`, which updates the board instance with the latest positions of all physics objects. 

- Launch ball 
1. When the ball is tapped, `PeggleGameEngine.launchBall()` is called which sets the ball with velocity and acceleration. 
2. The ball moves according to the game engine kinematics in `GameEngine.move()` and bounces if it hits pegs or walls. 
3. The returned collided physicsObjects are then processed by `PeggleGameEngine`. If it is a `PegPhysicsObject`, the peg is lighted up. 
4. If the ball is stuck in place for too long (`timeForPrematureRemoval`), `board.clearAllLitPegs()` is called to do premature removal. 
5. If the ball falls out of gameArea, it is removed in `removeBallIfOutOfBounds()`


## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

- Unit tests for some models are written in code. 

### Unit Testing 

- Peg 
   - Should return nil when initialized with negative radius 
- Acceleration 
   - Instance should be initialised with x and y inputs without fail
   - Should be able to call `update(velocity: Vector, time: Double)` and returns the new velocity that is acted upon acceleration self instance
- Ball 
   - Should be able to initialise with `centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration, radius: CGFloat` without fail 
   - Should be able to call `moveCentre(by: CGSize)` and mutates own centre 
- Board 
   - Should be able to call lightUp(peg: Peg) and set peg.isLit to true if it is false. if already true, ignore and return 
   - `clearAllLitPegs()` should remove all pegs in self.pegs that has isLit = true
   - `setBall(_ ball: Ball)` should be able to set the ball input as the board's ball
   - `setBall()` should set a ball instance at the top centre of the gamearea with `Vector.zero` and `Acceleration.zero`
   - `removeBall()` should set self.ball = nil
   - `ballIsOutOfBounds` should return whether the ball.centre is out of bounds (i.e.  ball.centre.y > gameArea.height)
   - `removeBallIfOutOfBounds()` should remove ball if is out of bounds
   - ` moveBall(by: CGSize)` should move the ball by specified size, ignore if if ball does not exist or if ball is moving (`ball.velocity != Vector.zero && ball.acceleration != Acceleration.zero`
   - `updateGameArea(_ gameArea: CGSize)` should updates self.gameArea with input
- CirclePhysicsObject 
    - Should be able to initialise with `centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration, radius: CGFloat` without fail 
   - `vertices` Should be able to access computed vertices (treat circle as polygon) 
   - Should be able to be equatable with another physicsObject
- GameEngine 
   -  `addPhysicsObject(object: PhysicsObject) ` Should be able to add input to self.objects
   -  `removePhysicsObject(object: PhysicsObject)` should remove input from self.objects
   -  `resolveCollision` should resolve collision of object1 to object2 by changing object1.velocity depending on object2's shape
   -  `collidedObjects(object: PhysicsObject) -> [PhysicsObject]` should return list of physics objects from self.objects that collided by input object 
   -  `move(object: PhysicsObject, time: Double) -> [PhysicsObject]` should move a physics object based on its velocity and avcceleration as well as resolve any collision and return a list of physics objects that is collided 
   -  `moveAll(time: Double) -> [PhysicsObject]` should call `move` on self.objects and return a list of physics objects that is collided 
   -  `clearObjects()` should set self.objects = []

- PegPhysicsObject
   - Should be able to initialise with `centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration, radius: CGFloat` without fail 
   - Should be able to initialise with `peg: Peg` without fail 
   - ` getPeg() -> Peg` should return self.peg

- PeggleGameEngine
   - Should initialise and set  `board = Board.sampleGameBoard
        lastBallPosition = CGPoint(x: 0, y: 0)
        timeAtLastBallPosition = Double(Calendar.current.component(.second, from: Date()))`
   - `setupWalls()` should setup up left, right, top walls that are RectanglePhysicsObjects dependant on gameArea and add to gameEngine objects. 
   - `createDisplayLink()` should initialise CADisplayLink and automatically call `update` at every frame change. 
   - `update(displaylink: CADisplayLink)` should call `let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)` without fail 
   - `launchBall()` should set self.launcedBall to true, and set the board.ball to a ball with velocity dependant on position of ball and also add it into gameengine.objects. ignore if self.launchedBall is false
   - setBoardToGameEngine() 
   - `updateBoardWithGameEngine` should getPeg from each pegphysicsobject and add into board, and if ball is not out of bounds add into board. If premature removal is needed, call board.clearAllLitPegs()


### Integration testing 

- Test palette 
    - Blue button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs and it is within game area, it should add a blue peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a blue peg 
    - Orange button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs  and it is within game area, it should add a orange peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a orange peg 
   - Purple button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs  and it is within game area, it should add a orange peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a orange peg  
   - Green button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs  and it is within game area, it should add a orange peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a orange peg  
   - Red button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs  and it is within game area, it should add a orange peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a orange peg  
   - Yellow button 
        - When button is tapped, it should indicate that it is selected 
        - When button is tapped and game area is tapped and there are no colliding pegs  and it is within game area, it should add a orange peg 
        - When button is tapped and game area is tapped and there are colliding pegs or it is not within game area, it should not add a orange peg  
   - Resize slider
         - When peg or block is tapped, and slider is slided to the right, peg or block should increase in size
         - Slider should stop sliding when the peg or block has increased 2 times as compared to original dimension
   - Rotate slider
         - When peg or block is tapped, and slider is slided to the right, peg or block should rotate clockwise accordingly 
         - Slider should stop sliding when slider is at the rightmost point
    - Clear button 
        - When button is tapped, it should indicate that it is selected
        - When button is tapped and a peg or block is tapped, peg or block should be removed
        - When button is tapped and a place with no peg or block is tapped, nothing should happen. 
    - Pegs 
        - When long pressed, peg should be removed
        - When dragged, peg should move to new location unless it collides with other pegs or it is not within game area, if so it should be removed 
        
- Test storage 
    - Level name field 
        - When field is tapped, it should allow user to type 
    - Load button
        - When load button is tapped with level name indicated, it should load the associated level 
        - When load button is tapped with level name not indicated, it should load the default "peggle.data"
    - Save button
        - When save button is tapped with level name ("levelname") indicated, it should save the level with the level name as "levelname.data"
        - When save button is tapped with level name not indicated, it should save with the default name "peggle.data"
    - Reset button 
        - When reset button is tapped, game area is cleared. 
        
        
- Winning or losing 
   - When game mode is normalgame, it should win when all orange pegs are hit and there is still time left. 
   - When game mode is beatthescore, it should win when the score obtained is higher than the beatthescore indicated at the top and there is still time left. 
   - When game mode is siamleftsiamright, it should win when n balls is shot and no pegs are hit and there is still time left. 
   
   - When game mode is normalgame, it should lose when (there are stil orange pegs not hit and no balls are left) or there is no time left. 
   - When game mode is beatthescore, it should lose when (the score obtained is lower than the beatthescore indicated at the top and no balls are left) or there is no time left. 
   - When game mode is siamleftsiamright, it should lose when lesser than n balls is shot and (pegs are hit or there is no time left). 
- Game 
    - When game is tested on potrait screen, it should work as below sections 
    - When game is tested on different ipad screen sizes, it should work as below sections
 - Cannon 
   - When cannon is dragged, it points to that direction
   - When cannon is released from dragging, it should launch ball if there is any. 
- Ball 
    - When ball collides with a peg, it should bounce away 
    - When ball collids with wall, it should bounce away 
    - When ball exits the stage, lit pegs will be removed with animation. New ball will appear at top center of screen
    - When ball is stuck with no way of reaching bottom of screen, lit pegs will be prematurely removed (pegs will not be prematurely removed in any other case)
    - When ball does not collide with any objects, it should move normally (like how balls move in real life)
- Peg 
    - When peg is hit by ball, it should light up 
    - When a peg is light up, it should remain lit when hit multiple times. 
    - No ghost pegs, when pegs disappear, ball should not thit anything at these positions in the next round. 
    - When lit pegs are removed and ball exits the stage, new ball should be provided at the top
    


- Saving 
    Note that while your application should work on all iPad sizes, persisted data need not be compatible across sizes. In particular, level data saved from a certain iPad size, when loaded on another iPad size, does not need to be exactly the same level (it does not need to work either)
     
## Rules of the Game
Please write the rules of your game here. This section should include the
following sub-sections. You can keep the heading format here, and you can add
more headings to explain the rules of your game in a structured manner.
Alternatively, you can rewrite this section in your own style. You may also
write this section in a new file entirely, if you wish.

### Cannon Direction
Player can drag cannon around, on release the ball is launched. 

### Bucket effect 
Player gets 1 extra ball if ball enters bucket. 

### Win and Lose Conditions
To win, clear all orange pegs.
You start with 10 balls. Every time you shoot a ball, the number of balls get subtracted. You lose if you run out of balls and there are still orange pegs remaining in the game.

### Power up 
Green balls give ka-boom power
Purple balls give spooky ball power. 
Bucket is not shut at any point of time.  

### Spicy pegs
Confusement peg flips the board upside down 

## Level Designer Additional Features

### Peg Rotation
1. Player can tap on a peg or block to select it. 
2. Player can slide the rotate slider to rotate the peg or block. 
3. Peg or block rotates clockwise accordingly. 

### Peg Resizing
1. Player can tap on a peg or block to select it. 
2. Player can slide the rotate slider to resize the peg or block. The slider resizes the peg or block by 2 at the maximum in each dimensions (radius for peg and width and height for block) 
3. Peg or block resize accordingly. 
4. All peg and block start of at the minimum size. 

## Bells and Whistles
1. A score system that is calculated based on how many pegs the players hit, shown during game play at the top of the board
2. Displaying orange pegs remaining during game play at the top of the board
3. Displaying orange pegs placed in the Level Designer, shown at the top of the board
4. A timer that results in a game over when it ends, shown during game play at the top of the board
5. Engineering luck. Player gets additional ball once in a while (dependent on RNG behind the scenes)


## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

## Written Answers

### Reflecting on your Design
> Now that you have integrated the previous parts, comment on your architecture
> in problem sets 2 and 3. Here are some guiding questions:
> - do you think you have designed your code in the previous problem sets well
>   enough?
1. Can do better, in terms of thinking ahead and have a better code structure by practising SOC for each model and ensuring that they are reusable. 
2. Architecture for PS2 was MV pattern, which I do not understand the purpose of MVVM as seconded by a lot of official apple documentation. I did understand after doing PS3, when setting up caddisplaylink was needed and it was both not the model or views job. Also, having a view model makes the code for the view alot cleaner. 
3. For PS3, can do better in terms of having another model / view model (which i did for ps4) as the entrypoint instead of `PeggleGameEngine` as it should only be in charge of game engine related tasks for peggle and not about other things such as setting up board for the view. 


> - is there any technical debt that you need to clean in this problem set?
1. MVVM pattern instead of MV pattern as mentioned, had to move code around and restructure the sequence of calls better
2. Removing magic literals and placing them into variables 
3. Refactoring code such that models do not have non model tasks and put them in the view models if relevant
4. Creating the list of levels menu since it was not a requirement for ps2 and i planned to do it in ps4. 


> - if you were to redo the entire application, is there anything you would
>   have done differently?
1. Use SpriteKit. (Or reimplement The Collision related tasks such as detection, resolution and maybe adding some protocols to handle before and after collision.)
2. Better SOC.
3. Try using ECS instead of OOP for the game to learn more about it.
4. Try using UIKit instead of SwiftUI for the game to learn more about it. 




