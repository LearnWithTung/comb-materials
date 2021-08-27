//
//  ViewController.swift
//  TestingCombineExperiment
//
//  Created by Tung Vu on 26/08/2021.
//

import UIKit
import Combine

public final class ViewController: UIViewController {
    
    private let subject = CurrentValueSubject<Int, Never>(0)
    @IBOutlet public private(set) weak var valueLabel: UILabel!
    @IBOutlet public private(set) weak var increaseButton: UIButton!
    var subs = Set<AnyCancellable>()
    
    public var publisher: AnyPublisher<Int, Never> {
        return subject
            .eraseToAnyPublisher()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        publisher
            .dispatchOnMainQueue() // prevent uneccessary dispatch if the current queue is the main queue already. And also for the sake of the tests.
            .map {String($0) }
            .assign(to: \.text, on: valueLabel)
            .store(in: &subs)
    }

    @IBAction func increaseButtonTapped(_ sender: Any) {
        subject.send(subject.value + 1)
    }
    
}

extension Publisher {
    func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.immediateWhenOnMainQueueScheduler)
            .eraseToAnyPublisher()
    }
}

extension DispatchQueue {
    static var immediateWhenOnMainQueueScheduler: ImmediateWhenOnMainQueueScheduler {
        ImmediateWhenOnMainQueueScheduler()
    }

    struct ImmediateWhenOnMainQueueScheduler: Scheduler {
        typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
        typealias SchedulerOptions = DispatchQueue.SchedulerOptions

        var now: SchedulerTimeType {
            DispatchQueue.main.now
        }

        var minimumTolerance: SchedulerTimeType.Stride {
            DispatchQueue.main.minimumTolerance
        }

        func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
            guard Thread.isMainThread else {
                return DispatchQueue.main.schedule(options: options, action)
            }

            action()
        }

        func schedule(after date: SchedulerTimeType, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) {
            DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
        }

        func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
            DispatchQueue.main.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
        }
    }
}
