fn main() {
    println!("Hello, world!");
    another_function();
    another_function_2(5);
    print_labeled_measurement(5, "h");


    let first_arg = 3;
    let second_arg = 4;
    foo(x: first_arg, y: second_arg);
    let x = 1;
    let y = 2;
    foo(:x, :y);
    
    expressionStatement();
    fnWithReturnValue();
}

fn another_function() {
    println!("Another function.");
}

fn another_function_2(x: felt252) {
    println!("x = {}", x);
}

fn print_labeled_measurement(value: u128, unit_label: ByteArray) {
    println!("The measurement is: {value}{unit_label}");
}

fn foo(x: u8, y: u8) {
    println!("The arguments are: {x} and {y}");
}

fn expressionStatement(){
    let y = {
        let x = 3;
        x + 1
    };
    println!("The value of y is: {y}");
}

fn five() -> u32 {
    5
}

fn fnWithReturnValue() {
    let x = five();
    println!("x = {}", x);
}