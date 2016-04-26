//
//  TagViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 4/26/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        let tag = ["Albanie", "Allemagne", "Andorre", "Autriche-Hongrie", "Belgique", "Bulgarie", "Danemark", "Espagne", "France", "Grèce", "Italie", "Liechtenstein", "Luxembourg", "Monaco", "Monténégro", "Norvège", "Pays-Bas", "Portugal", "Roumanie", "Royaume-Uni", "Russie", "Saint-Marin", "Serbie", "Suède", "Suisse"]
        
        RRTagController.displayTagController(self, tagsString: tag, blockFinish: { (selectedTags, unSelectedTags) -> () in
        }) { () -> () in
        }
        
    }

}
