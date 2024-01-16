fn main() {
    simpleIf();
    ifElseIf();
    ifInLetStatement();
    loopError();
    loopOK();
    loopContinue();
    loppReturnValue();
}

fn simpleIf() {    
    let number = 3;

    if number == 5 {
        println!("condition was true and number = {}", number);
    } else {
        println!("condition was false and number = {}", number);
    }
}

fn ifElseIf() {
    let number = 3;

    if number == 12 {
        println!("number is 12");
    } else if number == 3 {
        println!("number is 3");
    } else if number - 2 == 1 {
        println!("number minus 2 is 1");
    } else {
        println!("number not found");
    }
}

fn ifInLetStatement() {
    let condition = true;
    let number = if condition {
        5
    } else {
        6
    };

    if number == 5 {
        println!("condition was true and number is {}", number);
    }
}

// Error Out of gas
fn loopError() {
    // let mut i: usize = 0;
    // loop {
    //     if i > 10 {
    //         break;
    //     }
    //     println!("i = {}", i);
    // }
}

fn loopOK() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        println!("i = {}", i);
        i += 1;
    }
}

fn loopContinue() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        if i == 5 {
            i += 1;
            continue;
        }
        println!("i = {}", i);
        i += 1;
    }
}

fn loppReturnValue() {
    let mut counter = 0;

    let result = loop {
        if counter == 10 {
            break counter * 2;
        }
        counter += 1;
    };

    println!("The result is {}", result);
}