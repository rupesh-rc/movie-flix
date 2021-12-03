//
//  ViewController.swift
//  Movie Flix
//
//  Created by Rupesh on 30/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar : UISearchBar!
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ViewController.createCompositionLayout())
    
    let movieViewModel = MovieViewModel()
    var nowPlayingMovies = [NowPlayingList]()
    var searchedMovies = [NowPlayingList]()
    var isSearchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK: HELPER FUNCTIONS
    
    func configureView() {
        configureCollectionView()
        searchBar.delegate = self
        movieViewModel.getNowPlayingMoviesList { data in
            if data.count != 0 {
                self.nowPlayingMovies = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(PopularMoviesCell().asNib(), forCellWithReuseIdentifier: PopularMoviesCell.id)
        collectionView.register(UnpopularMoviesCell().asNib(), forCellWithReuseIdentifier: UnpopularMoviesCell.id)
        collectionView.frame = CGRect(x: 0, y: 144, width: view.frame.width, height: view.frame.height-44)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    static func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        
        //ITEM
        let popularItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.45)))
        
        popularItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let unpopularItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.55)))
        
        unpopularItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        //GROUP
        let verticleGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(3/5)),
            subitems: [popularItem,unpopularItem])
        
        // SECTIONS
        let section = NSCollectionLayoutSection(group: verticleGroup)
        
        // Return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    @objc func deleteMovie(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.nowPlayingMovies.remove(at: sender.tag)
        self.collectionView.performBatchUpdates({ () -> Void in
            self.collectionView.deleteItems(at:([indexPath]))
        }) { finished in
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
        }
    }
    
}

//MARK: EXTENSIONS

//MARK: COLLECTIONVIEW DELEGTE METHODS
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchActive ? searchedMovies.count : self.nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = isSearchActive ? searchedMovies[indexPath.row] : self.nowPlayingMovies[indexPath.row]
        
        if movie.voteAverage! > 7 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesCell.id, for: indexPath) as! PopularMoviesCell
            cell.setupData(for: movie)
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(deleteMovie(_:)), for: .touchUpInside)
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnpopularMoviesCell.id, for: indexPath) as! UnpopularMoviesCell
            cell.setupData(for: movie)
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(deleteMovie(_:)), for: .touchUpInside)
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = isSearchActive ? searchedMovies[indexPath.row] : self.nowPlayingMovies[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
}

//MARK: SERCHBAR DELEGTE METHODS
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText.isEmpty {
            isSearchActive = false
            self.collectionView.reloadData()
        } else {
            isSearchActive = true
            searchedMovies = nowPlayingMovies.filter({ movie -> Bool in
                return movie.title!.lowercased().contains(searchText.lowercased())
            })
        }
        self.collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchActive = false
        self.collectionView.reloadData()
    }
}
