//
//  ViewController.swift
//  quizik
//
//  Created by uvionics on 10/4/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var category_id: String!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var optionButton1: QuizOptionButton!
    @IBOutlet weak var optionButton2: QuizOptionButton!
    @IBOutlet weak var optionButton3: QuizOptionButton!
    @IBOutlet weak var optionButton4: QuizOptionButton!
    
    private var _response: [Results]?
    
    var question: String!
    var quizOptionsList = [String?]()
    var correctAnswer: String!

    var count = 0
    
    var timerCounter: Timer?
    var timerCount = 0.0
    let progress = Progress(totalUnitCount: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManagerClass().fetchQuizBloc(difficulty: Difficulty.Easy.rawValue, category: category_id, type: Type.Multiple_Choice.rawValue){
            [weak self] (quizBloc) in
            
            self?._response = quizBloc
            print("_response is :", self!._response!);
            if self!._response != nil{
                self!.dataStorage()
            }
            
        }
        
        
        
//Uncoment The below line for setting default values
        
//        changeQuestion(question: "Who is known as the Master Blaster in cricket")
//
//        changeQuizOptions(quizOptionButton: optionButton1, optionText: "Sachin Tendulkar")
//        changeQuizOptions(quizOptionButton: optionButton2, optionText: "Rahul Dravid")
//        changeQuizOptions(quizOptionButton: optionButton3, optionText: "Virendar Sehwag")
//        changeQuizOptions(quizOptionButton: optionButton4, optionText: "Yuvaraj Singh")
//
//        correctAnswer = "Sachin Tendulkar"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let alert = UIAlertController(title: nil, message: "Loading Questions....", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.questionText.isHidden = true
        self.stackView.isHidden = true
        self.progressView.isHidden = true
        
        self.present(alert, animated: false, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timerCounter?.invalidate()
    }
    
    func changeQuestion(question: String){
        questionText.text = "Q\(count + 1). \(question)"
    }
    
    func changeQuizOptions(quizOptionButton: UIButton, optionText: String){
        quizOptionButton.setTitle(optionText, for: .normal)
    }
    
    @IBAction func optionButton1Action(_ sender: Any) {
        optionButton1.isChecked =
            !optionButton1.isChecked
        optionButton2.isChecked = false
        optionButton3.isChecked = false
        optionButton4.isChecked = false
        
        submitButtonAction()
    }
    
    @IBAction func optionButton2Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = !optionButton2.isChecked
        optionButton3.isChecked = false
        optionButton4.isChecked = false
        
        submitButtonAction()
    }
    
    @IBAction func optionButton3Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = false
        optionButton3.isChecked = !optionButton3.isChecked
        optionButton4.isChecked = false
        
        submitButtonAction()
    }
    
    @IBAction func optionButton4Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = false
        optionButton3.isChecked = false
        optionButton4.isChecked = !optionButton4.isChecked
        
        submitButtonAction()
    }
    
    func submitButtonAction() {
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
        
        optionButton1.isUserInteractionEnabled = false
        optionButton2.isUserInteractionEnabled = false
        optionButton3.isUserInteractionEnabled = false
        optionButton4.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.count = self.count + 1
            self.optionButton1.isChecked = false
            self.optionButton2.isChecked = false
            self.optionButton3.isChecked = false
            self.optionButton4.isChecked = false
            if self.count != 10{
                self.dataStorage()
                self.timerCounter?.invalidate()
            }
            else{
                self.navigationController?.popViewController(animated: true)
                self.timerCounter?.invalidate()
            }
            
        })
        
        
        
    }
    
    func dataStorage(){
        self.question = self._response?[self.count].question!.htmlDecoded
        self.quizOptionsList = [self._response?[self.count].correct_answer!.htmlDecoded, self._response?[self.count].incorrect_answers?[0].htmlDecoded, self._response?[self.count].incorrect_answers?[1].htmlDecoded, self._response?[self.count].incorrect_answers?[2].htmlDecoded]
            self.correctAnswer = self._response?[self.count].correct_answer?.htmlDecoded
        updateUI()
    }
    
    func updateUI(){
        DispatchQueue.main.async {
            self.changeQuestion(question: self.question)
            self.quizOptionsList.shuffle()
            self.changeQuizOptions(quizOptionButton: self.optionButton1, optionText: self.quizOptionsList[0]!)
            self.changeQuizOptions(quizOptionButton: self.optionButton2, optionText: self.quizOptionsList[1]!)
            self.changeQuizOptions(quizOptionButton: self.optionButton3, optionText: self.quizOptionsList[2]!)
            self.changeQuizOptions(quizOptionButton: self.optionButton4, optionText: self.quizOptionsList[3]!)
            
            self.dismiss(animated: true, completion: nil)
            self.questionText.isHidden = false
            self.stackView.isHidden = false
            self.progressView.isHidden = false
            
            self.optionButton1.isUserInteractionEnabled = true
            self.optionButton2.isUserInteractionEnabled = true
            self.optionButton3.isUserInteractionEnabled = true
            self.optionButton4.isUserInteractionEnabled = true
                    
            self.progressView.progress = 0.0
            self.timerCount = 0.0
            self.progressView.progressTintColor = UIColor.blue
//            self.progress.completedUnitCount = 0

            self.timerCounter = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
                (timer) in
                guard self.timerCount < 8.0 else{
                    timer.invalidate()
                    self.submitButtonAction()
                    return
                }

//                self.progress.completedUnitCount += 1
                self.timerCount += 0.01
                if self.timerCount > 6.0 {
                    self.progressView.progressTintColor = UIColor.red.withAlphaComponent(0.6)
                }
                self.progressView.setProgress(Float(self.timerCount / 8.0), animated: true)
            }
//            UIView.animate(withDuration: 0.0, animations: {
//                self.progressView.setProgress(0.0, animated: true)
//            })
//            UIView.animate(withDuration: 6.0, animations: {
//                self.progressView.setProgress(1.0, animated: true)
//            })
            
        }
    }
}

class QuizOptionButton: UIButton{
    
    var isChecked: Bool = false{
        didSet{
            if isChecked{
//                self.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
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
        self.isChecked = false
        self.setTitleColor(.black, for: .normal)
//        self.titleEdgeInsets.left = 25.0
        self.layer.cornerRadius = self.frame.size.height / 10
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
