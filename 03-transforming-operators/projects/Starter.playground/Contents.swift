import UIKit
import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

//example(of: "Collect") {
//    ["A", "B", "C", "D", "E"].publisher
//        .collect()
//        .sink { values in
//            print(values)
//        }
//        .store(in: &subscriptions)
//}
//
//example(of: "Collect 2") {
//
//    class ImageCollectorDownloader {
//
//        let imagePaths = ["https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ",
//                          "https://i.picsum.photos/id/1/5616/3744.jpg?hmac=kKHwwU8s46oNettHKwJ24qOlIAsWN9d2TtsXDoCWWsQ",
//                          "https://i.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY",
//                          "https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68"]
//
//        @Published var images = [UIImage]()
//
//        func load() {
//            imagePaths
//                .publisher
//                .buffer(size: 4, prefetch: .byRequest, whenFull: .dropOldest)
//                .map { URL(string: $0)! }
//                .flatMap(maxPublishers: .max(1)) {
//                    URLSession.shared.dataTaskPublisher(for: $0)
//                        .map(\.data)
//                        .tryMap(UIImage.init)
//                }
//                .compactMap { $0 }
//                .assertNoFailure() // CAUTION : If error occur our app will crash
//                .eraseToAnyPublisher()
//                .collect()
//                .sink(receiveValue: { images in
//                    print(images)
//                })
//                .store(in: &subscriptions)
//        }
//    }
//
//    let collector = ImageCollectorDownloader()
//
//    collector.load()
//}

//
//example(of: "map") {
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .spellOut
//
//    [123, 4, 56].publisher
//        .map {
//            formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
//        }
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
//
//example(of: "Map keypath") {
//    let url = URL(string: "https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ")!
//
//    URLSession.shared.dataTaskPublisher(for: url) // returns (data, HTTPURLResponse)
//        .map(\.data) // `map keypath` : gets only data AnyPublisher<Data, Failure>
//}
//
//
//example(of: "tryMap") {
//    Just("Directory name that does not exist")
//        .tryMap {
//            try FileManager.default.contentsOfDirectory(atPath: $0) // Void
//        }
//        .sink(receiveCompletion: { completion in
//            print(completion)
//        }, receiveValue: { // Void
//
//        })
//        .store(in: &subscriptions)
//}

//A common use case for flatMap in Combine is when you want to pass elements emitted by one publisher to a method that itself returns a publisher, and ultimately subscribe to the elements emitted by that second publisher.
// `FlatMap` allows you to transform elements from an upstream publisher into a new publisher. So, in this case, we transform the received result of the first request into a new publisher to load the second request.

//example(of: "flat map") {
//
//    struct Article: Decodable {}
//    struct User: Decodable {}
//
//    // use case: We want to load user information and then load user's articles, the that order.
//    func loadUserArticle() -> AnyPublisher<[Article], Error> {
//        loadUser()
//            .flatMap(loadArticles)
//            .eraseToAnyPublisher()
//    }
//
//    func loadUser() -> AnyPublisher<User, Error> {
//        return URLSession.shared
//            .dataTaskPublisher(for: URL(string: "https://user-url.com")!)
//            .tryMap { result in
//                guard let httpURLResponse = result.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return result.data
//            }
//            .decode(type: User.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//
//    func loadArticles(user: User) -> AnyPublisher<[Article], Error> {
//        return URLSession.shared
//            .dataTaskPublisher(for: URL(string: "https://article-url.com")!)
//            .tryMap { result in
//                guard let httpURLResponse = result.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return result.data
//            }
//            .decode(type: [Article].self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//
//}

example(of: "scan") {
    [1, 2, 3, 4]
        .publisher
        .scan(0) {$0 + $1} // reduce alike
        .sink(receiveValue: { value in
            print(value)
        })
        .store(in: &subscriptions)
}
