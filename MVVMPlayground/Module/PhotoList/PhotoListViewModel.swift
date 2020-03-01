//
//  PhotoListViewModel.swift
//  MVVMPlayground
//
// Created by Madhur Jain on 29/02/2019


import Foundation

class PhotoListViewModel {
    
    let apiService: APIServiceProtocol

    private var photos: [Photo] = [Photo]()
    
    private var cellViewModels: [PhotoListCellViewModel] = [PhotoListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isAllowSegue: Bool = false
    
    var selectedPhoto: Photo?

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedPhoto(photos: photos)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PhotoListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( photo: Photo ) -> PhotoListCellViewModel {

        //Wrap a description
        var descTextContainer: [String] = [String]()
        if let camera = photo.camera {
            descTextContainer.append(camera)
        }
        if let description = photo.photoDescription {
            descTextContainer.append( description )
        }
        let desc = descTextContainer.joined(separator: " - ")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return PhotoListCellViewModel( titleText: photo.name!,
                                       descText: desc,
                                       imageUrl:  photo.imageURL![0],
                                       dateText: dateFormatter.string(from: photo.createdAt!) )
    }
    
    private func processFetchedPhoto( photos: [Photo] ) {
        self.photos = photos // Cache
        var vms = [PhotoListCellViewModel]()
        for photo in photos {
            vms.append( createCellViewModel(photo: photo) )
        }
        self.cellViewModels = vms
    }
    
}

extension PhotoListViewModel {
    func userPressed( at indexPath: IndexPath ){
        let photo = self.photos[indexPath.row]
            self.isAllowSegue = true
            self.selectedPhoto = photo
    }
}

struct PhotoListCellViewModel {
    let titleText: String
    let descText: String
    let imageUrl: String
    let dateText: String
}
