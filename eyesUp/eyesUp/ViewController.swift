//
//  ViewController.swift
//  eyesUp
//
//  Created by Cameron Krischel on 4/3/20.
//  Copyright © 2020 Cameron Krischel. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad()
    {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var up = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/8))
        up.layer.borderColor = UIColor.green.cgColor
        up.layer.borderWidth = 4.0
        up.text = "up"
        up.textAlignment = .center
        self.view.addSubview(up)
        
        var right = UILabel(frame: CGRect(x: screenWidth*3/4, y: 0, width: screenWidth/4, height: screenHeight))
        right.layer.borderColor = UIColor.green.cgColor
        right.layer.borderWidth = 4.0
        right.text = "right"
        right.textAlignment = .center
        self.view.addSubview(right)
        
        var down = UILabel(frame: CGRect(x: 0, y: screenHeight*7/8, width: screenWidth, height: screenHeight/8))
        down.layer.borderColor = UIColor.green.cgColor
        down.layer.borderWidth = 4.0
        down.text = "down"
        down.textAlignment = .center
        self.view.addSubview(down)
        
        var left = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth/4, height: screenHeight))
        left.layer.borderColor = UIColor.green.cgColor
        left.layer.borderWidth = 4.0
        left.text = "left"
        left.textAlignment = .center
        self.view.addSubview(left)
    }
}

