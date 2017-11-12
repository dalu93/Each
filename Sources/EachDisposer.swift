//
//  EachDisposer.swift
//  Each
//
//  Created by D'Alberti, Luca on 11/11/17.
//  Copyright © 2017 dalu93. All rights reserved.
//

import Foundation

// MARK: - EachDisposer declaration
/// `EachDisposer` can dispose a set of `Each` objects.
///
/// The main feature of this object is that it provides an automatic disposition
/// of every `Each` instance when the disposer is deinitialized
open class EachDisposer {

    /// List of `Each`s added to the `Disposer`
    private(set) var timers: [Each] = []

    public init() {}

    /// Add the `Each` instance as `Disposable`
    ///
    /// The `Each` instance is retained and it will be deinitialized and stopped
    /// together with the `EachDisposer` instance
    ///
    /// - Parameter disposable: The `Each` instance
    public func add(_ disposable: Each) {
        timers.append(disposable)
    }

    /// Forces the dispose of all the `Each`s added
    public func dispose() {
        timers.forEach { $0.stop() }
        timers = []
    }

    deinit {
        dispose()
    }
}


