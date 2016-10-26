//
//  Each.swift
//  Each
//
//  Created by Luca D'Alberti on 9/5/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/// The perform closure. It has to return a `NextStep` type to let `Each` know
/// what's the next operation to do.
///
/// Return .continue to keep the timer alive, otherwise .stop to invalidate it.
public typealias PerformClosure = () -> NextStep

// MARK: - NextStep declaration
/// The enumeration describes the next step `Each` has to do whenever the timer
/// is triggered.
///
/// - stop:       Stops the timer.
/// - `continue`: Keeps the timer alive.
public enum NextStep {
    
    case stop, `continue`
}

// MARK: - NextStep boolean value implementation
fileprivate extension NextStep {
    
    /// Stops the timer or not
    var shouldStop: Bool {
        switch self {
        case .continue: return false
        case .stop:     return true
        }
    }
}

// MARK: - Each declaratiom
/// The `Each` class allows the user to easily create a scheduled action
open class Each {
    
    enum SecondsMultiplierType {
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
    fileprivate var _performClosure: PerformClosure?
    
    /// The timer instance
    private weak var _timer: Timer?
    
    /// Weak reference to the owner. Useful to check whether to stop or not the timer
    /// when the owner is deallocated
    fileprivate weak var _owner: AnyObject? {
        didSet {
            _checkOwner = _owner != nil
        }
    }
    
    /// It contains a boolean property that tells how to handle the tier trigger, checking or not for the
    /// owner instance.
    /// - Note: Do not change this value. The `_owner.didSet` will handle it
    fileprivate var _checkOwner = false
    
    // MARK: - Public properties
    /// Instance that runs the specific interval in milliseconds
    public lazy var milliseconds:  Each = self._makeEachWith(value: self._value, multiplierType: .toMilliseconds)
    
    /// Instance that runs the specific interval in seconds
    public lazy var seconds:       Each = self._makeEachWith(value: self._value, multiplierType: .toSeconds)
    
    /// /// Instance that runs the specific interval in minutes
    public lazy var minutes:       Each = self._makeEachWith(value: self._value, multiplierType: .toMinutes)
    
    /// Instance that runs the specific interval in hours
    public lazy var hours:         Each = self._makeEachWith(value: self._value, multiplierType: .toHours)
    
    /// Timer is stopped or not
    public private(set) var isStopped = true
    
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
    public func perform(closure: @escaping PerformClosure) {
        guard _timer == nil else { return }
        guard let interval = timeInterval else { fatalError("Please, speficy the time unit by using `milliseconds`, `seconds`, `minutes` abd `hours` properties.") }
        
        isStopped = false
        _performClosure = closure
        _timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: .Triggered,
            userInfo: nil,
            repeats: true
        )
    }
    
    public func perform(on owner: AnyObject, closure: @escaping PerformClosure) {
        _owner = owner
        perform(closure: closure)
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
        guard let _performClosure = _performClosure else { fatalError("Don't call the method `start()` without stopping it before.") }
        
        _ = perform(closure: _performClosure)
    }
}

// MARK: - Actions
fileprivate extension Each {
    @objc func _trigger(timer: Timer) {
        if _checkOwner && _owner == nil {
            stop()
            return
        }
        
        let stopTimer = _performClosure?().shouldStop ?? false
        
        guard stopTimer else { return }
        stop()
    }
}

// MARK: - Builders
fileprivate extension Each {
    func _makeEachWith(value: TimeInterval, multiplierType: SecondsMultiplierType) -> Each {
        let each = Each(value)
        each._multiplier = multiplierType.value
        
        return each
    }
}

// MARK: - Selectors
fileprivate extension Selector {
    static let Triggered = #selector(Each._trigger(timer:))
}
