//
//  landingViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 31/01/23.
//

import UIKit

class landingViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var tutView:UIView!
    @IBOutlet weak var tutScroll:UIScrollView!
    @IBOutlet weak var skip:UIButton!
    @IBOutlet weak var pageControl:UIPageControl!
    //@IBOutlet weak var imagVw:UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let usedVal = UserDefaults.standard.value(forKey: "used") as? String
        {
            
            self.tutView.isHidden = true
            self.pageControl.isHidden = true
            
        }
        else
        {
            
            
            
            for i in stride(from: 0, to: 5, by: 1) {
                var imgview:UIImageView  = UIImageView()
                imgview.frame = CGRectMake(CGFloat(i)*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)
                imgview.image = UIImage(named: "tut\(i).png")
                //imgview.contentMode = .scaleAspectFill
                self.tutScroll.addSubview(imgview)
                let contentRect: CGRect = self.tutScroll.subviews.reduce(into: .zero) { rect, view in
                    rect = rect.union(imgview.frame)
                }
                self.tutScroll.contentSize = contentRect.size
                
            }
            self.configurePageControl()
            self.tutView.isHidden = false
        }
    }
    @IBAction func takeTour()
    {
        for i in stride(from: 0, to: 5, by: 1) {
            var imgview:UIImageView  = UIImageView()
            imgview.frame = CGRectMake(CGFloat(i)*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)
            imgview.image = UIImage(named: "tut\(i).png")
            //imgview.contentMode = .scaleAspectFill
            self.tutScroll.addSubview(imgview)
            let contentRect: CGRect = self.tutScroll.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(imgview.frame)
            }
            self.tutScroll.contentSize = contentRect.size
            
        }
        self.configurePageControl()
        self.tutView.isHidden = false
    }
    func configurePageControl() {
         self.pageControl.numberOfPages = 5
         self.pageControl.currentPage = 0
         self.pageControl.tintColor = ColorManager.incomeColor()
         self.pageControl.pageIndicatorTintColor = ColorManager.incomeColor()
         self.pageControl.currentPageIndicatorTintColor = ColorManager.expenseColor()
        self.pageControl.isHidden = false
         //self.view.addSubview(pageControl)
     }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        if(pageNumber == 4.0)
            {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.skipTut()
            })
            }
        }
        // Do any additional setup after loading the view.
    
    @IBAction func skipTut()
    {
        self.tutView.isHidden = true
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
