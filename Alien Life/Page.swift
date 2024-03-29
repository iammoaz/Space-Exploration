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

extension Page {
    
    func addChoiceWith(title: String, story: Story) -> Page {
        let page = Page(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    func addChoiceWith(title: String, page: Page) -> Page {
        switch (firstChoice, secondChoice) {
            case (.some, .some): return self
            case (.none, .none), (.none, .some): firstChoice = (title, page)
            case (.some, .none): secondChoice = (title, page)
        }
        
        return page
    }
}
