//
//  StartPageViewController.swift
//  quizik
//
//  Created by uvionics on 10/26/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {

    @IBOutlet weak var startQuizButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func startQuizButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizCategoryViewController")
        self.navigationController?.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
