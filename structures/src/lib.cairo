#[derive(Copy, Drop)]
struct User {
    active: bool,
    username: felt252,
    email: felt252,
    sign_in_count: u64,
}


fn main() {
    createStructure();
    printTrait();
    method();
}

fn createStructure() {
    let user1 = User {
        active: true, username: 'someusername123', email: 'someone@example.com', sign_in_count: 1
    };

    println!("user 1 - username: {}, email: {}", user1.username, user1.email);

    let user2 = build_user_short('johndoe@example.com', 'johndoe');
    println!("user 2 - username: {}, email: {}", user2.username, user2.email);
}

fn build_user_short(email: felt252, username: felt252) -> User {
    User { active: true, username, email, sign_in_count: 1, }
}

use core::debug::PrintTrait;
struct Rectangle {
    width: u64,
    height: u64,
}

fn printTrait() {
    let rectangle = Rectangle { width: 30, height: 10, };
    rectangle.print();
}

impl RectanglePrintImpl of PrintTrait<Rectangle> {
    fn print(self: Rectangle) {
        self.width.print();
        self.height.print();
    }
}

#[derive(Copy, Drop)]
struct Rect {
    width: u64,
    height: u64,
}

trait RectTrait {
    fn area(self: @Rect) -> u64;
    fn can_hold(self: @Rect, other: @Rect) -> bool;
}

impl RectImpl of RectTrait {
    fn area(self: @Rect) -> u64 {
        (*self.width) * (*self.height)
    }
    fn can_hold(self: @Rect, other: @Rect) -> bool {
        *self.width > *other.width && *self.height > *other.height
    }
}

fn method() {
    let rect1 = Rect { width: 30, height: 50, };

    println!("Area: {}", rect1.area());

    let rect2 = Rect { width: 10, height: 40, };
    let rect3 = Rect { width: 60, height: 45, };

    println!("Can rect1 hold rect2? {}", rect1.can_hold(@rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(@rect3));
}