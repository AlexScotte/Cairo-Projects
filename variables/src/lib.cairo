const ONE_HOUR_IN_SECONDS: u32 = 3600;

fn main() {
    let mut x = 5;
    println!("x = {}", x);
    x = 6;
    println!("x = {}", x);
}

// fn main() {
//     let x = 5;
//     let x = x + 1;
//     {
//         let x = x * 2;
//         println!("Inner scope x value is: {}", x);
//     }
//     println!("Outer scope x value is: {}", x);
// }


// Shadowin type

// ERROR
// fn main() {
//     let x: u64 = 2;
//     println!("x = {} of type u64", x);
//     let x: felt252 = x.into(); // converts x to a felt, type annotation is required.
//     println!("x = {} of type felt252", x);
// }

// fn main() {
//     let x: u64 = 2;
//     println!("x = {} of type u64", x);
//     let x: felt252 = x.into(); // converts x to a felt, type annotation is required.
//     println!("x = {} of type felt252", x);
// }

