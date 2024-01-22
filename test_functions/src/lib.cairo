
#[cfg(test)]
mod tests {
    use core::debug::PrintTrait;
    use core::testing;
    use core::gas;

    #[test]
    fn exploration() {
        let result = 2 + 2;
        assert!(result == 4, "result is not 4");
    }

    // #[test]
    // fn another() {
    //     let result = 2 + 2;
    //     assert!(result == 6, "Make this test fail");
    // }

    #[derive(Copy, Drop)]
    struct Guess {
        value: u64,
    }

    trait GuessTrait {
        fn new(value: u64) -> Guess;
    }

    impl GuessImpl of GuessTrait {
        fn new(value: u64) -> Guess {
            if value < 1 || value > 100 {
                panic!("Guess must be >= 1 and <= 100");
            }
            Guess { value }
        }
    }

    #[test]
    #[should_panic]
    fn greater_than_100() {
        GuessTrait::new(200);
    }

    #[test]
    #[should_panic(expected: ("Guess must be >= 1 and <= 100",))]
    fn greater_than_100_more_precise() {
        GuessTrait::new(200);
    }

    // Will fails due to the panic message is not exactly the same    
    #[test]
    #[ignore] // remove to run the test
    #[should_panic(expected: ("Wrong error message",))]
    fn greater_than_100_more_precise_error() {
        GuessTrait::new(200);
    }

    fn sum_n(n: usize) -> usize {
        let mut i = 0;
        let mut sum = 0;
        loop {
            if i == n {
                sum += i;
                break;
            };
            sum += i;
            i += 1;
        };
        sum
    }

    #[test]
    #[available_gas(2000000)]
    fn test_sum_n() {
        let initial = testing::get_available_gas();
        gas::withdraw_gas().unwrap();
        /// code we want to bench.
        let result = sum_n(10);
        (initial - testing::get_available_gas()).print();
        assert!(result == 55, "result is not 55");
    }
}