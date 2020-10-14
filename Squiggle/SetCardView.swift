//
//  SetCardView.swift
//  Squiggle
//
//  Created by Sameh Fakhouri on 10/7/20.
//

import UIKit

@IBDesignable class SetCardView: UIView {
    
    // Attributes
    var shape: SetCard.Shapes = SetCard.Shapes.squiggle {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    var shade: SetCard.Shades = SetCard.Shades.filled {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    var color: SetCard.Colors = SetCard.Colors.red {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var count: Int = 1 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable var isSelected: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable var isMatched: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable var isMisMatched: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    
    
    private func drawSquiggle() -> UIBezierPath {
        let squiggle = UIBezierPath()
        
        squiggle.move(to: squiggleBottomLeft)
        squiggle.addCurve(to: squiggleTopLeft,
                          controlPoint1: squiggleControlLeftOne,
                          controlPoint2: squiggleControlLeftTwo)
        
        squiggle.addArc(withCenter: squiggleTopCenter,
                        radius: squiggleTopRadius,
                        startAngle: CGFloat.pi,
                        endAngle: 0.0,
                        clockwise: true)
        
        squiggle.addCurve(to: squiggleBottomRight,
                          controlPoint1: squiggleControlRightOne,
                          controlPoint2: squiggleControlRightTwo)
        
        squiggle.addArc(withCenter: squiggleBottomCenter,
                        radius: squiggleBottomRadius,
                        startAngle: 0.0,
                        endAngle: CGFloat.pi,
                        clockwise: true)
        
        squiggle.close()
        
        return squiggle
    }
    
    
    private func drawOval() -> UIBezierPath {
        let oval = UIBezierPath()
        
        return oval
    }

    
    private func drawDiamond() -> UIBezierPath {
        let diamond = UIBezierPath()
        
        return diamond
    }

    
    
    
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds,
                                       cornerRadius: 16)
        roundedRect.addClip()
        roundedRect.lineWidth = 5.0

        if isSelected {
            UIColor.black.setStroke()
        } else if isMatched {
            UIColor.green.setStroke()
        } else if isMisMatched {
            UIColor.red.setStroke()
        } else {
            UIColor.white.setStroke()
        }
        
        UIColor.white.setFill()
        roundedRect.fill()
        roundedRect.stroke()
        
        
        let path = UIBezierPath()
        switch shape {
        case .squiggle:
            path.append(drawSquiggle())
        case .oval:
            path.append(drawOval())
        case .diamond:
            path.append(drawDiamond())
        }
        
        showPath(path)
    }

    
    private func showPath(_ path: UIBezierPath) {
        colorForPath.setStroke()
        colorForFill.setFill()
        path.lineWidth = 2.0
        path.fill()
        path.stroke()
    }
    
    
    private var colorForPath: UIColor {
        switch color {
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
        }
    }
    
    private var colorForFill: UIColor {
        switch color {
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
        }
    }

}


extension SetCardView {
    //
    // all the squiggle ratios and locations
    //
    private struct SquiggleRatios {
        static let offsetPercentage:                    CGFloat = 0.20
        static let widthPercentage:                     CGFloat = 0.15
        static let controlHorizontalOffsetPercentage:   CGFloat = 0.10
        static let controlVerticalOffsetPercentage:     CGFloat = 0.40
    }
    
    private var squiggleTopLeft: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height * SquiggleRatios.offsetPercentage)
    }
    
    private var squiggleBottomLeft: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height - (self.bounds.size.height * SquiggleRatios.offsetPercentage))
    }
    
    private var squiggleControlLeftOne: CGPoint {
        let topLeft = squiggleTopLeft
        return CGPoint(x: topLeft.x + (self.bounds.size.width * SquiggleRatios.controlHorizontalOffsetPercentage),
                       y: self.bounds.size.height * SquiggleRatios.controlVerticalOffsetPercentage)
    }
    
    private var squiggleControlLeftTwo: CGPoint {
        let topLeft = squiggleTopLeft
        return CGPoint(x: topLeft.x - (self.bounds.size.width * SquiggleRatios.controlHorizontalOffsetPercentage),
                       y: self.bounds.size.height - (self.bounds.size.height * SquiggleRatios.controlVerticalOffsetPercentage))
    }
    
    private var squiggleTopRight: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height * SquiggleRatios.offsetPercentage)
    }
    
    private var squiggleBottomRight: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height - (self.bounds.size.height * SquiggleRatios.offsetPercentage))
    }
    
    private var squiggleControlRightOne: CGPoint {
        let controlLeftTwo = squiggleControlLeftTwo
        return CGPoint(x: controlLeftTwo.x + (self.bounds.size.width * SquiggleRatios.widthPercentage),
                       y: controlLeftTwo.y)
    }
    
    private var squiggleControlRightTwo: CGPoint {
        let controlLeftOne = squiggleControlLeftOne
        return CGPoint(x: controlLeftOne.x + (self.bounds.size.width * SquiggleRatios.widthPercentage),
                       y: controlLeftOne.y)
    }
    
    private var squiggleTopCenter: CGPoint {
        let topLeft = squiggleTopLeft
        let topRight = squiggleTopRight
        return CGPoint(x: (topLeft.x + topRight.x)/2.0,
                       y: topLeft.y)
    }
    
    private var squiggleBottomCenter: CGPoint {
        let bottomLeft = squiggleBottomLeft
        let bottomRight = squiggleBottomRight
        return CGPoint(x: (bottomLeft.x + bottomRight.x)/2.0,
                       y: bottomLeft.y)
    }
    
    private var squiggleTopRadius: CGFloat {
        let topLeft = squiggleTopLeft
        let topRight = squiggleTopRight
        return (topRight.x - topLeft.x)/2.0
    }
    
    private var squiggleBottomRadius: CGFloat {
        let bottomLeft = squiggleBottomLeft
        let bottomRight = squiggleBottomRight
        return (bottomRight.x - bottomLeft.x)/2.0
    }

}

