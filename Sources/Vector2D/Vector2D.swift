//
//  Vector2D.swift
//  --------------
//
//  1.0.0: 2020.10.10
//  1.0.1: + .point
//

import SwiftUI

// ⭐️ define custom operators
infix operator ×  : MultiplicationPrecedence  // cross (determinant)
infix operator •  : MultiplicationPrecedence  // dot   (• : opt + 8)
infix operator ** : MultiplicationPrecedence  // non-proportional scale
infix operator **=: MultiplicationPrecedence

// 🅿️ Vector2D
public protocol Vector2D: ExpressibleByArrayLiteral {
    
    associatedtype Field: FloatingPoint     // support +,-,*,/
    
    // x, y coordinates
    var x: Field { get }
    var y: Field { get }
    
    // initializer
    init(x: Field, y: Field)
    
    // vector addition: u + v
    static func + (u: Self, v: Self) -> Self
    // additive inverse: -v
    static prefix func - (u: Self) -> Self
    
    // scalar multiplication: a * v
    // has default implementation in extension
}

// MARK: - Vector2D protocol extension -

// default behaviors
extension Vector2D {
    
    /* ------- Constants ------- */
    
    public static var i: Self { return Self.init(x: 1, y: 0) }
    public static var j: Self { return Self.init(x: 0, y: 1) }
    
    /* ------- Initializers ------- */
    
    /// make `Vector2D` conform to `ExpressibleByArrayLiteral`
    ///
    /// Example:
    /// ```
    /// let p: CGPoint = [1, 2]
    /// ```
    public init(arrayLiteral elements: Field...) {
        let a = elements + [0, 0]   // padding 0's
        self.init(x: a[0], y: a[1])
    }
    
    /// convenience initializer
    ///
    /// example:
    /// ```
    /// let p = CGPoint(1, 2)
    /// ```
    public init(_ x: Field, _ y: Field) {
        self.init(x: x, y: y)
    }
    
    /* ------- Linear Combinations ------- */
    
    /// u + v
    public static func + (u: Self, v: Self) -> Self {
        return Self.init(x: u.x + v.x, y: u.y + v.y)
    }
    /// -v (additive inverse)
    public static prefix func - (v: Self) -> Self {
        return Self.init(x: -v.x, y: -v.y)
    }
    
    /// vector subtraction
    /// `u - v == u + (-v)`
    public static func - (u: Self, v: Self) -> Self {
        return u + (-v)
    }
    
    /* ------- Scalar Multiplication ------- */
    
    /// a * v
    public static func * (a: Field, v: Self) -> Self {
        return Self.init(x: a * v.x, y: a * v.y)
    }
    /// v * a
    public static func * (v: Self, a: Field) -> Self {
        return a * v
    }
    /// v / a
    public static func / (v: Self, a: Field) -> Self {
        return Self.init(x: v.x / a, y: v.y / a)
    }
    
    /* ------- Dot Product, Cross Product ------- */
    
    /// cross product: `u × v`
    public static func × (u: Self, v: Self) -> Field {
        return u.x * v.y - u.y * v.x  // x1 y2 - x2 y1
    }
    /// dot product: `u • v`
    public static func • (u: Self, v: Self) -> Field {
        return u.x * v.x + u.y * v.y  // x1 x2 + y1 y2
    }
    
    /* ------- Complex Number ------- */
    
    /// complex multiplication: `u * v`
    public static func * (u: Self, v: Self) -> Self {
        let (a,b,c,d) = (u.x, u.y, v.x, v.y)       // u = a + bi, v = a - bi
        return Self.init(x: a * c - b * d, y: a * d + b * c) // uv = (ac-bd) + (ad+bc)i
    }
    
    /// complex multiplication: u *= v
    public static func *= (u: inout Self, v: Self) {
        u = u * v
    }
    
    /* ------- Other Operations ------- */
    
    /// (non-proportional scale)
    /// if `u = [a,b], v = [c,d]`, then `u ** v = [ac, bd]`
    public static func ** (u: Self, v: Self) -> Self {
        return Self.init(x: u.x * v.x, y: u.y * v.y)
    }
    
}

// MARK: - Field == CGFloat -

extension Vector2D where Field == CGFloat {
    
    /* ------- Polar Coordinates ------- */
    
    /// polar form of a 2D vector
    /// - Parameters:
    ///   - r: radius
    ///   - a: angle (in radian)
    /// - Returns: `Self`: the conforming type
    public static func polar(_ r: Field, _ a: Field) -> Self {
        Self.init(x: r * cos(a), y: r * sin(a))
    }
    
    /// turn a `Vector2D` into `CGPoint`
    ///
    /// Example:
    /// ```
    /// let size = CGSize(width: 20, height: 30)
    /// let p = size.point      // CGPoint(x: 20, y: 30)
    /// ```
    public var point: CGPoint { CGPoint(x: x, y: y) }
    
}

// MARK: - Conforming Types -

// 🌀CGPoint + Vector2D
extension CGPoint: Vector2D {}

// 🌀CGSize + Vector2D
extension CGSize: Vector2D {
    public var x: CGFloat { width }
    public var y: CGFloat { height }
    public init(x: CGFloat, y: CGFloat) {
        self.init(width: x, height: y)
    }
}

// 🌀CGVector + Vector2D
extension CGVector: Vector2D {
    public var x: CGFloat { dx }
    public var y: CGFloat { dy }
    public init(x: CGFloat, y: CGFloat) {
        self.init(dx: x, dy: y)
    }
}

// 🌀UnitPoint + Vector2D
@available(iOS 13, macOS 10.15, *)
extension UnitPoint: Vector2D {}
