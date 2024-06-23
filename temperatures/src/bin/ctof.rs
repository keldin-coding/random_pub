use std::env;
use temperatures::celsius_to_fahrenheit;

fn main() -> Result<(), String> {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        return Err("No temperature given to convert".to_owned());
    }

    if args.len() >= 3 {
        return Err("Too many arguments given".to_owned());
    }

    let query = &args[1];

    let temperature: f64 = if let Ok(val) = query.parse() {
        val
    } else {
        return Err("Unparseable number given".to_owned());
    };

    println!(
        "{}°C is {:.2}°F",
        temperature,
        celsius_to_fahrenheit(temperature)
    );

    return Ok(());
}
