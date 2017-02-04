//
//  PageController.swift
//  Alien Life
//
//  Created by Muhammad Moaz on 2/4/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page?
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
