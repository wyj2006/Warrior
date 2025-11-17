pub mod display_name;
pub mod speed;

pub use display_name::*;
pub use speed::*;

pub trait Attribute<T> {
    fn basic_value(&self) -> T;

    fn value(&self) -> T {
        self.basic_value()
    }
}
