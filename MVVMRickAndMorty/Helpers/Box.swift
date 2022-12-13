//
//  Box.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 12.12.2022.
//

class Box<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping(T) -> Void) {
        self.listener = listener
        listener(value)
    }
}
