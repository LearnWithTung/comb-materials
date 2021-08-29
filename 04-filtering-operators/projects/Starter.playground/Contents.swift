import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

//example(of: "Filter") {
//    let numbers = (1...10).publisher
//
//    numbers
//        .filter { $0 % 3 == 0}
//        .map {
//            "\($0) is multiple of 3"
//        }
//        .sink(receiveValue: {
//            print($0)
//        })
//        .store(in: &subscriptions)
//}

example(of: "Compact Map") {
    let strings = ["a", "1.24", "3", "def", "5"].publisher
    
    // hard-core developer
//    strings
//        .map { Float($0) }
//        .filter { $0 != nil }
//        .compactMap {$0}
//        .sink(receiveValue: {
//            print($0)
//        })
    
    // "Work smart - not hard"
    strings
        .compactMap { Float($0) }
        .sink(receiveValue: {
            print($0)
        })
}

example(of: "Challenge") {
    let collection = (1...100).publisher
    
    collection
        .dropFirst(50)
        .prefix(20)
        .filter { $0 % 2 == 0}
        .sink(receiveValue: { print($0) })
    
}
