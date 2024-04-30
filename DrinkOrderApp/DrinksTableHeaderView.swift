//
//  DrinksTableHeaderView.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/30.
//

import UIKit

class DrinksTableHeaderView: UIView {
    
    static let identifier: String = "DrinksTableHeaderView"
    
    var segmentedControl: UISegmentedControl = {
        let segmentedControl: UISegmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.isEnabled = true
        segmentedControl.tintColor = Colors.clear
        segmentedControl.backgroundColor = Colors.kebukeLightBlue
        segmentedControl.selectedSegmentTintColor = Colors.clear
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addConstraints()
        
        segmentedControl.insertSegment(withTitle: "單品茶", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "季節限定", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "調茶", at: 2, animated: true)
        segmentedControl.insertSegment(withTitle: "雲蓋", at: 3, animated: true)
        segmentedControl.insertSegment(withTitle: "歐蕾", at: 4, animated: true)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Colors.kebukeBrown,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Colors.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], for: .selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


#Preview(traits: .fixedLayout(width: 428, height: 60), body: {
    let drinksHeadView: UIView = DrinksTableHeaderView()
    return drinksHeadView
})
