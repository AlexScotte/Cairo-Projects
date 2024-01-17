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
    snapshots();
    desnap();
    usingReference();
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

fn snapshots() {
    let mut arr1 = ArrayTrait::<u128>::new();
    let first_snapshot = @arr1; // Take a snapshot of `arr1` at this point in time
    arr1.append(1); // Mutate `arr1` by appending a value
    let first_length = calculate_length_with_snapshot(
        first_snapshot
    ); // Calculate the length of the array when the snapshot was taken
    //ANCHOR: function_call
    let second_length = calculate_length_with_snapshot(@arr1); // Calculate the current length of the array
    //ANCHOR_END: function_call
    println!("The length of the array when the snapshot was taken is {}", first_length);
    println!("The current length of the array is {}", second_length);
}

fn calculate_length_with_snapshot(array_snapshot: @Array<u128>
) -> usize { // array_snapshot is a snapshot of an Array
    array_snapshot.len()
} // Here, array_snapshot goes out of scope and is dropped.
// However, because it is only a view of what the original array `arr` contains, the original `arr` can still be used.


#[derive(Copy, Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn desnap() {
    let rec = Rectangle { height: 3, width: 10 };
    let area = calculate_area(@rec);
    println!("Area: {}", area);
}

fn calculate_area(rec: @Rectangle) -> u64 {
    // As rec is a snapshot to a Rectangle, its fields are also snapshots of the fields types.
    // We need to transform the snapshots back into values using the desnap operator `*`.
    // This is only possible if the type is copyable, which is the case for u64.
    // Here, `*` is used for both multiplying the height and width and for desnapping the snapshots.
    *rec.height * *rec.width
}

fn usingReference() {
    let mut rec = Rectangle { height: 3, width: 10 };
    flip(ref rec);
    println!("height: {}, width: {}", rec.height, rec.width);
}

fn flip(ref rec: Rectangle) {
    let temp = rec.height;
    rec.height = rec.width;
    rec.width = temp;
}



// RECAP
// At any given time, a variable can only have one owner.
// You can pass a variable by-value, by-snapshot, or by-reference to a function.
// If you pass-by-value, ownership of the variable is transferred to the function.
// If you want to keep ownership of the variable and know that your function won’t mutate it, you can pass it as a snapshot with @.
// If you want to keep ownership of the variable and know that your function will mutate it, you can pass it as a mutable reference with ref.