fn main() { 
    operator_overloading();
    format_macro();
    write_macro();
    poseidon_hashing();
    pedersen_hashing();
    poseidon_hashing_array();
}

#[derive(Drop)]
struct Potion {
    health: felt252,
    mana: felt252
}

impl PotionAdd of Add<Potion> {
    fn add(lhs: Potion, rhs: Potion) -> Potion {
        Potion { health: lhs.health + rhs.health, mana: lhs.mana + rhs.mana, }
    }
}

fn operator_overloading() {
    let health_potion: Potion = Potion { health: 100, mana: 0 };
    let mana_potion: Potion = Potion { health: 0, mana: 100 };
    let super_potion: Potion = health_potion + mana_potion;
    // Both potions were combined with the `+` operator.
    println!("super potion health: {}", super_potion.health);
    println!("super potion mana: {}", super_potion.mana);
}

fn format_macro(){
    let s1: ByteArray = "tic";
    let s2: ByteArray = "tac";
    let s3: ByteArray = "toe";
    let s = s1 + "-" + s2 + "-" + s3;
    // using + operator consumes the strings, so they can't be used again!

    let s1: ByteArray = "tic";
    let s2: ByteArray = "tac";
    let s3: ByteArray = "toe";
    let s = format!("{s1}-{s2}-{s3}"); // s1, s2, s3 are not consumed by format!
    // or
    let s = format!("{}-{}-{}", s1, s2, s3);
    println!("{}", s);
}

use core::fmt::Formatter;
fn write_macro() {
    let mut formatter: Formatter = Default::default();
    write!(formatter, "hello");
    write!(formatter, "world");
    println!("{}", formatter.buffer); // helloworld
}

use core::hash::{HashStateTrait, HashStateExTrait};

#[derive(Drop, Hash, Serde, Copy)]
struct StructForHash {
    first: felt252,
    second: felt252,
    third: (u32, u32),
    last: bool,
}

use core::poseidon::PoseidonTrait;
fn poseidon_hashing() -> felt252 {
    let struct_to_hash = StructForHash { first: 0, second: 1, third: (1, 2), last: false };

    let hash = PoseidonTrait::new().update_with(struct_to_hash).finalize();
    println!("poseidon hash: {}", hash); 
    hash
}

use core::pedersen::PedersenTrait;
fn pedersen_hashing() -> (felt252, felt252) {
    let struct_to_hash = StructForHash { first: 0, second: 1, third: (1, 2), last: false };

    // hash1 is the result of hashing a struct with a base state of 0
    let hash1 = PedersenTrait::new(0).update_with(struct_to_hash).finalize();

    let mut serialized_struct: Array<felt252> = ArrayTrait::new();
    Serde::serialize(@struct_to_hash, ref serialized_struct);
    let first_element = serialized_struct.pop_front().unwrap();
    let mut state = PedersenTrait::new(first_element);
    loop {
        match serialized_struct.pop_front() {
            Option::Some(value) => state.update(value),
            Option::None => { break; }
        };
    };
    // hash2 is the result of hashing only the fields of the struct
    let hash2 = state.finalize();
    println!("pedersen hash 1: {}", hash1); 
    println!("pedersen hash 2: {}", hash2); 

    (hash1, hash2)
}

use core::poseidon::poseidon_hash_span;
#[derive(Drop)]
struct StructForHashArray {
    first: felt252,
    second: felt252,
    third: Array<felt252>,
}

fn poseidon_hashing_array() {
    let struct_to_hash = StructForHashArray { first: 0, second: 1, third: array![1, 2, 3, 4, 5] };

    let mut hash = PoseidonTrait::new().update(struct_to_hash.first).update(struct_to_hash.second);
    let hash_felt252 = hash.update(poseidon_hash_span(struct_to_hash.third.span())).finalize();
    println!("poseidon hash array: {}", hash_felt252); 

}