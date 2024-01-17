
fn main() {
    // arrayPopFront();
    // arrayAt();
    // arrayGet();
    // arrayLength();
    // arrayMacro();
    // // arrayMultipleTypes();
    // arraySpan();

    dictionnaryInsertGet();
    dictionnaryModify();
}

////////////////
///// Array ////
////////////////

fn arrayPopFront() {
    let mut a = ArrayTrait::new();
    a.append(10);
    a.append(1);
    a.append(2);

    let first_value = a.pop_front().unwrap();
    println!("first value: {}", first_value);
}

// Use "at" when you want to panic on out-of-bounds access attempts
fn arrayAt() {
    let mut a = ArrayTrait::new();
    a.append(10);
    a.append(11);

    let first = *a.at(0);
    let second = *a.at(1);

    println!("first: {}", first);
    println!("second: {}", second);
}

// Use get when you prefer to handle such cases gracefully without panicking
fn arrayGet() {
    let mut arr = ArrayTrait::<u128>::new();
    arr.append(100);
    let index_to_access =
        0; // Change this value to see different results, what would happen if the index doesn't exist?
    match arr.get(index_to_access) {
        Option::Some(x) => {
            let result = *x.unbox();
            println!("get result: {}", result);
        },
        Option::None => { panic!("out of bounds") }
    }
}

fn arrayLength() {
    let mut a = ArrayTrait::new();
    a.append(10);
    a.append(11);

    println!("array length: {}", a.len());
}


fn arrayMacro() {
    let mut arr = ArrayTrait::new();
    arr.append(1);
    arr.append(2);
    arr.append(3);
    arr.append(4);
    arr.append(5);

    // = 

    let arr = array![1, 2, 3, 4, 5];
}

// #[derive(Copy, Drop)]
// enum Data {
//     Integer: u128,
//     Felt: felt252,
//     Tuple: (u32, u32),
// }

// fn arrayMultipleTypes(){

//     let mut messages: Array<Data> = ArrayTrait::new();
//         messages.append(Data::Integer(100));
//         messages.append(Data::Felt('hello world'));
//         messages.append(Data::Tuple((10, 30)));
// }

fn arraySpan() {
    let mut arr = ArrayTrait::new();
    arr.append(1);

    let spn = arr.span();

    arr.pop_front();
    println!("span: {}", *spn.at(0));
}


//////////////////////
///// Dictionnary ////
//////////////////////

fn dictionnaryInsertGet(){

    let mut balances: Felt252Dict<u64> = Default::default();

    balances.insert('Alex', 100);
    balances.insert('Maria', 200);

    let alex_balance = balances.get('Alex');
    println!("Alex balance: {}", alex_balance);

    let maria_balance = balances.get('Maria');
    println!("Maria balance: {}", maria_balance);
}

fn dictionnaryModify(){
    let mut balances: Felt252Dict<u64> = Default::default();

    // Insert Alex with 100 balance
    balances.insert('Alex', 100);
    // Check that Alex has indeed 100 associated with him
    let alex_balance = balances.get('Alex');
    println!("Alex balance: {}", alex_balance);

    // Insert Alex again, this time with 200 balance
    balances.insert('Alex', 200);
    // Check the new balance is correct
    let alex_balance_2 = balances.get('Alex');
    println!("Alex new balance: {}", alex_balance_2);
}