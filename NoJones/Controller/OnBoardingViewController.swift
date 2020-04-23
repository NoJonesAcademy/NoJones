//
//  OnBoardingViewController.swift
//  NoJones
//
//  Created by Joseph on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0

    var titles = ["Vença seus Vícios","Acompanhe o progresso","Ganhe Recompensas"]
    
    var descs = ["Iniciar a jornada de combate a um vício pode ser dura e desafiante.\n Use-o como um reforço na sua luta diária contra seus vícios.","Visualize seu progresso diariamente no combate de cada vício através de um calendário que mostrará de maneira rápida e fácil.","Cumpra os objetivos de cada vício e ganhe recompensas para se sentir motivado em continuar combatendo seus vícios."]
    
    var imgs = ["onboarding1", "onboarding2", "onboarding3"]
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        viewDidLayoutSubviews()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:37, y:92, width:311, height:219)
            imageView.contentMode = .scaleAspectFit
          
            let txt1 = UILabel.init(frame: CGRect(x:0, y:341, width:375, height:24))
            txt1.textAlignment = .center
            txt1.font = UIFont(name: "AppleSDGothicNeo-Regular" , size: 22)
            txt1.textColor = .blue
            txt1.text = titles[index]

            let txt2 = UILabel.init(frame: CGRect(x:41, y:381, width:292, height:88))
            txt2.textAlignment = .center
            txt2.numberOfLines = 7
            txt2.font = UIFont(name: "AppleSDGothicNeo-Light", size: 17)
            txt2.textColor = .blue
            txt2.text = descs[index]

            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)

        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0

    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    
    @IBAction func nextPage(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

}

