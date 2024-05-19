//
//  ViewController.swift
//  PinterestGrid
//
//  Created by Kriti Agarwal on 19/05/24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ViewController: UIViewController, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collectionView
    }()
    
    struct Model {
        let imageName: String
        let height: CGFloat
    }
    
    private var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = Array(1...20).map { "post\($0)"}
        models = images.compactMap{
            return Model.init(
                imageName: $0,
                height: CGFloat.random(in: 200...400)
            )
        }
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath
        ) as? ImageCollectionViewCell else {
            fatalError()
        }
        cell.configure(image: UIImage(named: models[indexPath.item].imageName))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2,
                      height: models[indexPath.row].height)
    }

}

