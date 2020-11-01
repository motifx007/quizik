//
//  QuizCategoryViewController.swift
//  quizik
//
//  Created by uvionics on 10/29/20.
//  Copyright © 2020 uvionics. All rights reserved.
//

import UIKit

class QuizCategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var array = ["First Cell", "Second Cell", "Third Cell", "Fourth Cell", "Fifth Cell"]
    
    var category_array: [Trivia_categories]?
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: nil, message: "Loading Categories....", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: false, completion: nil)
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 5
        categoryCollectionView.setCollectionViewLayout(layout, animated: true)
        
        NetworkManagerClass().fetchCategories(){
            [weak self] (category) in
            
            self?.category_array = category
            print("_response is :", self!.category_array!);
            if self!.category_array != nil{
                self!.updateCategoryView()
            }
        }
    }
    
    func updateCategoryView() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.categoryCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category_array?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! QuizCategoryCollectionViewCell
        print("The array is: ", array)
        if self.category_array != nil {
            cell.categoryLabel.text = self.category_array![indexPath.row].name
            cell.categoryImage.image = UIImage(named: "category_image")
        }
        cell.shadowDecorate()        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.category_array != nil {
           let selectedCategoryId = self.category_array![indexPath.row].id
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            vc.category_id = "\(selectedCategoryId ?? 0)"
            self.navigationController?.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
                    let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

        return CGSize(width:widthPerItem, height:widthPerItem)
    }
}
