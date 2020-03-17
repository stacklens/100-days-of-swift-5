//
//  DrawView.swift
//  Day 19 - Draw Something
//
//  Created by 杜赛 on 2020/3/16.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

@IBDesignable
class DrawView: UIView {
    
    lazy var width: CGFloat = self.bounds.width
    lazy var height: CGFloat = self.bounds.height
    
    func drawCircle() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: width, height: height)).cgPath
        circleLayer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        circleLayer.fillColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0)
        circleLayer.lineWidth = CGFloat(10.0)
        self.layer.addSublayer(circleLayer)
    }
    
    func drawRect() {
        let rectLayer = CAShapeLayer()
        rectLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: height)).cgPath
        rectLayer.strokeColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        rectLayer.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        rectLayer.lineWidth = 10.0
        
        let innerLayer = CAShapeLayer()
        innerLayer.path = UIBezierPath(roundedRect: CGRect(x: height / 3, y: width / 3, width: width / 3, height: height / 3), cornerRadius: width / 2).cgPath
        innerLayer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        self.layer.addSublayer(rectLayer)
        self.layer.addSublayer(innerLayer)
    }
    
    func drawTriangle() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.bounds.midX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: self.bounds.midX, y: 0))
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.path = path
        triangleLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        triangleLayer.fillColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        triangleLayer.lineWidth = 5.0
        self.layer.addSublayer(triangleLayer)
    }
    
    func drawTrapezoid() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width / 4, y: height / 4))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width * 3 / 4, y: height / 4))
        path.close()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        shape.strokeColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        shape.lineWidth = 10.0
        self.layer.addSublayer(shape)
    }
    
    func drawPolygons(corners: Int, smoothness: CGFloat, color: CGColor) {
        
        let path = Polygons(corners: corners, smoothness: smoothness).path(in: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = color
        self.layer.addSublayer(shape)
    }
    
    // Reference from Document
    func drawFlower() {
             
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
             
        let path = CGMutablePath()
             
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            var transform  = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
            
            let petal = CGPath(ellipseIn: CGRect(
                x: -width / 10,
                y: 0,
                width: width / 5,
                height: height / 2
            ), transform: &transform)
            
            path.addPath(petal)
        }
            
        shapeLayer.path = path
        shapeLayer.strokeColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        shapeLayer.fillColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shapeLayer.lineWidth = 2.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawCross() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        shapeLayer.lineWidth = 20.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawArc() {
        let path = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2), radius: width / 2, startAngle: 0, endAngle: CGFloat(Float.pi / 4.0), clockwise: false)
                
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        shapeLayer.lineWidth = 10.0
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawSomethingComplicate() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width, y: 0), controlPoint2: CGPoint(x: 0, y: height))
        path.move(to: CGPoint(x: width, y: 0))
        path.addQuadCurve(to: CGPoint(x: 0, y: height), controlPoint: CGPoint(x: width, y: height))
        path.move(to: CGPoint(x: width / 2, y: height / 2))
        path.addArc(withCenter: CGPoint(x: width / 2, y: height / 2), radius: height / 3, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        shapeLayer.lineWidth = 20.0
        shapeLayer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        self.layer.addSublayer(shapeLayer)
    }
}


// Reference Link: https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars
struct Polygons {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: CGFloat

    func path(in rect: CGRect) -> UIBezierPath {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return UIBezierPath() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        let path = UIBezierPath()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: CGFloat = 0

        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        path.apply(transform)
        return path
    }
}
