//
//  EachDisposer.swift
//  Each
//
//  Created by D'Alberti, Luca on 11/11/17.
//  Copyright © 2017 dalu93. All rights reserved.
//

import Foundation

// MARK: - Disposable declaration
public protocol Disposable {
    func dispose()
}

// MARK: - Disposable
extension Each: Disposable {
    public func dispose() {
        stop()
    }
}

// MARK: - Disposer declaration
public protocol Disposer {
    func add(_ disposable: Disposable)
    func dispose()
}

// MARK: - EachDisposer declaration
open class EachDisposer: Disposer {

    private var _disposables: [Disposable] = []

    public init() {}

    public func add(_ disposable: Disposable) {
        _disposables.append(disposable)
    }

    public func dispose() {
        _disposables.forEach { $0.dispose() }
        _disposables = []
    }

    deinit {
        dispose()
    }
}


