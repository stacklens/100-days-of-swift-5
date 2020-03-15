//
//  ViewController.swift
//  Day 18 - Drag and Drop Item Out of CollectionView
//
//  Created by 杜赛 on 2020/3/15.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit


class AnimalCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UICollectionViewDelegateFlowLayout, UIDropInteractionDelegate
{

    // MARK: - Parameters
    private var animals = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷".map { String($0) }
    private let animalCellIdentifier = "Animal Cell"
    
    
    // MARK: - Outlets and Actions
    @IBOutlet weak var animalCollection: UICollectionView!
    @IBOutlet weak var trashView: UIView! {
        didSet {
            trashView.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    @IBOutlet weak var trashImageView: UIImageView!
    
    
    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animalCollection.delegate = self
        animalCollection.dataSource = self
        animalCollection.dragInteractionEnabled = true
        animalCollection.dragDelegate = self
        animalCollection.dropDelegate = self
    }
    
    
    // MARK: - Collection and DataSource Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: animalCellIdentifier, for: indexPath)
        if let emojiCell = cell as? AnimalCollectionCell {
            emojiCell.label.text = animals[indexPath.item]
        }
        return cell
    }
    
    
    // MARK: - Drag and Drop Delegate
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if let attributedString = (collectionView.cellForItem(at: indexPath) as? AnimalCollectionCell)?.label.attributedText {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: attributedString))
            dragItem.localObject = indexPath
            session.localContext = animalCollection
            return [dragItem]
        } else {
            return []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if let indexPath = destinationIndexPath, indexPath.section == 0 {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .cancel)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let _ = item.dragItem.localObject as? IndexPath {
                    collectionView.performBatchUpdates({
                        let element = animals.remove(at: sourceIndexPath.item)
                        animals.insert(element, at: destinationIndexPath.item)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                    })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
        }
    }
    
    
    // MARK: - FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80 , height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2.0)
    }
    
    
    // MARK: - DropInteraction Delegate
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        UIView.animate(withDuration: 0.5) {
            self.trashImageView.transform = .init(scaleX: 1.2, y: 1.2)
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        UIView.animate(withDuration: 0.5) {
            self.trashImageView.transform = .identity
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        UIView.animate(withDuration: 0.5) {
            self.trashImageView.transform = .identity
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSAttributedString.self) { (providers) in
            if let collectionView = (session.localDragSession?.localContext as? UICollectionView),
                let indexPath = session.localDragSession?.items.first?.localObject as? IndexPath
            {
                collectionView.performBatchUpdates ({ [weak self] in
                    self?.animals.remove(at: indexPath.item)
                    collectionView.deleteItems(at: [indexPath])
                })
            }
        }
    }
    
}

