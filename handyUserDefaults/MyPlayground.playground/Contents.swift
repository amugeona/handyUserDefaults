//: Playground - noun: a place where people can play

import UIKit

// https://www.drivenbycode.com/the-missing-apply-function-in-swift/

// Handle functions with two parameters
func apply<A, R>(fn: (A) -> R, args: [Any]) -> R {
    return fn(args[0] as! A)
}

// Handle functions with two parameters
func apply<A, B, R>(fn: (A, B) -> R, args: [Any]) -> R {
    return fn(args[0] as! A, args[1] as! B)
}

// Handle functions with three parameters
func apply<A, B, C, R>(fn: (A, B, C) -> R, args: [Any]) -> R {
    return fn(args[0] as! A, args[1] as! B, args[2] as! C)
}


enum MessageType {
    case say
    case shout
    case wisper
}

class Other<T> {}

class Message {
    var text = ""
    var type : MessageType = .say
    init() {
        
    }
    init(text: String, type: MessageType, something: Other<Message>) {
        self.text = "\(text) this is 3"
    }
    init(text: String, type: MessageType) {
        self.type = type
        self.text = "\(text) this is 2"
    }
    init(text: String) {
        self.text = "\(text) this is 1"
    }
}

class InitIdentifier<T> {
    var method : Mirror
    var returnType : String {
        let st = "\(method.subjectType)"
        return st.components(separatedBy: " -> ")[1]
    }
    var signature : String {
        let st = "\(method.subjectType)"
        return st.components(separatedBy: " -> ")[0]
    }
    init(_ method: T) {
        self.method = Mirror(reflecting: method)
    }
}

let firstInit = Message.init(text:)
let secondInit = Message.init(text:type:)
let thirdInit = Message.init(text:type:something:)

//let inits = [firstInit, secondInit] as [Any]
//
//for m in inits {
//    let a = Mirror(reflecting: m)
//    print(a.children.count)
//    print(a.subjectType)
//}


let aaa = InitIdentifier(thirdInit)
print(aaa.signature)
print(aaa.returnType)

func repp(str: String, n: Int) -> String {
    return "what ever \(str)"
}

let f1 = apply(fn: firstInit, args: ["safd"])
print(f1.text)

let f2 = apply(fn: secondInit, args: ["safd", MessageType.say])
print(f2.text)

let f3 = apply(fn: thirdInit, args: ["safd", MessageType.say, Other<Message>()])
print(f3.text)

