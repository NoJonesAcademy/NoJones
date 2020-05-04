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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(InfoCollectionViewCell.nib(), forCellWithReuseIdentifier: "InfoCollectionCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        cell.configure(with: #imageLiteral(resourceName: "achievement2-disable"))
        
        return cell
    }
    
    
    
}
