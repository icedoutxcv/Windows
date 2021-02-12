//
//  TimerView.swift
//  Windows
//
//  Created by xcv on 06/02/2021.
//

import UIKit


class TimerView: UIView {

    
    let shapeLayer       = CAShapeLayer()
    let secondShapeLayer = CAShapeLayer()
    var circularPath: UIBezierPath?
    var secondcircularPath: UIBezierPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircle()
    }

    func createCircle(){
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.bounds.width / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = Color.chocoBackground.cgColor
        shapeLayer.lineWidth = 20.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 1
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DRotate(CATransform3DIdentity, -CGFloat.pi / 2, 0, 0, 1)
        
        let secondCircularPath = UIBezierPath(arcCenter: .zero, radius: self.bounds.width / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        secondShapeLayer.path = secondCircularPath.cgPath
        secondShapeLayer.strokeColor = Color.lightLabel.cgColor
        secondShapeLayer.lineWidth = 10.0
        secondShapeLayer.fillColor = UIColor.clear.cgColor
        secondShapeLayer.lineCap = CAShapeLayerLineCap.round
        secondShapeLayer.strokeEnd = 0
        secondShapeLayer.position = center
        secondShapeLayer.transform = CATransform3DRotate(CATransform3DIdentity, -CGFloat.pi / 2, 0, 0, 1)
        
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(secondShapeLayer)

    }
    
    func changeProgressValue(to percent: Float){
           secondShapeLayer.strokeEnd = CGFloat(percent/100)

    }
    
    func setProgressValue(to percent: Float) {
        changeProgressValue(to: percent)
    }


}
