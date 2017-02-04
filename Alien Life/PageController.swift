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
    
    lazy var artworkView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        guard let page = page else { return }
        artworkView.image = page.story.artwork
        storyLabel.attributedText = getAttributedString(for: page.story.text)
        
        guard let firstChoice = page.firstChoice else {
            firstChoiceButton.setTitle("Play Again", for: .normal)
            firstChoiceButton.addTarget(self, action: #selector(PageController.playAgain), for: .touchUpInside)
            return
        }
        
        firstChoiceButton.setTitle(firstChoice.title, for: .normal)
        firstChoiceButton.addTarget(self, action: #selector(PageController.loadFirstChoice), for: .touchUpInside)
        
        guard let secondChoice = page.secondChoice else { return }
        secondChoiceButton.setTitle(secondChoice.title, for: .normal)
        secondChoiceButton.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artworkView)
        view.addSubview(storyLabel)
        view.addSubview(firstChoiceButton)
        view.addSubview(secondChoiceButton)
        
        configureArtworkImageConstraints()
        configureStoryLabelConstraints()
        configureChoiceButtonConstraints()
    }
    
    func configureArtworkImageConstraints() {
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func configureStoryLabelConstraints() {
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0),
        ])
    }
    
    func configureChoiceButtonConstraints() {
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
            
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }
    
    func getAttributedString(for string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func loadFirstChoice() {
        guard let page = page, let firstChoice = page.firstChoice else { return }
        let nextPage = firstChoice.page
        let pageController = PageController(page: nextPage)
        
        navigationController?.pushViewController(pageController, animated: true)
    }
    
    func loadSecondChoice() {
        guard let page = page, let secondChoice = page.secondChoice else { return }
        let nextPage = secondChoice.page
        let pageController = PageController(page: nextPage)
        
        navigationController?.pushViewController(pageController, animated: true)
    }
    
    func playAgain() {
        navigationController?.popToRootViewController(animated: true)
    }
}
