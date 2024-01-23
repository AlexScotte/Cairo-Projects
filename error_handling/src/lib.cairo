use core::integer::u128_overflowing_add;

fn u128_checked_add(a: u128, b: u128) -> Option<u128> {
    match u128_overflowing_add(a, b) {
        Result::Ok(r) => Option::Some(r),
        Result::Err(r) => Option::None,
    }
}

fn parse_u8(s: felt252) -> Result<u8, felt252> {
    match s.try_into() {
        Option::Some(value) => Result::Ok(value),
        Option::None => Result::Err('Invalid integer'),
    }
}

fn do_something_with_parse_u8(input: felt252) -> Result<u8, felt252> {
    let input_to_u8: u8 = parse_u8(input)?;
    // DO SOMETHING
    let res = input_to_u8 - 1;
    Result::Ok(res)
}

#[cfg(test)]
mod tests {
    use super::parse_u8;
    use super::do_something_with_parse_u8;
    
    #[test]
    fn test_felt252_to_u8() {
        let number: felt252 = 5_felt252;
        // should not panic
        let res = parse_u8(number).unwrap();
    }

    #[test]
    #[should_panic]
    fn test_felt252_to_u8_panic() {
        let number: felt252 = 256_felt252;
        // should panic
        let res = parse_u8(number).unwrap();
    }

    #[test]
    fn test_function_2() {
        let number: felt252 = 258_felt252;
        match do_something_with_parse_u8(number) {
            Result::Ok(value) => println!("Result: {}", value),
            Result::Err(e) => println!("Error: {}", e),
        }
    }
}