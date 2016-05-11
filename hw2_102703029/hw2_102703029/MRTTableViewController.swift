//
//  MRTTableViewController.swift
//  hw2_102703029
//
//  Created by 盧與明 on 2016/5/3.
//  Copyright © 2016年 YuMing_Lu. All rights reserved.
//

import UIKit
import ObjectMapper

class MRTTableViewController: UITableViewController {

    var MRTData: MRTDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataPath = NSBundle.mainBundle().pathForResource("MRT", ofType: "json")!

        guard let MRTSource = try? MRTDataSource(contentsOfFile: dataPath) else {
            fatalError()
        }
        self.MRTData = MRTSource
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.MRTData.lines.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.MRTData.lines[section].stations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MRTCell", forIndexPath: indexPath) as! MRTTableViewCell
        let station = self.MRTData.lines[indexPath.section].stations[indexPath.row]
        
        cell.nameLabel.text = station.name

        if station.lines.count > 1 {
            
            for constraint in cell.lineNumStackView.constraints as [NSLayoutConstraint]{
                if(constraint.identifier=="lineNumStackViewWidth"){
                    constraint.constant = 136
//                    print(constraint.constant)
                }
            }

        } else {
            
            for constraint in cell.lineNumStackView.constraints as [NSLayoutConstraint]{
                if(constraint.identifier=="lineNumStackViewWidth"){
                    constraint.constant = 64
//                    print(constraint.constant)
                }
            }
        }
        
        cell.lineNumStackView.axis = .Horizontal
        cell.lineNumStackView.distribution = .FillEqually
        cell.lineNumStackView.alignment = .Fill
        cell.lineNumStackView.spacing = 8
        cell.lineNumStackView.semanticContentAttribute = .ForceRightToLeft
        
        if cell.lineNumStackView.subviews.count != 0 {
            while(cell.lineNumStackView.arrangedSubviews.count>0){
                let subview:UIView? = cell.lineNumStackView.arrangedSubviews.last
                cell.lineNumStackView.removeArrangedSubview(subview!)
                subview?.removeFromSuperview()
            }
        }
        
        for (lineName, lineNum) in station.lines {
            let myLabel = UILabel()
            myLabel.text = lineNum as? String
            myLabel.backgroundColor = colorDictionary[lineName as! String]
            myLabel.textAlignment = .Center
            myLabel.textColor = UIColor.whiteColor()
            cell.lineNumStackView.addArrangedSubview(myLabel)
        }
            
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.MRTData.lines[section].name
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        if segueIdentifier == "ShowDetail" {
            guard let detailViewController = segue.destinationViewController as?StationDetailViewController else {
                return
            }
            
            guard let cell = sender as? UITableViewCell else {return}
            let indexPath = self.tableView.indexPathForCell(cell)!
            
            let station = self.MRTData.lines[indexPath.section].stations[indexPath.row]
            detailViewController.station = station
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
