//
//  HeaderURL.swift
//  MagtonicMobileReport
//
//  Created by richie shih on 2019/6/25.
//  Copyright © 2019 richie shih. All rights reserved.
//

import Foundation

class HeaderURL {
    
    var header: String = ""
    var urlString: String = ""
    
    init(header: String, urlString: String) {
        self.header = header
        self.urlString = urlString
    }
    
    func getHeader() -> String {
        return header
    }
    
    func setHeader(header: String) {
        self.header = header
    }
    
    func getUrlString() -> String {
        return urlString
    }
    
    func setUrlString(urlString: String) {
        self.urlString = urlString
    }
}
