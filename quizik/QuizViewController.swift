//
//  ViewController.swift
//  quizik
//
//  Created by uvionics on 10/4/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var optionButton1: QuizOptionButton!
    @IBOutlet weak var optionButton2: QuizOptionButton!
    @IBOutlet weak var optionButton3: QuizOptionButton!
    @IBOutlet weak var optionButton4: QuizOptionButton!
    
    var correctAnswer: String!
    
    private var _response: [Results]?
    
    var quizOptionsList = [String?]()
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManagerClass().fetchQuizBloc{
            [weak self] (quizBloc) in
            
            self?._response = quizBloc
            
            
            print("_response is :", self!._response);
            DispatchQueue.main.async {
                
                self!.changeQuestion(question:  self!._response![0].question!.htmlDecoded)
                self!.quizOptionsList = [self!._response?[0].correct_answer!, self!._response?[0].incorrect_answers?[0], self!._response?[0].incorrect_answers?[1], self!._response?[0].incorrect_answers?[2]]
                
                self!.quizOptionsList.shuffle()
                
                self!.changeQuizOptions(quizOptionButton: self!.optionButton1, optionText: self!.quizOptionsList[0]!.htmlDecoded)
                self!.changeQuizOptions(quizOptionButton: self!.optionButton2, optionText: self!.quizOptionsList[1]!.htmlDecoded)
                self!.changeQuizOptions(quizOptionButton: self!.optionButton3, optionText: self!.quizOptionsList[2]!.htmlDecoded)
                self!.changeQuizOptions(quizOptionButton: self!.optionButton4, optionText: self!.quizOptionsList[3]!.htmlDecoded)
                self!.correctAnswer = self!._response![0].correct_answer
                            
            }
        }
        
        
        
//        changeQuestion(question: "Who is known as the Master Blaster in cricket")
//
//        changeQuizOptions(quizOptionButton: optionButton1, optionText: "Sachin Tendulkar")
//        changeQuizOptions(quizOptionButton: optionButton2, optionText: "Rahul Dravid")
//        changeQuizOptions(quizOptionButton: optionButton3, optionText: "Virendar Sehwag")
//        changeQuizOptions(quizOptionButton: optionButton4, optionText: "Yuvaraj Singh")
//
//        correctAnswer = "Sachin Tendulkar"
        
        buttonShape(button: submitButton)
        
    }
    
    func changeQuestion(question: String){
        questionText.text = "Q. \(question)"
    }
    
    func changeQuizOptions(quizOptionButton: UIButton, optionText: String){
        quizOptionButton.setTitle(optionText, for: .normal)
    }
    
    func buttonShape(button: UIButton){
        button.layer.cornerRadius = button.frame.size.height / 2
    }
    
    @IBAction func optionButton1Action(_ sender: Any) {
        optionButton1.isChecked =
            !optionButton1.isChecked
        optionButton2.isChecked = false
        optionButton3.isChecked = false
        optionButton4.isChecked = false
    }
    
    @IBAction func optionButton2Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = !optionButton2.isChecked
        optionButton3.isChecked = false
        optionButton4.isChecked = false
    }
    
    @IBAction func optionButton3Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = false
        optionButton3.isChecked = !optionButton3.isChecked
        optionButton4.isChecked = false
    }
    
    @IBAction func optionButton4Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = false
        optionButton3.isChecked = false
        optionButton4.isChecked = !optionButton4.isChecked
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if optionButton1.titleLabel?.text == correctAnswer {
            if optionButton1.isChecked {
                optionButton1.isCorrectAnswer = true
            }
            else{
                optionButton1.isCorrectAnswer = true
                optionButton2.isInCorrectAnswer = optionButton2.isChecked
                optionButton3.isInCorrectAnswer = optionButton3.isChecked
                optionButton4.isInCorrectAnswer = optionButton4.isChecked
            }
        }
        else if optionButton2.titleLabel?.text == correctAnswer {
            if optionButton2.isChecked {
                optionButton2.isCorrectAnswer = true
            }
            else{
                optionButton1.isInCorrectAnswer = optionButton1.isChecked
                optionButton2.isCorrectAnswer = true
                optionButton3.isInCorrectAnswer = optionButton3.isChecked
                optionButton4.isInCorrectAnswer = optionButton4.isChecked
            }
        }
        else if optionButton3.titleLabel?.text == correctAnswer {
            if optionButton3.isChecked {
                optionButton3.isCorrectAnswer = true
            }
            else{
                optionButton1.isInCorrectAnswer = optionButton1.isChecked
                optionButton2.isInCorrectAnswer = optionButton2.isChecked
                optionButton3.isCorrectAnswer = true
                optionButton4.isInCorrectAnswer = optionButton4.isChecked
            }
        }
        else if optionButton4.titleLabel?.text == correctAnswer {
            if optionButton4.isChecked {
                optionButton4.isCorrectAnswer = true
            }
            else{
                optionButton1.isInCorrectAnswer = optionButton1.isChecked
                optionButton2.isInCorrectAnswer = optionButton2.isChecked
                optionButton3.isInCorrectAnswer = optionButton3.isChecked
                optionButton4.isCorrectAnswer = true
            }
        }
    }
    
}

class QuizOptionButton: UIButton{
    
    var isChecked: Bool = false{
        didSet{
            if isChecked{
                self.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
            }
            else{
                self.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    var isCorrectAnswer: Bool = false{
        didSet{
            if isCorrectAnswer{
                self.backgroundColor = UIColor.green.withAlphaComponent(0.6)
            }
            else{
            }
        }
    }
    
    var isInCorrectAnswer: Bool = false{
        didSet{
            if isInCorrectAnswer{
                self.backgroundColor = UIColor.red.withAlphaComponent(0.6)
            }
            else{
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(checkBoxClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
        self.setTitleColor(.white, for: .normal)
        self.titleEdgeInsets.left = 25.0
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    
    @objc func checkBoxClicked(sender: UIButton){
        if sender == self{
            //            isChecked = !isChecked
        }
    }
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}
