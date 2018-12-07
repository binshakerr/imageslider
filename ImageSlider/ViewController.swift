//
//  ViewController.swift
//  ImageSlider
//
//  Created by Eslam Shaker  on 12/6/18.
//  Copyright © 2018 Eslam Shaker . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let images = [
        UIImage(named: "5"),
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3"),
        UIImage(named: "4"),
        UIImage(named: "5"),
        UIImage(named: "1")
    ]
    
    var currentIndex = 0
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        adjustCollectionViewContentOffset()
        pageControl.numberOfPages = 5
        startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        let indexPath = collectionView.indexPath(for: collectionView.visibleCells[0])!
        if indexPath.row < images.count - 1 {
            collectionView.scrollToItem(at: IndexPath(item: indexPath.row + 1, section: indexPath.section), at: .right, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)

    }
    
    func adjustCollectionViewContentOffset() {
        if images.count > 1 {
            if collectionView.contentOffset.x == 0.0 {
                collectionView.contentOffset = CGPoint(x: view.frame.width, y: 0.0)
            }
        }
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        
        cell.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let numberOfCells = images.count
        let page = Int(scrollView.contentOffset.x) / Int(view.frame.width)
        var currentPage = 0
        
        if numberOfCells == 1 {
            return
        }
        
        let regularContentOffset = view.frame.width * CGFloat(numberOfCells - 2)
        if (scrollView.contentOffset.x >= view.frame.width * CGFloat(numberOfCells - 1)) {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x - regularContentOffset, y: 0.0)
        } else if (scrollView.contentOffset.x < view.frame.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x + regularContentOffset, y: 0.0)
        }
        
        
        if page == 0 {
            currentPage = numberOfCells - 1
        } else if page == numberOfCells - 1 {
            currentPage = 0
        } else {
            currentPage = page - 1
        }
        pageControl.currentPage = currentPage
    }
    
}

