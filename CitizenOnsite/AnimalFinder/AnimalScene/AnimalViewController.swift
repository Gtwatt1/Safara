//
//  AnimalViewController.swift
//  CitizenOnsite
//

import UIKit


protocol AnimalDisplayLogic: class {
    func displayDogs(_ dogs: [DogViewModel])
    func displayError(_ error: Error)
}

class AnimalViewController: UIViewController {
    var dogViewModels = [DogViewModel]()
    let numberOfCellsPerRow: CGFloat = 2
    var interactor: AnimalInteractor?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setup() {
        interactor = AnimalInteractor()
        interactor?.service = AnimalService(apiclient: ApiClientImpl())
        let presenter =  AnimalPresenter()
        presenter.view = self
        interactor?.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.fetchDogs()
        setupCollectionView()
    }
   
}

extension AnimalViewController: AnimalDisplayLogic {
    func displayDogs(_ dogs: [DogViewModel]) {
        dogViewModels = dogs
        collectionView.reloadData()
    }
    
    func displayError(_ error: Error) {
        // Implementation not added
    }
    
}


extension AnimalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dogViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AnimalCell
        cell?.dogLabel.text = dogViewModels[indexPath.row].dogName.capitalized
        cell?.dogImage.loadImageUsingCacheWithURLString(dogViewModels[indexPath.row].dogImage)
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension AnimalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:200)
    }
}


