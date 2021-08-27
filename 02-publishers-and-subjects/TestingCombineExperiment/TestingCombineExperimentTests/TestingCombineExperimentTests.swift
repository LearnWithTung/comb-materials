//
//  TestingCombineExperimentTests.swift
//  TestingCombineExperimentTests
//
//  Created by Tung Vu on 26/08/2021.
//

import XCTest
import TestingCombineExperiment
import Combine

class TestingCombineExperimentTests: XCTestCase {
        
    func test_buttonTap_subjectSendsValues() {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let sut = storyboard.instantiateInitialViewController() as! ViewController
        sut.loadViewIfNeeded()
        
        let spy = ValueSpy(publisher: sut.publisher)
        
        XCTAssertEqual(spy.capturedValues, [0])
        
        sut.increaseButton.simulateButtonTap()
        
        XCTAssertEqual(spy.capturedValues, [0, 1])
    }
    
    func test_buttonTap_increaseLabel() {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let sut = storyboard.instantiateInitialViewController() as! ViewController
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.valueLabel.text, "0")
        
        sut.increaseButton.simulateButtonTap()
        XCTAssertEqual(sut.valueLabel.text, "1")
    }
    
    // MARK: - Helpers
    
    private class ValueSpy {
        private var cancellable: AnyCancellable?
        
        var capturedValues = [Int]()
        
        init(publisher: AnyPublisher<Int, Never>) {
            cancellable = publisher.sink(receiveValue: {[weak self] value in
                self?.capturedValues.append(value)
            })
        }
    }

}


extension UIControl {
    func simulateButtonTap() {
        sendActions(for: .touchUpInside)
    }
}
