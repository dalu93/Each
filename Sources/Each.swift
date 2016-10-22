//
//  Each.swift
//  Each
//
//  Created by Luca D'Alberti on 9/5/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import PSWeakProxy

public typealias Callback = () -> NextStep

public enum NextStep {
    case keep
    case stop
}

protocol API {}
// MARK: - Each declaratiom
/// The `Each` class allows the user to easily create a scheduled action

extension Each: API {
    /// make sure it runs the specific interval in milliseconds
    func milliseconds() -> Self {
        return _confirm(unit: .toMilliseconds)
    }
    
    /// make sure it runs the specific interval in milliseconds
    func seconds() -> Self {
        return _confirm(unit: .toSeconds)
    }
    
    /// make sure it runs the specific interval in milliseconds
    func minutes() -> Self {
        return _confirm(unit: .toMinutes)
    }
    
    /// make sure it runs the specific interval in milliseconds
    func hours() -> Self {
        return _confirm(unit: .toHours)
    }
    
}

open class Each {
    
    //MARK: - Public APIs
    /// Timer is stopped or not
    public private(set) var isStopped = true
    
    fileprivate enum SecondsMultiplierType {
        case toMilliseconds
        case toSeconds
        case toMinutes
        case toHours
        
        var value: Double {
            switch self {
            case .toMilliseconds:   return 1/1000
            case .toSeconds:        return 1
            case .toMinutes:        return 60
            case .toHours:          return 3600
            }
        }
    }
    
    // MARK: - Private properties
    /// The timer interval in seconds
    private let _value: TimeInterval
    
    /// The multiplier. If nil when using it, the configuration didn't go well,
    /// the app will crash
    fileprivate var _multiplier: Double? = nil
    
    /// The action to perform when the timer is triggered
    fileprivate var _performClosure: Callback?
    
    /// The timer instance
    private weak var _timer: Timer?
    
    
    /// The definitive time interval to use for the timer. If nil, the app will crash
    public var timeInterval: TimeInterval? {
        guard let _multiplier = _multiplier else { return nil }
        return _multiplier * _value
    }
    
    // MARK: - Lifecycle
    /**
     Initialize a new `Each` object with an abstract value.
     Remember to use the variables `milliseconds`, `seconds`, `minutes` and
     `hours` to get the exact configuration
     
     - parameter value: The abstract value that describes the interval together
     with the time unit
     
     - returns: A new `Each` uncompleted instance
     */
    public init(_ value: TimeInterval) {
        self._value = value
    }
    
    deinit {
        _timer?.invalidate()
    }
    
    // MARK: - Public methods
    /**
     Starts the timer and performs the action whenever the timer is triggered
     The closure should return a boolean that indicates to stop or not the timer after
     the trigger. Return `false` to continue, return `true` to stop it
     
     - parameter closure: The closure to execute whenever the timer is triggered.
     The closure should return a boolean that indicates to stop or not the timer after
     the trigger. Return `false` to continue, return `true` to stop it
     */
    public func perform(closure: @escaping Callback) {
        guard _timer == nil else { return }
        guard let interval = timeInterval else { fatalError("Please, speficy the time unit by using `milliseconds`, `seconds`, `minutes` abd `hours` properties") }
        
        isStopped = false
        _performClosure = closure
        _timer = Timer.scheduledTimer(timeInterval: interval,
                                      target: PSWeakProxy(object:self),
                                      selector: .Triggered,
                                      userInfo: nil,
                                      repeats: true)
        
    }
    
    
    /**
     Stops the timer
     */
    public func stop() {
        _timer?.invalidate()
        _timer = nil
        
        isStopped = true
    }
    
    /**
     Restarts the timer
     */
    public func restart() {
        guard let _performClosure = _performClosure else { fatalError("Don't call the method `start()` in this case. The first time the timer is started automatically") }
        
        _ = perform(closure: _performClosure)
    }
}

// MARK: - Actions
fileprivate extension Each {
    @objc func _trigger(timer: Timer) {
        guard let callback = _performClosure else { return }
        switch callback() {
        case .keep: break
        case .stop: stop()
        }
    }
}

// MARK: - Builders
private extension Each {
    func _confirm(unit: SecondsMultiplierType) -> Self {
        _multiplier = unit.value
        return self
    }
}

// MARK: - Selectors
private extension Selector {
    static let Triggered = #selector(Each._trigger(timer:))
}
