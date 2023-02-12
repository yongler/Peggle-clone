# CS3217 Problem Set 3

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

Own behaviours added: 
1. Player can drag the ball around and tap it to launch the ball. 

## Dev Guide
You may put your dev guide either in this section, or in a new file entirely.
You are encouraged to include diagrams where appropriate in order to enhance
your guide.


Model objects and physics objects that represent them are seperated to provide an abstraction and seperation of code. i.e. the model does not need to know about the physics object representation. 


Util or constant class is omitted to show high level design. 

### Class diagrams



### Sequence diagrams
Observer pattern is used. Whenever the board model instance changes, views that observes it will be automatically rerendered to update. (functionality of `@Published` and `ObservedObject` in SwiftUI) 




## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

- PS2 tests are omitted 
- Unit tests for models are written in code. 

### Integration testing 

- Game 
    - When game is tested on potrait screen, it should work as below sections 
    - When game is tested on different ipad screen size, it should work as below sections
- Ball 
    - When ball is dragged, ball should move to new location 
    - When ball is tapped, ball should be launched from top center of screen (downwards, never upwards), ball should be launched in the direction from top center of screen to its position before tapped 
    - When ball collides with a peg, it should bounce away 
    - When ball exits the stage, lit pegs will be removed with animation 
    - When ball is stuck with no way of reaching bottom of screen, lit pegs will be prematurely removed (pegs will not be prematurely removed in any other case)  
- Peg 
    - When peg is hit by ball, it should light up 
    - When a peg is light up, it should remain lit 
    - When lit pegs are removed and ball exits the stage, new ball should be provided at the top 
    



## Written Answers

### Design Tradeoffs
> When you are designing your system, you will inevitably run into several
> possible implementations, in which you need to choose one among all. Please
> write at least 2 such scenarios and explain the trade-offs in the choices you
> are making. Afterwards, explain what choices you choose to implement and why.
>
> For example (might not happen to you -- this is just hypothetical!), when
> implementing a certain touch gesture, you might decide to use the method
> `foo` instead of `bar`. Explain what are the advantages and disadvantages of
> using `foo` and `bar`, and why you decided to go with `foo`.

Your answer here
