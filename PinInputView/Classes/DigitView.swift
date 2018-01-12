//
//  DigitView.swift
//  PinInputView
//
//  Created by Julien on 14/01/2018.
//

import Foundation
import UIKit
final class DigitView: UIView {
    
    private let label = UILabel()
    private let bottomLine = UIView()
    
    private var labelAndBottomLineVerticalConstraint:NSLayoutConstraint?
    private var bottomLineHeightConstraint:NSLayoutConstraint?

    
    var textColor:UIColor = .black {
        didSet {
            if textColor != oldValue {
                label.textColor = textColor
                bottomLine.backgroundColor = textColor
            }
        }
    }
    
    var font: UIFont = .systemFont(ofSize: 36) {
        didSet {
            if font != oldValue {
                label.font = font
                self.invalidateIntrinsicContentSize()
                self.labelAndBottomLineVerticalConstraint?.constant =  -self.verticalSpaceBetweenLabelAndBottomLine
                self.bottomLineHeightConstraint?.constant = self.bottomLineHeight
            }
        }
    }
    
    
    var text:String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    var verticalSpaceBetweenLabelAndBottomLine: CGFloat {
        // When the font size in 36, 8 seems to be a good value
        // So, let's do a simple ratio ...
        return CGFloat(roundf(Float(8.0*(self.font.pointSize/36.0))))
    }
    
    var bottomLineHeight:CGFloat {
        // When the font size in 36, 8 seems to be a good value
        // So, let's do a simple ratio ...
        return CGFloat(roundf(Float(2.0*(self.font.pointSize/36.0))))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        self.addSubview(bottomLine)
        
        bottomLine.backgroundColor = self.textColor
        bottomLine.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero,
                                                excludingEdge: .top)
        bottomLineHeightConstraint =  bottomLine.autoSetDimension(.height, toSize: bottomLineHeight)
        
        label.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        
        
        labelAndBottomLineVerticalConstraint = label.autoPinEdge(.bottom,
                                                                 to: .top,
                                                                 of: bottomLine,
                                                                 withOffset: -self.verticalSpaceBetweenLabelAndBottomLine)
        
        label.font = font
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = " "
        label.textColor = self.textColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        
        let labelSize = self.calculateCharSize()
        let intrinsicWidth = labelSize.width*1.5
        let intrinsicHeight = labelSize.height + self.verticalSpaceBetweenLabelAndBottomLine + bottomLineHeight
        

        return CGSize(width: intrinsicWidth, height: intrinsicHeight)
    }
    
    
    private func calculateCharSize() -> CGSize {
        let testChar = "8"
        let noLimitSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        return testChar.boundingRect(with: noLimitSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [.font : self.font],
                                     context: nil).size
    }
}
