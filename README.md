# Vector2D

## 🅿️ `Vector2D` protocol

A protocol to turn a normal type into a 2D vector.

```swift
// 🅿️ Vector2D
public protocol Vector2D: ExpressibleByArrayLiteral, Rectangular {
    
    associatedtype Field: FloatingPoint     // support +,-,*,/
    
    // x, y coordinates
    var x: Field { get }
    var y: Field { get }
    
    // initializer
    init(x: Field, y: Field)
    
    // vector addition: u + v
    // (default implementation provided)
    static func + (u: Self, v: Self) -> Self
    
    // additive inverse: -v
    // (default implementation provided)
    static prefix func - (u: Self) -> Self
}
```

## 🅿️ `Rectangular` protocol

```swift
public protocol Rectangular {
    var origin: CGPoint { get }
    var size  : CGSize  { get }
}
```
