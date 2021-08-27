import UIKit
import Combine

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
//
//
//example(of: "Collect 2") {
//
//    class ImageCollectorDownloader {
//
//        let imagePaths = ["https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ",
//        "https://i.picsum.photos/id/1/5616/3744.jpg?hmac=kKHwwU8s46oNettHKwJ24qOlIAsWN9d2TtsXDoCWWsQ",
//        "https://i.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY",
//        "https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68"]
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
//                .eraseToAnyPublisher()
//                .collect()
//                .sink { completion in
//                    print(completion)
//                } receiveValue: { images in
//                    print(images)
//                }
//                .store(in: &subscriptions)
//        }
//    }
//
//    let collector = ImageCollectorDownloader()
//    collector.load()
//}


example(of: "map") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut

    [123, 4, 56].publisher
        .map {
            formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
        }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}
