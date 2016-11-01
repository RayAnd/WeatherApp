//
//  Response.swift
//  WeatherApp
//
//  Created by Andrey Kozlov on 01/11/2016.
//  Copyright © 2016 ebay. All rights reserved.
//

import Foundation

enum Response<ResponseData> {
    case success(ResponseData)
    case failed(Error)
}
