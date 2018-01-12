//
//  PinInputView.swift
//  PinInputView
//
//  Created by Julien on 14/01/2018.
//

import Foundation
import UIKit
import PureLayout
@IBDesignable public class PinInput : UIControl {
    
    @IBInspectable
    /// The number of digits that compose your pincode.
    /// Setting this will trigger a relayout of the PinInput
    public var length: Int = 4 {
        didSet {
            self.setupDigitViews(count: length)
        }
    }
    
    @IBInspectable
    /// The color of the text, but also the color
    /// of the tiny bars bellow the text.
    public var textColor: UIColor = .black {
        didSet {
            if textColor != oldValue {
                digitViews.forEach{$0.textColor = textColor}
            }
        }
    }
    
    @IBInspectable
    /// The font of the displayed digits.
    /// Setting this will trigger a relayout of the PinInput
    public var font: UIFont = .systemFont(ofSize: 36) {
        didSet {
            if font != oldValue {
                digitViews.forEach{$0.font = font}
                self.invalidateIntrinsicContentSize()
            }
        }
    }
    
    /// Called each time the value of the input changes
    public var onValueChanged:(()->Void)?
    
    /// Called when the input is full
    /// (i.e. when value.count == length)
    public var onCompletion:(()->Void)?

    private var digitViews = [DigitView]()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 6
        return view
    }()
    
    /// An array representing all the digits of the current pin code.
    public var value = [Int]() {
        didSet {
            // Update views
            for (i, view) in digitViews.enumerated() {
                guard i < value.count else {
                    view.text = " "
                    continue
                }
                
                view.text = String(value[i])
            }

            // Fire events
            sendActions(for: .valueChanged)
            onValueChanged?()
            
            if value.count == length {
                sendActions(for: .primaryActionTriggered)
                onCompletion?()
            }
        }
    }
    
    /// A string with the concatenation of all the digits composing the pincode
    public var textValue:String {
        get {
            return  self.value.reduce("",  {return "\($0 ?? "")\($1)"}) ?? ""
        }
    }
    
    public init() {
        super.init(frame: .zero)
        comonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comonInit()
    }
    
    
    private func setupDigitViews(count:Int) {
        let oldCount  = digitViews.count
        
        guard oldCount != count else {
            // If there is the same count of
            // digit view as we need, simply return
            // Since there is nothing to do :)
            return
        }
        
        if count > oldCount {
            let itemsToAdd = count-oldCount
            for _ in 0..<itemsToAdd {
                let view = DigitView()
                view.font = self.font
                view.textColor = self.textColor
                digitViews.append(view)
                stackView.addArrangedSubview(view)
            }
        } else if count < oldCount {
            let itemsToRemove = oldCount-count
            for _ in 0..<itemsToRemove {
                if let view = digitViews.popLast() {
                    stackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
            }
        }
        self.invalidateIntrinsicContentSize()
    }
    
    
    private func comonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupDigitViews(count: length)
        
        addSubview(stackView)
        
        stackView.autoPinEdgesToSuperviewEdges()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(becomeFirstResponder))
        addGestureRecognizer(tap)
    }
    
    
    // MARK: - UIResponder
    override open var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override var intrinsicContentSize: CGSize {
        return self.stackView.intrinsicContentSize
    }
}

extension PinInput: UITextInputTraits {
    public var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        
        set {
            // Do nothing
        }
    }
}


extension PinInput: UIKeyInput {
    public var hasText: Bool {
        return !value.isEmpty
    }
    
    public func insertText(_ text: String) {
        guard value.count < length, let integer = Int(text) else {
            return
        }
        
        guard integer >= 0, integer < 10 else {
            return
        }
        
        value.append(integer)
    }
    
    public func deleteBackward() {
        guard value.count > 0 else {
            return
        }
        value.removeLast()
    }
}

