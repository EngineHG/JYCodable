//
//  JY+DefaultValue.swift
//  使用 Property Wrapper 为 Codable 解码设定默认值
//
//  特别鸣谢 喵神 https://onevcat.com/2020/11/codable-default/
//  Created by CodeMan on 2020/9/23.
//

import Foundation

public protocol DefaultValue {
    
    associatedtype Value: Codable, Equatable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    
    public var wrappedValue: T.Value
    var isUseDefaultValue: Bool = false
    
    public init(){
        self.wrappedValue = T.defaultValue
    }
    
}

extension Default: Codable {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        do {
            wrappedValue = try container.decode(T.Value.self)
        } catch {
            isUseDefaultValue = true
            wrappedValue = T.defaultValue
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension Default: Equatable { }
extension Default: Hashable where T.Value: Hashable { }

extension Default: CustomStringConvertible {
    
    public var description: String {
        "\(wrappedValue)" + (isUseDefaultValue ? " (缺省值) " : "")
    }
}


extension KeyedDecodingContainer {
    
    public func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default()
    }
}

//MARK: - 以下是定义的一些 DefaultValue


///空数组
///
/// 声明方式
///
///     @Default<EmptyAry<T>>
public enum EmptyAry<T>: DefaultValue where T: Codable & Equatable {
    
    public static var defaultValue: [T]{ [] }
}

public enum Nil<T>: DefaultValue where T: Codable & Equatable {
    
    public static var defaultValue: T? { nil }
}

extension Bool {
    
    public enum False: DefaultValue {
        public static let defaultValue: Bool = false
    }
    
    public enum True: DefaultValue {
        public static let defaultValue: Bool = true
    }
}

extension String {
    
    public enum Empty: DefaultValue {
        public static let defaultValue: String = ""
    }
    
    public enum Zero: DefaultValue {
        public static let defaultValue: String = "0"
    }
}

extension Int {
    
    public enum Zero: DefaultValue {
        public static let defaultValue: Int = 0
    }
}

extension Double{
    
    public enum Zero: DefaultValue {
        public static let defaultValue: Double = 0
    }
}

