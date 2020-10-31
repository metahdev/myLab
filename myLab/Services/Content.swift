//
//  Content.swift
//  myLab
//
//  Created by Metah on 10/30/20.
//

import Foundation

struct Content {
    static let subjects = ["Comp. Science", "Physics", "Chemistry", "Biology"]
    static let subjectsImages = ["cs", "physics", "chemistry", "biology"]
    
    static let entryImages = ["app", "science", "comms", "cube"]
    static let entryTitles = ["myLab", "Everything you need", "Ask. Help. Compete.", "Augmented Reality"]
    static let entryDescription = ["myLab - a platform where you can explore natural Sciences in an engaging, social way", "Our app contains every topic of High School natural Sciences classes, explaining each of them in a clear, comprehensive, and interactive way.", "In myLab, you can ask any question you are interested in Science and get help from your peers. Also, you can challenge your friends in fun quizzes!", "We try our best to provide students with a memorable explanation, so our app does not only include video tutorials, but also an augmented reality technology for you to play around with!"]
    
    static let choises = [["p = mv", "p = m / v", "p = 1/2 mv", "p = 2mv"], ["vector", "vacuum", "velocity", "volume"], ["10kg", "5kg", "20kg", "15kg"]]
    
    static var currentTopicTitle = "Introduction to Momentum"
    static var currentTopicImage = "momentum"
    static var currentTopic = "Mechanics: chapter 5"
    static var progress: Float = 0.5
}
