//
//  ScrollViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/04/05.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollBackView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    struct Photo {
        var imageName: String
        var title: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photoList = [
            Photo(imageName: "photo1", title: "photo1"),
            Photo(imageName: "photo2", title: "photo2"),
            Photo(imageName: "photo3", title: "photo3"),
            Photo(imageName: "photo4", title: "photo4")
        ]
        
        let subView = createContentView(contentList: photoList)
        scrollView.addSubview(subView)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = subView.frame.size
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.delegate = self
        
        pageControl.numberOfPages = photoList.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.systemPink
        pageControl.currentPageIndicatorTintColor = UIColor.systemBlue
        
    }
    
    func createContentView(contentList: Array<Photo>) -> UIView {
        let contentView = UIView()
        let pageWidth = self.view.frame.width
        let pageHeight = scrollView.frame.height
        let pageViewRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let photoSize = CGSize(width: 250, height: 250)
        contentView.frame = CGRect(x: 0, y: 0, width: pageWidth*4, height: pageHeight)
        let colors: Array<UIColor> = [.systemRed, .systemYellow, .systemPink, .systemBlue]
        for i in 0..<contentList.count {
            let contentItem = contentList[i]
            let pageView = createPage(viewRect: pageViewRect, imageSize: photoSize, item: contentItem)
            let left = pageViewRect.width * CGFloat(i)
            let xy = CGPoint(x: left, y: 0)
            pageView.frame = CGRect(origin: xy, size: pageViewRect.size)
            pageView.backgroundColor = colors[i]
            contentView.addSubview(pageView)
        }
        return contentView
    }

    func createPage(viewRect:CGRect, imageSize:CGSize, item:Photo) -> UIView {
        let pageView = UIView(frame: viewRect)
        let photoView = UIImageView()
        let left = (pageView.frame.width - imageSize.width)/2
        photoView.frame = CGRect(x: left, y: 10, width: imageSize.width, height: imageSize.height)
        photoView.contentMode = .scaleAspectFill
        photoView.image = UIImage(named: item.imageName)
        
        let titleFrame = CGRect(x: left, y: photoView.frame.maxY+10, width: 200, height: 21)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = item.title
        
        pageView.addSubview(photoView)
        pageView.addSubview(titleLabel)
        return pageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNo = Int(scrollView.contentOffset.x/scrollView.frame.width)
        pageControl.currentPage = pageNo
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
