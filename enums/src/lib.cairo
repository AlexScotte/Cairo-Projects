
fn main(){
    enum_trait();
    match_enum();
    match_enum_inside_enum();
    match_with_option();
    match_catch_all();
}

fn enum_trait(){

    let mut message = Message::Quit;
    message.process();

    message = Message::Echo(42);
    message.process();

    message = Message::Move((1, 2));
    message.process();
}

#[derive(Drop)]
enum Message {
    Quit,
    Echo: felt252,
    Move: (u128, u128),
}

trait Processing {
    fn process(self: Message);
}

impl ProcessingImpl of Processing {
    fn process(self: Message) {
        match self {
            Message::Quit => { println!("quitting") },
            Message::Echo(value) => { println!("echoing {}", value) },
            Message::Move((x, y)) => { println!("moving") },
        }
    }
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn match_enum(){
    let coin = Coin::Penny;
    let value = value_in_cents(coin);
    println!("value: {}", value);
}

fn value_in_cents(coin: Coin) -> felt252 {
    match coin {
        Coin::Penny => {
            println!("Lucky penny!");
            1
        },
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}

fn match_enum_inside_enum(){
    let coin = Coin2::Quarter(UsState::Alaska);
    let value = value_in_cents2(coin);
    println!("value: {}", value);
}

use core::debug::PrintTrait;
#[derive(Drop)]
enum UsState {
    Alabama,
    Alaska,
}

impl UsStatePrintImpl of PrintTrait<UsState> {
    fn print(self: UsState) {
        match self {
            UsState::Alabama => ('Alabama').print(),
            UsState::Alaska => ('Alaska').print(),
        }
    }
}

#[derive(Drop)]
enum Coin2 {
    Penny,
    Nickel,
    Dime,
    Quarter: UsState,
}

fn value_in_cents2(coin: Coin2) -> felt252 {
    match coin {
        Coin2::Penny => 1,
        Coin2::Nickel => 5,
        Coin2::Dime => 10,
        Coin2::Quarter(state) => {
            state.print();
            25
        },
    }
}

use core::fmt;

fn plus_one(x: Option<u8>) -> Option<u8> {
    match x {
        Option::Some(val) => Option::Some(val + 1),
        // Option::None => Option::None, -> Run panicked on unwrap
        Option::None => Option::Some(0),
    }
}

fn match_with_option() {
    let five: Option<u8> = Option::Some(5);
    let six: Option<u8> = plus_one(five);
    println!("six: {}", six.unwrap());
    let none = plus_one(Option::None);
    println!("none: {}", none.unwrap());
}

fn match_catch_all(){
    did_i_win(0);
    did_i_win(1);
    did_i_win(8);
    did_i_win(100);
}

fn did_i_win(value: felt252) {
    match value {
        0 => println!("you won!"),
        1 => println!("nothing happens"),
        _ => println!("you lost...")
    }
}