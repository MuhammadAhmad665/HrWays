//
//  MainVC.swift
//  Fenix
//
//  Created by Ahmed on 01/04/2022.
//

import UIKit

class MainVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    var serverRequest = MVP()
    var moviePoster: PaginationPosters = PaginationPosters(json: JSON())
    
    var selectedPage: Int = 1
    var selectedText: String = ""
    var apiRequested: Bool = false
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /**super.viewDidLoad()**/
        collectionView.register(UINib(nibName: "MovieCVC", bundle: nil), forCellWithReuseIdentifier: "MovieCVC")
        serverRequest.delegate = self
        self.txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
    }
}
//MARK: Collection View Delegate Methods
extension MainVC: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moviePoster.moviesPosters.count == 0{
            collectionView.alpha = 0
            return 0
        }else{
            collectionView.alpha = 1
            return moviePoster.moviesPosters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVC", for: indexPath) as! MovieCVC
        cell.txtName.text = moviePoster.moviesPosters[indexPath.row].originalTitle
        cell.imgPoster.downloadImage(imageUrl: moviePoster.moviesPosters[indexPath.row].posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.4, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        if moviePoster.page != moviePoster.totalPages{
            if indexPath.row >= (moviePoster.moviesPosters.count  - 5){
                if apiRequested == false{
                    apiRequested = true
                    selectedPage = selectedPage + 1
                    serverRequest.requestGETAPI(vc: self, url: "\(Apis.baseURL)=\(Apis.api_key)&query=\(selectedText)&page=\(selectedPage)", method: .get, type: "", loading: false)
                }
                
            }
            
        }
    }
}
//MARK: UITextFieldDelegate
extension MainVC: UITextFieldDelegate{
    @objc
    func textFieldDidChange(textField: UITextField){
        if (textField.text?.count ?? 0) > 1{
            selectedText = textField.text!
            serverRequest.requestGETAPI(vc: self, url: "\(Apis.baseURL)=\(Apis.api_key)&query=\(textField.text!)", method: .get, type: "", loading: false)
            
            
        }else if textField.text == ""{
            moviePoster = PaginationPosters(json: JSON())
            collectionView.reloadData()
        }
        
    }
}

//MARK: serverResponse
extension MainVC: serverResponse{
    func onSuccess(json: JSON, val: String) {
        if apiRequested == true{
            apiRequested = false
            json["results"].arrayValue.forEach{
                moviePoster.moviesPosters.append(MoviesPosters(json: $0))
            }
            collectionView.reloadData()
            
        }else{
            moviePoster = PaginationPosters(json: json)
            collectionView.reloadData()
        }
        
    }
}
