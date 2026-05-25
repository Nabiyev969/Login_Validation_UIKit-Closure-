//
//  CounterViewModel.swift
//  Closure_Practice
//
//  Created by Nabiyev Anar on 14.01.26.
//

import Foundation

final class CounterViewModel {
    
    var count: Int = 0
    
    var onCountChanged: ((Int) -> ())?
    
    func increment() {
        count += 1
        onCountChanged?(count)
    }
    
    func decrement() {
        count -= 1
        onCountChanged?(count)
    }
}
