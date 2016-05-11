//
//  MRTData.swift
//  hw2_102703029
//
//  Created by 盧與明 on 2016/5/2.
//  Copyright © 2016年 YuMing_Lu. All rights reserved.
//

import Foundation
import ObjectMapper

struct Line {
    var name: String
    var stations: [Station]
}

struct Station {
    var name: String = ""
    var coordinates: NSArray = []
    var lines: NSDictionary = [String: String]()
    
    init?(fromData dict: Station) {
        self.name = dict.name
        self.coordinates = dict.coordinates
        self.lines = dict.lines
    }
    
}

extension Station: Mappable {
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.coordinates <- map["coordinates"]
        self.lines <- map["lines"]
    }
    
}

enum MRTSourceErrorType: ErrorType {
    case FileNotFound
    case InvalidContent
}

struct MRTDataSource {
    let lines: [Line]
    
    init(contentsOfFile path: String) throws {
        let jsonContent = try! String(contentsOfFile: path)
        NSLog(jsonContent)

        guard let rawData = Mapper<Station>().mapArray(jsonContent) else {
            throw MRTSourceErrorType.InvalidContent
        }
        
        var lineStationMap = [String: [Station]]()
        
        for stationDict in rawData {
            for stationLines in stationDict.lines.allKeys {
                if lineStationMap[stationLines as! String] == nil {
                    lineStationMap[stationLines as! String] = []
                }
                lineStationMap[stationLines as! String]!.append(stationDict)
            }
        }

        var _lines = [Line]()
        for (lineName, stations) in lineStationMap {
            let line = Line(name: lineName, stations: stations)
            _lines.append(line)
        }
        self.lines = _lines.sort { (lineA: Line, lineB: Line) -> Bool in
            return lineA.name < lineB.name
        }
    }
}

let colorDictionary = [
    "文湖線": UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1.0),
    "淡水信義線": UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1.0),
    "新北投支線": UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1.0),
    "松山新店線": UIColor(red: 0, green: 119/255, blue: 73/255, alpha: 1.0),
    "小碧潭支線": UIColor(red: 206/255, green: 220/255, blue: 0, alpha: 1.0),
    "中和新蘆線": UIColor(red: 255/255, green: 163/255, blue: 0, alpha: 1.0),
    "板南線": UIColor(red: 0, green: 94/255, blue: 184/255, alpha: 1.0),
    "貓空纜車": UIColor(red: 119/255, green: 185/255, blue: 51/255, alpha: 1.0)
]



