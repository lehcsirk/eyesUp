//
//  ViewController.swift
//  eyesUp
//
//  Created by Cameron Krischel on 4/3/20.
//  Copyright © 2020 Cameron Krischel. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController
{
    let screenSize = UIScreen.main.bounds
    let motionManager = CMMotionManager()

    override func viewDidLoad()
    {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
//        var up = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/8))
//        up.layer.borderColor = UIColor.green.cgColor
//        up.layer.borderWidth = 4.0
//        up.text = "up"
//        up.textAlignment = .center
//        self.view.addSubview(up)
//
//        var right = UILabel(frame: CGRect(x: screenWidth*3/4, y: 0, width: screenWidth/4, height: screenHeight))
//        right.layer.borderColor = UIColor.green.cgColor
//        right.layer.borderWidth = 4.0
//        right.text = "right"
//        right.textAlignment = .center
//        self.view.addSubview(right)
//
//        var down = UILabel(frame: CGRect(x: 0, y: screenHeight*7/8, width: screenWidth, height: screenHeight/8))
//        down.layer.borderColor = UIColor.green.cgColor
//        down.layer.borderWidth = 4.0
//        down.text = "down"
//        down.textAlignment = .center
//        self.view.addSubview(down)
//
//        var left = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth/4, height: screenHeight))
//        left.layer.borderColor = UIColor.green.cgColor
//        left.layer.borderWidth = 4.0
//        left.text = "left"
//        left.textAlignment = .center
//        self.view.addSubview(left)
        
        var dotPath = UIBezierPath(arcCenter: CGPoint(x: screenWidth/2, y: screenHeight/2), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        var dot = CAShapeLayer()
        dot.path = dotPath.cgPath
        dot.fillColor = UIColor.clear.cgColor
        dot.strokeColor = UIColor.red.cgColor
        dot.lineWidth = 3.0
        view.layer.addSublayer(dot)
        
        let upLayer = CAGradientLayer()
        upLayer.opacity = 0.5
        upLayer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2)
        upLayer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
        self.view.layer.insertSublayer(upLayer, at: 0)
        upLayer.calculatePoints(for: 450)
        
        let downLayer = CAGradientLayer()
        downLayer.opacity = 0.5
        downLayer.frame = CGRect(x: 0, y: screenHeight/2, width: screenWidth, height: screenHeight/2)
        downLayer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
        self.view.layer.insertSublayer(downLayer, at: 0)
        downLayer.calculatePoints(for: 270)
        
        let rightLayer = CAGradientLayer()
        rightLayer.opacity = 0.5
        rightLayer.frame = CGRect(x: screenWidth/2, y: 0, width: screenWidth/2, height: screenHeight)
        rightLayer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
        self.view.layer.insertSublayer(rightLayer, at: 0)
        rightLayer.calculatePoints(for: 180)
        
        
        let leftLayer = CAGradientLayer()
        leftLayer.opacity = 0.5
        leftLayer.frame = CGRect(x: 0, y: 0, width: screenWidth/2, height: screenHeight)
        leftLayer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
        self.view.layer.insertSublayer(leftLayer, at: 0)
        leftLayer.calculatePoints(for: 360)
        
        if motionManager.isAccelerometerAvailable
        {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: OperationQueue.main)
            { (data, error) in
//                print(data)
                dotPath = UIBezierPath(arcCenter: CGPoint(x: screenWidth/2 * CGFloat(1 + (data?.acceleration.x)!), y: screenHeight/2 * CGFloat(1 - (data?.acceleration.y)!)), radius: CGFloat(20) * CGFloat(1.5 + (data?.acceleration.z)!), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
                dot.path = dotPath.cgPath
                
                rightLayer.colors = [UIColor(red: 4*CGFloat((data?.acceleration.x)!), green: 0, blue: 0, alpha: 1.0).cgColor, UIColor.black.cgColor]
                leftLayer.colors = [UIColor(red: -4*CGFloat((data?.acceleration.x)!), green: 0, blue: 0, alpha: 1.0).cgColor, UIColor.black.cgColor]
                upLayer.colors = [UIColor(red: 4*CGFloat((data?.acceleration.y)!), green: 0, blue: 0, alpha: 1.0).cgColor, UIColor.black.cgColor]
                downLayer.colors = [UIColor(red: -4*CGFloat((data?.acceleration.y)!), green: 0, blue: 0, alpha: 1.0).cgColor, UIColor.black.cgColor]
            }
        }
    }

}

public extension CAGradientLayer {

    /// Sets the start and end points on a gradient layer for a given angle.
    ///
    /// - Important:
    /// *0°* is a horizontal gradient from left to right.
    ///
    /// With a positive input, the rotational direction is clockwise.
    ///
    ///    * An input of *400°* will have the same output as an input of *40°*
    ///
    /// With a negative input, the rotational direction is clockwise.
    ///
    ///    * An input of *-15°* will have the same output as *345°*
    ///
    /// - Parameters:
    ///     - angle: The angle of the gradient.
    ///
    public func calculatePoints(for angle: CGFloat) {


        var ang = (-angle).truncatingRemainder(dividingBy: 360)

        if ang < 0 { ang = 360 + ang }

        let n: CGFloat = 0.5

        switch ang {

        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            startPoint = a
            endPoint = b

        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            startPoint = a
            endPoint = b

        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
           startPoint = a
            endPoint = b

        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            startPoint = a
            endPoint = b

        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            startPoint = a
            endPoint = b

        }
    }

    /// Private function to aid with the math when calculating the gradient angle
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }


    // Overloads

    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Int) {
        calculatePoints(for: CGFloat(angle))
    }

    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Float) {
        calculatePoints(for: CGFloat(angle))
    }

    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Double) {
        calculatePoints(for: CGFloat(angle))
    }

}
