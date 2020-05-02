//
//  OnBoardingViewController.swift
//  NoJones
//
//  Created by Joseph on 22/04/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
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
        
        nextButton.layer.cornerRadius = 8
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:37, y:92, width:311, height:219)
            imageView.contentMode = .scaleAspectFit
          
            let txt1 = UILabel.init(frame: CGRect(x:0, y:341, width:375, height:24))
            txt1.textAlignment = .center
            txt1.font = UIFont(name: "AppleSDGothicNeo-Regular" , size: 22)
            txt1.textColor = UIColor(named: "buttonColor")
            txt1.text = titles[index]

            let txt2 = UILabel.init(frame: CGRect(x:41, y:381, width:292, height:88))
            txt2.textAlignment = .center
            txt2.numberOfLines = 7
            txt2.font = UIFont(name: "AppleSDGothicNeo-Light", size: 17)
            txt2.textColor = UIColor(named: "buttonColor")
            txt2.text = descs[index]

            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)

        }

        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        self.scrollView.contentSize.height = 1.0
        
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
        if pageControl.currentPage == 2 {
            nextButton.setTitle("Start", for: .normal)
        }
        else{
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @IBAction func skipPage(_ sender: Any) {
        // Change storyboard
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        
        if pageControl.currentPage == 2 {
            nextButton.setTitle("Start", for: .normal)
        }
        else{
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        if nextButton.currentTitle == "Start" {

            //  Foi criada uma segue na OnBoarding para a InitialScreen com o
            //  idenficador chamado segue
           performSegue(withIdentifier: "segue", sender: nil)
        }
        else {
            pageControl.currentPage = pageControl.currentPage + 1
            scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
            if pageControl.currentPage == 2 {
                nextButton.setTitle("Start", for: .normal)
            }
        }
            
    }
    
    @IBAction func previousPage(_ sender: Any) {
        pageControl.currentPage = pageControl.currentPage - 1
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        if pageControl.currentPage != 2 {
            nextButton.setTitle("Next", for: .normal)
        }
    }

}

