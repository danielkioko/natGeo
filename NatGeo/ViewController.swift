//
//  ViewController.swift
//  NatGeo
//
//  Created by Daniel Nzioka on 12/5/20.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let images = ["lion", "chimp", "zebra"]
    let messages = ["They are like trees growing near a stream & sending out roots to the water. They are not afraid when hot weather comes, because their leaves stay green", "Fake trees look good, but fake trees can't bear fruit", ""]
    let messengers = ["Jeremiah 17", "Holly Furtick", ""]
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 8
    }

    @IBAction func goNext() {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = images.count
        pageControl.isHidden = !(images.count > 1)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerCell", for: indexPath) as! PagerCell
        cell.pageImage.image = UIImage(named: images[indexPath.row])
        cell.messageLabel.text = messages[indexPath.row]
        cell.messenger.text = messengers[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

class PagerCell: UICollectionViewCell {
    
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messenger: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

