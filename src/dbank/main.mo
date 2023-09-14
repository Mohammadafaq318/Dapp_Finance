import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {

  // use candid UI to test these functions in the UI. U can also do it on the command line google it.


  stable var currentValue: Float=300; //variable //Stable means its a persistance variable
  //currentValue:=100; //assigning value


  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  

  public func topUp(amount: Float){  //function input with natural number data type //Update Method. Updating the state of a variable in a cannister. SO it updates the blockchain. Takes time
    currentValue+=amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float){  //function input with natural number data type //
    let tempValue: Float = currentValue -amount;
    if( tempValue>= 0) {
      currentValue-=amount;
      Debug.print(debug_show(currentValue));
    }
    else {
      Debug.print("withdrawing more than available balance");
    }
  };

  //Another method is QUery call, does not changes the state but calls to read the state

  public query func checkBalance(): async Float {  // Nat here is the return type of the function. Quickly gets the value. It doesnt affect the blockchain so is very fast.
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let timeELapsedNS = currentTime - startTime;
    let timeElapsedS = timeELapsedNS / 1000000000;

    currentValue:=currentValue * (1.01**Float.fromInt(timeElapsedS));

    startTime:=currentTime;

  };

  //topUp();

  //Orthogonal Persistance
  //cannister can hold its state and persist on the ITC. Done Behind the scene and developer does not need to do anything. Just dont specifically assign value. This means there is no need to Databases
  // One eg of creating a persistance variable 
  // stable var currentValue: Nat=300;
}