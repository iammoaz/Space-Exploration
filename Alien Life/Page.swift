//
//  Page.swift
//  Alien Life
//
//  Created by Muhammad Moaz on 2/4/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

class Page {
    
    typealias Choice = (title: String, page: Page)
    
    let story: Story
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    }
}
