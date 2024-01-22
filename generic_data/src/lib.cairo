
fn main(){
    find_largest_list();
    find_smallest_element();
    create_generic_struct();
    mix_up();
}

fn find_largest_list() {
    let mut l1 = ArrayTrait::new();
    let mut l2 = ArrayTrait::new();

    l1.append(1);
    l1.append(2);

    l2.append(3);
    l2.append(4);
    l2.append(5);

    // There is no need to specify the concrete type of T because
    // it is inferred by the compiler
    let (l3, list_number) = largest_list(l1, l2);
    println!("The largest list is list number {}", list_number);
}

// Specify generic type T between the angulars
fn largest_list<T, impl TDrop:Drop<T>>(l1: Array<T>, l2: Array<T>) -> (Array<T>, u8) {
    if l1.len() > l2.len() {
        (l1, 1)
    } else {
        (l2, 2)
    }
}

// Given a list of T get the smallest one.
// The PartialOrd trait implements comparison operations for T
fn smallest_element<T, +PartialOrd<T>, +Copy<T>, +Drop<T>>(
    list: @Array<T>
) -> T {
    let mut smallest = *list[0];
    let mut index = 1;
    loop {
        if index >= list.len() {
            break smallest;
        }
        if *list[index] < smallest {
            smallest = *list[index];
        }
        index = index + 1;
    }
}

fn find_smallest_element() {
    let list: Array<u8> = array![5, 3, 10];

    // We need to specify that we are passing a snapshot of `list` as an argument
    let s = smallest_element(@list);
    assert!(s == 3);
}


#[derive(Drop)]
struct Wallet<T, U> {
    balance: T,
    address: U,
}

trait WalletTrait<T, U> {
    fn balance(self: @Wallet<T, U>) -> T;
}

trait WalletMixTrait<T1, U1> {
    fn mixup<T2, +Drop<T2>, U2, +Drop<U2>>(
        self: Wallet<T1, U1>, other: Wallet<T2, U2>
    ) -> Wallet<T1, U2>;
}

impl WalletMixImpl<T1, +Drop<T1>, U1, +Drop<U1>> of WalletMixTrait<T1, U1> {
    fn mixup<T2, +Drop<T2>, U2, +Drop<U2>>(
        self: Wallet<T1, U1>, other: Wallet<T2, U2>
    ) -> Wallet<T1, U2> {
        Wallet { balance: self.balance, address: other.address }
    }
}


impl WalletImpl<T, U, +Copy<T>> of WalletTrait<T, U> {
    fn balance(self: @Wallet<T, U>) -> T {
        return *self.balance;
    }
}

fn create_generic_struct() {
    let w = Wallet { balance: 3, address: 14 };
    println!("Wallet balance: {}", w.balance());

}

// The above code derives the Drop trait for the Wallet type automatically. It is equivalent to writing the following code:

// struct Wallet<T> {
//     balance: T
// }

// impl WalletDrop<T, +Drop<T>> of Drop<Wallet<T>>;

fn mix_up() {
    let w1: Wallet<bool, u128> = Wallet { balance: true, address: 10 };
    let w2: Wallet<felt252, u8> = Wallet { balance: 32, address: 100 };

    let w3 = w1.mixup(w2);

    println!("w3 balance: {}", w3.balance);
    println!("w3 address: {}", w3.address);
}
