import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

//struct Post: Decodable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
//
//class APIService {
//    static let shared = APIService()
//    private init() {}
//
//    enum Error: Swift.Error {
//        case invalidData
//    }
//
//    func load(url: URL) -> AnyPublisher<[Post], Swift.Error> {
//        return URLSession.shared
//            .dataTaskPublisher(for: url)
//            .tryMap { data, response in
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    throw Error.invalidData
//                }
//                return data
//            }
//            .decode(type: [Post].self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//}
//
//example(of: "Future") {
//    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//    let wrongURL = URL(string: "https://jsonplaceholder.typicode.com/wrong")!
//    APIService.shared.load(url: wrongURL)
//        .catch { error -> AnyPublisher<[Post], Swift.Error> in
//            print(error)
//            return APIService.shared.load(url: url)
//        }
//        .sink { completion in
//            print(completion)
//        } receiveValue: { posts in
//            for post in posts {
//                dump(post)
//            }
//        }
//        .store(in: &subscriptions)
//}


example(of: "Passthrough Subject") {
    enum MyError: Error {
        case test
    }
    
    final class StringSubscriber: Subscriber {
        typealias Input = String
        typealias Failure = MyError
        
        func receive(subscription: Subscription) {
            subscription.request(.max(2))
        }
        
        func receive(_ input: String) -> Subscribers.Demand {
            print(input)
            return input == "World" ? .max(1) : .none
        }
        
        func receive(completion: Subscribers.Completion<MyError>) {
            
        }
    }
    
    let subscriber = StringSubscriber()
    
    let subject = PassthroughSubject<String, MyError>()
    
    subject.subscribe(subscriber)
        
    let anotherSubscription = subject
        .sink { completion in
            print(completion)
        } receiveValue: { value in
            print("Another subcription: ", value)
        }

    subject.send("Hello")
    subject.send("World")
    subject.send("World")
    subject.send("World")
    subject.send("World")
    subject.send("NOT World")
    subject.send("NOT World")

    anotherSubscription.cancel()

    subject.send("World")
    subject.send("World")

}
