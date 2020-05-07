//
//  OnBoardingViewController1.swift
//  NoJones
//
//  Created by Joseph on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var pages: [Page] = [
        Page(image: "onboarding1", title: "Vença seus Vícios", content: "Iniciar a jornada de combate a um vício pode ser dura e desafiante.\n Use-o como um reforço na sua luta diária contra seus vícios."),
        Page(image: "onboarding2", title: "Acompanhe o progresso", content: "Visualize seu progresso diariamente no combate de cada vício através de um calendário que mostrará de maneira rápida e fácil."),
        Page(image: "onboarding3", title: "Ganhe Recompensas", content: "Cumpra os objetivos de cada vício e ganhe recompensas para se sentir motivado em continuar combatendo seus vícios."),
    ]
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        nextButton.layer.cornerRadius = 8
        viewDidLayoutSubviews(CGSize(width: scrollView.frame.width, height: scrollView.frame.height))
        
//      carrega as subviews
        setupSlideScrollView()
        scrollView.delegate = self
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        loadPages()
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    
        if pageControl.currentPage == 2 {
        nextButton.setTitle("Avançar", for: .normal)
        }
        else{
            nextButton.setTitle("Avançar", for: .normal)
        }
    }
        
    @IBAction func nextPage(_ sender: Any) {
        if nextButton.currentTitle == "Começar" {

            //  Foi criada uma segue na OnBoarding para a InitialScreen com o
            //  idenficador chamado segue
            performSegue(withIdentifier: SegueDestination.InitialScreen.rawValue, sender: nil)
        }
        else {
            pageControl.currentPage = pageControl.currentPage + 1
            scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
            if pageControl.currentPage == 2 {
                nextButton.setTitle("Começar", for: .normal)
            }
        }
    }
    
    @IBAction func previousPage(_ sender: Any) {
        pageControl.currentPage = pageControl.currentPage - 1
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        if pageControl.currentPage != 2 {
            nextButton.setTitle("Próximo", for: .normal)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewDidLayoutSubviews(size)
        setupSlideScrollView()
        loadPages()
    }
}
    
extension OnBoardingViewController: UIScrollViewDelegate {
    
//  método resposável por criar o formato dos frames da scrollview
    func setupSlideScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollWidth, height: scrollHeight)
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(pages.count), height: scrollHeight)
        scrollView.isPagingEnabled = true
    }
    
    func loadPages() {
        for (index, page) in pages.enumerated() {
            let slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.page = page
            
            slide.frame = CGRect(x: scrollView.frame.width * CGFloat(index), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slide)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
        if pageControl.currentPage == 2 {
            nextButton.setTitle("Começar", for: .normal)
        }
        else{
            nextButton.setTitle("Próximo", for: .normal)
       }
    }
    
    func viewDidLayoutSubviews(_ size: CGSize) {
        scrollWidth = size.width
        scrollHeight = size.height
    }
}

