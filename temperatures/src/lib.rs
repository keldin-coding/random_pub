pub fn celsius_to_fahrenheit(celsius: f64) -> f64 {
    return celsius * (9.0 / 5.0) + 32.0;
}

pub fn fahrenheit_to_celsius(fahrenheit: f64) -> f64 {
    return (fahrenheit - 32.0) * (5.0 / 9.0);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn c_to_f_test() {
        let result = celsius_to_fahrenheit(100.0);
        assert_eq!(result, 212.0);

        let result = celsius_to_fahrenheit(0.0);
        assert_eq!(result, 32.0);

        let result = celsius_to_fahrenheit(-20.0);
        assert_eq!(result, -4.0);
    }

    #[test]
    fn f_to_c_test() {
        let result = fahrenheit_to_celsius(212.0);
        assert_eq!(result, 100.0);

        let result = fahrenheit_to_celsius(32.0);
        assert_eq!(result, 0.0);

        let result = fahrenheit_to_celsius(-4.0);
        assert_eq!(result, -20.0);
    }
}
