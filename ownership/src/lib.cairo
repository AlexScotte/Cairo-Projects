use core::array::ArrayTrait;
#[derive(Copy, Drop)]
struct Point {
    x: u128,
    y: u128,
}

fn main() {
    movingWithoutCopyTrait();
    movingWithCopyTrait();
    arrayClone();
    returnsValue();
    returnsTupple();
}


fn movingWithoutCopyTrait(){
    let mut arr = ArrayTrait::<u128>::new();
    arrayPop(arr);
    // compilation error
    //arrayPop(arr);
}

fn arrayPop(mut arr: Array<u128>) {
    arr.pop_front();
}

fn movingWithCopyTrait(){
    let p1 = Point { x: 5, y: 10 };
    displayPoint(p1);
    displayPoint(p1);
}

fn displayPoint(p: Point) { // do something with p
    println!("Point - X : {}", p.x);
    println!("Point - Y : {}", p.y);
}

fn arrayClone(){
    let mut arr1 = ArrayTrait::<u128>::new();
    arr1.append(10);
    let arr2 = arr1.clone();
    println!("array index 0 : {}", *arr1.at(0));
    println!("cloned array index 0 : {}", *arr2.at(0));

}


#[derive(Drop)]
struct A {}

fn returnsValue() {
    let a1 = gives_ownership();           // gives_ownership moves its return
                                          // value into a1

    let a2 = A {};                        // a2 comes into scope

    let a3 = takes_and_gives_back(a2);    // a2 is moved into
                                          // takes_and_gives_back, which also
                                          // moves its return value into a3

} // Here, a3 goes out of scope and is dropped. a2 was moved, so nothing
  // happens. a1 goes out of scope and is dropped.

fn gives_ownership() -> A {               // gives_ownership will move its
                                          // return value into the function
                                          // that calls it

    let some_a = A {};                    // some_a comes into scope

    some_a                                // some_a is returned and
                                          // moves ownership to the calling
                                          // function
}

// This function takes an instance some_a of A and returns it
fn takes_and_gives_back(some_a: A) -> A { // some_a comes into
                                          // scope

    some_a                               // some_a is returned and moves
                                         // ownership to the calling
                                         // function
}



fn returnsTupple() {
    let mut arr1 = ArrayTrait::<u128>::new();
    arr1.append(10);

    let (arr2, len) = calculate_length(arr1);
    println!("array index 0: {}",  *arr2.at(0));
    println!("array length: {}",  len);
}

fn calculate_length(arr: Array<u128>) -> (Array<u128>, usize) {
    let length = arr.len(); // len() returns the length of an array

    (arr, length)
}