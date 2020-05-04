//
//  InfoViewController.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var knowAppImage: UIImageView!
    @IBOutlet weak var saibaMaisView: UIView!
    @IBOutlet weak var opacityLayerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let layout = UICollectionViewFlowLayout()
       
        let width = collectionView.frame.width/2 - 10
        let height = collectionView.frame.height/2 - 5
        
        
        print(width)
        print(collectionView.frame.width)
        
        
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = CGFloat(0)
        //layout.minimumLineSpacing = CGFloat(0)
        
        
        collectionView.collectionViewLayout = layout

        collectionView.register(InfoCollectionViewCell.nib(), forCellWithReuseIdentifier: "InfoCollectionCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        opacityLayerView.layer.cornerRadius = 15
        knowAppImage.layer.cornerRadius = 15
        knowAppImage.image = #imageLiteral(resourceName: "onboarding1")
        
        saibaMaisView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
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

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionCell", for: indexPath) as! InfoCollectionViewCell
        
        cell.configure(image: #imageLiteral(resourceName: "achievement3-enable"), text: "Esta funcionando muito bem")
        
        return cell
    }
    
    
    
}
