//
//  ContentDataModels.swift
//  PushTester
//
//  Created by Alex on 2019-07-22.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import FlybitsKernelSDK

struct ContentModelConstant {
    static let localizations = "localizations"
    static let pagination = "pagination"
}

enum ContentError: Error {
    case missingRepresentationDictionary
    case missingLocalizationsDictionary
    case missingProperty(String)
    case dataMismatch(String)
    case deserializationError(String)
    case emptyDataSet
}

class Gallery: ContentData {
    let title: String?
    let imageURL: URL?
    let imageURLs: [URL]
    
    static let title = "title"
    static let imageURL = "img"
    static let imageURLs = "gallery"
    
    required init?(responseData: Any) throws {
            
        guard let representation = responseData as? [String: Any] else {
            throw ContentError.missingRepresentationDictionary
        }
        
        self.title = representation[Gallery.title] as? String
        self.imageURL = URL(string: representation[Gallery.imageURL] as? String ?? "")
        
        guard let imageURLStrings = representation[Gallery.imageURLs] as? [String] else {
            throw ContentError.missingProperty(Gallery.imageURLs)
        }
        var urls = [URL]()
        for urlString in imageURLStrings {
            if let url = URL(string: urlString) {
                urls.append(url)
            } else {
                throw ContentError.deserializationError(Gallery.imageURLs)
            }
        }
        imageURLs = urls
        
        try super.init(responseData: representation)
    }
}


class PointOfInterest: ContentData {
    let txtPOI: String?
    let imgPOI: String?
   
    
    static let txtPOI = "txtPOI"
    static let imgPOI = "imgPOI"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Any] else {
            throw ContentError.missingRepresentationDictionary
        }
        
        self.txtPOI = representation[PointOfInterest.txtPOI] as? String
        self.imgPOI = representation[PointOfInterest.imgPOI] as? String

        try super.init(responseData: representation)
    }
}

class Youtubes: ContentData {
    
    let title: String?
    let imageURL: URL?
    let imageURLs: [URL]
    
    static let title = "title"
    static let imageURL = "img"
    static let imageURLs = "youTubeVideos"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Any] else {
            throw ContentError.missingRepresentationDictionary
        }
        
        self.title = representation[Youtubes.title] as? String
        self.imageURL = URL(string: representation[Youtubes.imageURL] as? String ?? "")
        
        guard let imageURLStrings = representation[Youtubes.imageURLs] as? [String] else {
            throw ContentError.missingProperty(Youtubes.imageURLs)
        }
        var urls = [URL]()
        for urlString in imageURLStrings {
            if let url = URL(string: urlString) {
                urls.append(url)
            } else {
                throw ContentError.deserializationError(Youtubes.imageURLs)
            }
        }
        imageURLs = urls
        
        try super.init(responseData: representation)
    }
}

class Twitter: ContentData {
    let accounts: Paged<TwitterAccount>
    
    static let accounts = "accounts"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Any] else {
            return nil
        }
        
        guard let pagerData = representation["\(Twitter.accounts).\(ContentModelConstant.pagination)"] as? [String: Any] else {
            return nil
        }
        let pager = Pager(responseData: pagerData)!
        let pages = representation[Twitter.accounts] as! [[String: Any]]
        var pagesArray = [TwitterAccount]()
        
        for page in pages {
            do {
                if let p = try TwitterAccount(responseData: page) {
                    pagesArray.append(p)
                } else {
                    // Handle some error. Debugging?
                }
            } catch {
                throw ContentError.deserializationError(Twitter.accounts)
            }
        }
        
        if !pagesArray.isEmpty {
            self.accounts = Paged<TwitterAccount>(elements: pagesArray, pager: pager)
        } else {
            throw ContentError.missingProperty(Twitter.accounts)
        }
        
        try super.init(responseData: representation)
    }
}

class TwitterAccount: ResponseObjectSerializable {
    let twitterImageURL: URL?
    let title: String?
    let twitterHandle: String?
    
    static let imageURL = "imgTwitter"
    static let title = "txtTitle"
    static let twitterHandle = "txtTwitter"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: String] else {
            return nil
        }
        
        self.twitterImageURL = URL(string: representation[TwitterAccount.imageURL] ?? "")
        self.title = representation[TwitterAccount.title]
        self.twitterHandle = representation[TwitterAccount.twitterHandle]
    }
}

class Shapes: ContentData {
    let shapes: Paged<Shape>
    static let shapes = "shape"
    
    required init?(responseData: Any) throws {
        guard let representation = responseData as? [String: Any] else{
            return nil
        }
        
        guard let pagerData = representation["\(Shapes.shapes).\(ContentModelConstant.pagination)"] as? [String: Any] else {
            return nil
        }
        
        let pager = Pager(responseData: pagerData)!
        let pages = representation[Shapes.shapes] as! [[String: Any]]
        var pagesArray = [Shape]()
        
        for page in pages {
            do {
                if let p = try Shape(responseData: page) {
                    pagesArray.append(p)
                }
            } catch {
                throw ContentError.deserializationError(Shapes.shapes)
            }
        }
        
        if !pagesArray.isEmpty {
            self.shapes = Paged<Shape>(elements: pagesArray, pager: pager)
        } else {
            throw ContentError.missingProperty(Shapes.shapes)
        }
        
        try super.init(responseData: representation)
    }
    
}

class Texts: ContentData {
    let texts: Paged<Text>
    static let texts = "lstTexts"
    
    required init?(responseData: Any) throws {
        guard let representation = responseData as? [String: Any] else{
            return nil
        }
        
        guard let pagerData = representation["\(Texts.texts).\(ContentModelConstant.pagination)"] as? [String: Any] else {
            return nil
        }
        
        let pager = Pager(responseData: pagerData)!
        let pages = representation[Texts.texts] as! [[String: Any]]
        var pagesArray = [Text]()
        
        for page in pages {
            do {
                if let p = try Text(responseData: page) {
                    pagesArray.append(p)
                }
            } catch {
                throw ContentError.deserializationError(Texts.texts)
            }
        }
        
        if !pagesArray.isEmpty {
            self.texts = Paged<Text>(elements: pagesArray, pager: pager)
        } else {
            throw ContentError.missingProperty(Texts.texts)
        }
        
        try super.init(responseData: representation)
    }
}

class Websites: ContentData {
    let websites: Paged<Website>
    
    static let websites = "lstWebsite"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Any] else {
            return nil
        }
        
        guard let pagerData = representation["\(Websites.websites).\(ContentModelConstant.pagination)"] as? [String: Any] else {
            return nil
        }
        let pager = Pager(responseData: pagerData)!
        let pages = representation[Websites.websites] as! [[String: Any]]
        var pagesArray = [Website]()
        
        for page in pages {
            do {
                if let p = try Website(responseData: page) {
                    pagesArray.append(p)
                }
            } catch {
                throw ContentError.deserializationError(Websites.websites)
            }
        }
        
        if !pagesArray.isEmpty {
            self.websites = Paged<Website>(elements: pagesArray, pager: pager)
        } else {
            throw ContentError.missingProperty(Websites.websites)
        }
        
        try super.init(responseData: representation)
    }
}

class Shape: ResponseObjectSerializable {
    
    var lat: Double?
    var lng: Double?
    
    static let lat = "lat"
    static let lng = "lng"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Double] else {
            return nil
        }
        
        self.lat = representation[Shape.lat]
        self.lng = representation[Shape.lng]
        
        
        guard let shapeLat = representation[Shape.lat] else {
            throw ContentError.missingProperty(Shape.lat)
        }
        
        self.lat = shapeLat
        
        
        guard let shapeLng = representation[Shape.lng] else {
            throw ContentError.missingProperty(Shape.lng)
        }
        self.lng = shapeLng
        
        
    }
    
}

class Text: ResponseObjectSerializable {
    
    var txtTitle: String?
    var imgText: String?
    var txtText: String?
    
    static let txtTitle = "txtTitle"
    static let imgText = "imgText"
    static let txtText = "txtText"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: String] else {
            return nil
        }
        
        self.txtTitle = representation[Text.txtTitle]
        self.imgText = representation[Text.imgText]
        self.txtText = representation[Text.txtText]
        
        guard let textTitle = representation[Text.txtTitle] else {
            throw ContentError.missingProperty(Text.txtTitle)
        }
        
        self.txtTitle = textTitle
        
        
        guard let imageText = representation[Text.imgText] else {
            throw ContentError.missingProperty(Text.imgText)
        }
        self.imgText = imageText
        
        guard let textText = representation[Text.txtText] else {
            throw ContentError.missingProperty(Text.txtText)
        }
        self.txtText = textText
        
        
    }
    
}

class Website: ResponseObjectSerializable {
    
    let title: String?
    let websiteImageURL: URL?
    let url: URL?
    
    static let title = "txtTitle"
    static let websiteImageURL = "imgWebsite"
    static let url = "txtUrl"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: String] else {
            return nil
        }
        
        self.title = representation[Website.title]
        
        guard let websiteUrlString = representation[Website.websiteImageURL], let websiteImageURL = URL(string: websiteUrlString) else {
            throw ContentError.missingProperty(Website.websiteImageURL)
        }
        self.websiteImageURL = websiteImageURL
        
        guard let urlString = representation[Website.url], let url = URL(string: urlString) else {
            throw ContentError.missingProperty(Website.url)
        }
        self.url = url
    }
}

class TelephoneNumbers: ContentData {
    let numbers: Paged<Telephone>
    
    static let numbers = "lstTelephone"
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Any] else {
            return nil
        }

        guard let pagerData = representation["\(TelephoneNumbers.numbers).\(ContentModelConstant.pagination)"] as? [String: Any] else {
            return nil
        }
        let pager = Pager(responseData: pagerData)!
        let pages = representation[TelephoneNumbers.numbers] as! [[String: String]]
        var pagesArray = [Telephone]()

        for page in pages {
            do {
                if let p = try Telephone(responseData: page) {
                    pagesArray.append(p)
                }
            } catch {
                throw ContentError.deserializationError(TelephoneNumbers.numbers)
            }
        }

        if !pagesArray.isEmpty {
            self.numbers = Paged<Telephone>(elements: pagesArray, pager: pager)
        } else {
            throw ContentError.missingProperty(TelephoneNumbers.numbers)
        }
        
        try super.init(responseData: representation)
    }
}

class Telephone: ResponseObjectSerializable {
    
    let title: String?
    let phone: String?
    let websiteURL: URL?
    
    static let title = "txtTitle"
    static let phone = "txtPhone"
    static let websiteURL = "imgWebsite"
    
    required init?(responseData: Any) throws {

        guard let representation = responseData as? [String: String] else {
            throw ContentError.missingRepresentationDictionary
        }
        
        self.title = representation[Website.title]
        
        guard let phone = representation[Telephone.phone] else {
            throw ContentError.missingProperty(Telephone.phone)
        }
        self.phone = phone
        
        guard let websiteUrlString = representation[Telephone.websiteURL], let websiteURL = URL(string: websiteUrlString) else {
            throw ContentError.missingProperty(Telephone.websiteURL)
        }
        self.websiteURL = websiteURL
    }
}


class Place: ContentData {
    let id: String
    let name: String
  //  var addressDistance: Int
    let coverPhotoURL: URL
    let address: (Double, Double) // lat,lng
    let twitter: Twitter?
    let websites: Websites?
    let telephoneNumbers: TelephoneNumbers?
    let gallery: Gallery?
    let shape: Shapes?
    let youtube: Youtubes?
    let texts: Texts?
    let pointOfInterest: PointOfInterest?

    
    static let id = "_id"
    static let shape = "shape"
    static let youtube = "lstVideos"
    static let texts = "lstTexts"
    static let pointOfInterest = "poi"
 //   static let addressDistance = "___address_distance"
    static let name = "txtName"
    static let coverPhotoURL = "imgCover"
    static let address = "address"
    static let latitude = "lat"
    static let longitude = "lng"
    static let twitterList = "lstTwitter"
    static let websiteList = "lstWebsite"
    static let telephoneNumberList = "lstTelephone"
    static let galleryList = "gallery1"
    
    
    required init?(responseData: Any) throws {
        
        guard let representation = responseData as? [String: Any] else {
            throw ContentError.missingRepresentationDictionary
        }
        
        guard let id = representation[Place.id] as? String else {
            throw ContentError.missingProperty(Place.id)
        }
        self.id = id
        
        
        
        guard let shapeList = representation[Place.shape] as? [[String: Any]] else {
            throw ContentError.missingProperty(Place.shape)
        }
        self.shape = try Shapes(responseData: shapeList)
    
        
        if let youtubeList = representation[Place.youtube] as? [[String: String]] {
            //throw ContentError.missingProperty(Place.galleryList)
            self.youtube = try Youtubes(responseData: youtubeList)
        } else {
            self.youtube = nil
        }
//
//
        guard let textList = representation[Place.texts] as? [[String: String]] else {
            throw ContentError.missingProperty(Place.texts)
        }
        self.texts = try Texts(responseData: textList)
//
//
        if let poiList = representation[Place.pointOfInterest] as? [[String: String]] {
            //throw ContentError.missingProperty(Place.galleryList)
            self.pointOfInterest = try PointOfInterest(responseData: poiList)
        } else {
            self.pointOfInterest = nil
        }
        
        
        guard let name = representation[Place.name] as? String else {
            throw ContentError.missingProperty(Place.name)
        }
        self.name = name
        
        guard let urlString = representation[Place.coverPhotoURL] as? String, let coverPhotoURL = URL(string: urlString) else {
            throw ContentError.missingProperty(Place.coverPhotoURL)
        }
        self.coverPhotoURL = coverPhotoURL
        
        guard let address = representation[Place.address] as? [String: Any], let lat = address[Place.latitude] as? Double, let lng = address[Place.longitude] as? Double else {
            throw ContentError.missingProperty(Place.address)
        }
        self.address = (lat, lng)
        
        guard let twitterList = representation[Place.twitterList] as? [[String: String]] else {
            throw ContentError.missingProperty(Place.twitterList)
        }
        self.twitter = try Twitter(responseData: twitterList)
        
        guard let websiteList = representation[Place.websiteList] as? [[String: String]] else {
            throw ContentError.missingProperty(Place.websiteList)
        }
        self.websites = try Websites(responseData: websiteList)
        
        guard let telephoneNumberList = representation[Place.telephoneNumberList] as? [[String: String]] else {
            throw ContentError.missingProperty(Place.telephoneNumberList)
        }
        self.telephoneNumbers = try TelephoneNumbers(responseData: telephoneNumberList)
        
        if let galleryList = representation[Place.galleryList] as? [[String: String]] {
            //throw ContentError.missingProperty(Place.galleryList)
            self.gallery = try Gallery(responseData: galleryList)
        } else {
            self.gallery = nil
        }
        
        try super.init(responseData: representation)
    }
}

/// Please use this in your one of your own classes (perhaps a view controller)
class ContentModel {
    
    private var Offsetsize = UInt(0)
    private var pageNumber = UInt(0)
    private var latestFetchedPager: Pager = Pager(limit: UInt(25), offset: 0)
    var contentTemplateTypes: [String: ContentData.Type]
    var labels = [String]()
    
    var shopping = ["Services"]
    var items: [Content] = []
    var places: [Place] = []
    
    required init(contentTypes: [String: ContentData.Type]) {
        self.contentTemplateTypes = contentTypes
        latestFetchedPager.goto(0)
    }
    
    func revertToFirstPage() {
        latestFetchedPager = Pager(limit: UInt(25), offset: 0)
    }
    func setOffsetSize(int: UInt)  {
        Offsetsize = int
    }
    
    /**
     Fetching the content for a particular page based on a label or all if `nil`. The completion block
     will be call regardless or with content or empty if error.
     
     - Parameters:
         - completion: The block used to callback the result of fetching the content
         - content: Result contented downloaded assoicated with a notification
     */
    func nextPage(completion: @escaping (_ content: [Place]) -> ()) {
        
        latestFetchedPager.goto(Offsetsize)
        latestFetchedPager = Pager(limit: UInt(25), offset: Offsetsize)
        
        if latestFetchedPager.hasMore() {
            let nextPage = (latestFetchedPager.pageIndex) + 1
            self.latestFetchedPager.goto(nextPage)
            let contentQuery = ContentQuery(types: contentTemplateTypes, pager: latestFetchedPager)
            // Don't create a labelsQuery if labels is empty.
//            if shopping.count > 0 {
//                let labelsPredicate = LabelsPredicate(labels: shopping, booleanOperator: .and)
//                contentQuery.labelsQuery = LabelsQuery(predicates: [labelsPredicate], booleanOperator: .and)
//            }
            
            if labels.count > 0 {
                let labelsPredicate = LabelsPredicate(labels: labels, booleanOperator: .and)
                contentQuery.labelsQuery = LabelsQuery(predicates: [labelsPredicate], booleanOperator: .and)
            }
            
            _ = Content.getAllInstances(with: contentQuery) { (pagedContent, error) in
                
                guard let pagedContent = pagedContent, error == nil else {
                    if Thread.isMainThread {
                        completion([])
                    } else {
                        DispatchQueue.main.sync {
                            completion([])
                        }
                    }
                    return
                }
                let newPagedContent = pagedContent.elements.filter({ (content) -> Bool in
                    if let paged = content.pagedContentData, let total = paged.pager.total, paged.elements.count != total {
                        
                        return false
                    }
                    
                    let place = content.pagedContentData!.elements.first! as! Place

                    self.places.append(place)
                    
                    return true
                })
                
               
                
                
                if Thread.isMainThread {
                    self.latestFetchedPager = pagedContent.pager
                    completion(self.places)
                } else {
                    DispatchQueue.main.sync { [weak self] in
                        self?.latestFetchedPager = pagedContent.pager
                        completion(self!.places)
                    }
                }
            }
        } else {
            completion([])
        }
    }
}
