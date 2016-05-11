//
//  StationDetailViewController.swift
//  hw2_102703029
//
//  Created by 盧與明 on 2016/5/2.
//  Copyright © 2016年 YuMing_Lu. All rights reserved.
//

import UIKit

class StationDetailViewController: ViewController {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationNevigationItemName: UINavigationItem!
    @IBOutlet weak var stationLinesStackView: UIStackView!
    
    
    var station: Station? {
        didSet (newStation){
            if self.isViewLoaded() {
                self.updateValues()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateValues()
    }
    
    func updateValues() {
        guard self.isViewLoaded() else {
            return
        }        
        self.stationNameLabel.text = station?.name
        self.stationNevigationItemName.title = station?.name
        self.stationLinesStackView.axis = .Horizontal
        self.stationLinesStackView.distribution = .FillEqually
        self.stationLinesStackView.alignment = .Fill
        
        
        for (lineName, _) in (station?.lines)! {
            let myLabel = UILabel()
            myLabel.text = lineName as? String
            myLabel.backgroundColor = colorDictionary[lineName as! String]
            myLabel.textAlignment = .Center
            myLabel.textColor = UIColor.whiteColor()
            self.stationLinesStackView.addArrangedSubview(myLabel)
        }
        
    }
    
    

}
