//
//  DragViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/04/26.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit

class DragViewController: UIViewController {

    @IBOutlet weak var five: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let boxImage = makeBoxImage(width: 150, height: 180)
        let boxView = UIImageView(image: boxImage)
        boxView.center = CGPoint(x: 200, y: 200)
        view.addSubview(boxView)
        
        let drawImage = drawLine2()
        let drawView = UIImageView(image: drawImage)
        view.addSubview(drawView)
        
        let drawImage3 = drawLine3()
        let drawView3 = UIImageView(image: drawImage3)
        view.addSubview(drawView3)
    }
    
    func arcPercent(_ radius: CGFloat, _ percent: Double) -> UIBezierPath {
        let endAngle = 2*Double.pi*percent/100 - Double.pi/2
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(endAngle), clockwise: percent>0)
        return path
    }
    
    
    func drawLine3() -> UIImage {
        let a = CGPoint(x: 50, y: 270)
        let b = CGPoint(x: 250, y: 300)
        let c = CGPoint(x: 120, y: 400)
        let d = CGPoint(x: 50, y: 500)
        let e = CGPoint(x: 250, y: 500)
        let f = CGPoint(x: 250, y: 700)
        let g = CGPoint(x: 100, y: 750)
        
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        UIColor.black.setStroke()
        let linPath = UIBezierPath()
        linPath.append(makeLinePath(a,b))
        linPath.append(makeLinePath(b,c))
        linPath.append(makeLinePath(d,e))
        linPath.append(makeLinePath(f,g))
        linPath.lineWidth = 1.0
        linPath.setLineDash([2.0,2.0], count: 2, phase: 0.0)
        linPath.stroke()
        
        UIColor.red.setStroke()
        let curvePath1 = UIBezierPath()
        curvePath1.move(to: a)
        curvePath1.addQuadCurve(to: c, controlPoint: b)
        curvePath1.lineWidth = 2
        curvePath1.stroke()
        
        UIColor.blue.setStroke()
        let curvePath2 = UIBezierPath()
        curvePath2.move(to: d)
        curvePath2.addCurve(to: f, controlPoint1: e, controlPoint2: g)
        curvePath2.lineWidth = 2
        curvePath2.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func makeLinePath(_ startPoint: CGPoint, _ endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    
    func drawLine2() -> UIImage {
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        let percent = 58.2
        UIColor.red.setStroke()
        let arcPath = arcPercent(80, percent)
        arcPath.lineWidth = 30
        arcPath.lineCapStyle = .butt
        let tf = CGAffineTransform(translationX: view.center.x, y: view.center.y)
        arcPath.apply(tf)
        arcPath.stroke()
        
        let font = UIFont.boldSystemFont(ofSize: 28)
        let textFontAttributes = [NSAttributedString.Key.font: font,
                                  NSAttributedString.Key.foregroundColor: UIColor.gray]
        let drawString = String(percent) + "%"
        let posX = view.center.x - 45
        let posY = view.center.y - 15
        let rect = CGRect(x: posX, y: posY, width: 90, height: 30)
        drawString.draw(in: rect, withAttributes: textFontAttributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func drawLine() -> UIImage {
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        let center = CGPoint(x: view.center.x, y: 200)
        let arcPath = UIBezierPath(arcCenter: center, radius: 80.0, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi/4*3), clockwise: true)
        arcPath.addLine(to: center)
        arcPath.close()
        //UIColor.cyan.setFill()
        //arcPath.fill()
        arcPath.lineWidth = 5
        arcPath.lineCapStyle = .round
        arcPath.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func makeBoxImage(width w: CGFloat, height h: CGFloat) -> UIImage {
        let size = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        let drawRect = CGRect(x: 0, y: 0, width: w, height: h)
        //let drawPath = UIBezierPath(rect: drawRect)
        let drawPath = UIBezierPath(roundedRect: drawRect, cornerRadius: 15)
        context?.setFillColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
        drawPath.fill()
        context?.setStrokeColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        drawPath.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    @IBAction func testDrag(_ sender: UIPanGestureRecognizer) {
        five.center = sender.location(in: self.view)
        
    }
    
}
