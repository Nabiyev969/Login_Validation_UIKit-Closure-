//
//  DataViewModel.swift
//  Closure_Practice
//
//  Created by Nabiyev Anar on 18.01.26.
//

import Foundation

final class DataViewModel {
    
    var onLoadingStarted: (() -> ())?
    var onLoadingFinished: (() -> ())?
    var onDataLoaded: (([String]) -> ())?
    var onError: ((String) -> ())?
    
    func loadData() {
        onLoadingStarted?()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let success = Bool.random()
            
            DispatchQueue.main.async {
                self.onLoadingFinished?()
                
                if success {
                    self.onDataLoaded?(["Apple", "Banana", "Orange"])
                } else {
                    self.onError?("Error, 404")
                }
            }
        }
    }
}
