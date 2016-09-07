//
//  scrollView.swift
//  fasionshop2
//
//  Created by do duy hung on 05/09/2016.
//  Copyright © 2016 do duy hung. All rights reserved.
//

import UIKit

class scrollView: UIViewController,UIScrollViewDelegate {
    var pageimage : [String] = []
    var photo: [UIImageView] = []
    
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    var shop = 0;
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var lb_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addItem(shop)
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageimage.count
        //scrollView.minimumZoomScale = 0.5
        //scrollView.maximumZoomScale = 2
    }
    func setupNew(){
        if (!first){
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageimage.count), 0)
            scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
            
            //show image
            for (var i = 0 ; i < pageimage.count; i++){
                let imgView = UIImageView(image:UIImage(named: pageimage[i]))
                
                imgView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width,0, scrollView.frame.size.width, scrollView.frame.size.height)
                
                imgView.contentMode = .ScaleAspectFit
                self.scrollView.addSubview(imgView)
                
                // add tap
                addaction(imgView)
                
                
                photo.append(imgView)
                //add front
                
                addfront(i, imgView: imgView)
                // add frontScroll

                self.scrollView.addSubview(imgView)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupNew()
    }
    
    // them front
    func addfront(i : Int, imgView : UIImageView){
        let frontScrollView = UIScrollView(frame: CGRectMake(CGFloat(i) * scrollView.frame.size.width,0,scrollView.frame.size.width,scrollView.frame.size.height))
        frontScrollView.minimumZoomScale = 1
        frontScrollView.maximumZoomScale = 2
        frontScrollView.delegate = self
        frontScrollView.contentSize = imgView.bounds.size
        
        frontScrollViews.append(frontScrollView)
        self.scrollView.addSubview(frontScrollView)
    }
    
    // them tap
    func addaction(imgView: UIImageView){
        imgView.multipleTouchEnabled = true;
        imgView.userInteractionEnabled = true;
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapImg:"))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector("doubleTabImg:"))
        doubleTap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(doubleTap)
        tap.requireGestureRecognizerToFail(doubleTap)
    }
    
    // them anh
    func addItem(shop : Int){
        var z = 8
        for(var i = shop ; i <= shop ; i++){
            for (var j = 0 ; j < z ; j++ ){
                pageimage.append("shop\(shop)-\(j).jpg")
                //print(pageimage[j])
                //var z = UIImage(named: pageimage[j])
                if (UIImage(named: pageimage[j]) == nil){
                pageimage.removeAtIndex(j)
                    z--
                }
            }
        }
    }
    
    func tapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 1.5, center: position)
    }
    func doubleTabImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollViews[pageController.currentPage] .zoomToRect(zoomRect, animated: true)
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo[pageController.currentPage]
    }
    
    @IBAction func OnChange(sender: UIPageControl) {
        
        scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)

    }
    func scrollViewDidScroll(scrollView: UIScrollView){
    pageController.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        lb_title.text = String(pageController.currentPage + 1)
    }
   
    @IBAction func Move(sender: UIButton) {
        switch (sender.tag)
        {
        case 110:NextImg()
        case 111:PreImg()
        default:break
        }
    }
    
    func NextImg(){
        if(pageController.currentPage <= photo.count){
            pageController.currentPage += 1;
            scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)
        }
    }
    func PreImg(){
        if (pageController.currentPage > 0){
            pageController.currentPage -= 1;
            scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)
        }

    }
}
