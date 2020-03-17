//
//  ViewController.swift
//  Day 19 - Draw Something
//
//  Created by 杜赛 on 2020/3/16.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var drawViews: [DrawView]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawViews.first?.drawCircle()
        drawViews[1].drawRect()
        drawViews[2].drawTriangle()
        drawViews[3].drawTrapezoid()
        drawViews[4].drawPolygons(corners: 5, smoothness: 0.5, color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        drawViews[5].drawPolygons(corners: 20, smoothness: 0.9, color: #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1))
        drawViews[6].drawFlower()
        drawViews[7].drawCross()
        drawViews[8].drawArc()
        drawViews[9].drawSomethingComplicate()
    }
}
