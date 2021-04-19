//
//  Auth.swift
//  GBShop
//
//  Created by Rayen on 4/15/21.
//

import Alamofire

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility),
        baseUrl: URL
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
    ) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(id: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void
    ) {
        let requestModel = Logout(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func register(id: Int,
                  userName: String,
                  password: String,
                  email: String,
                  gender: String,
                  creditCard: String,
                  bio: String,
                  completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void
    ) {
        let requestModel = UserData(baseUrl: baseUrl,
                                    path: "registerUser.json",
                                    id: id,
                                    userName: userName,
                                    password: password,
                                    email: email,
                                    gender: gender,
                                    creditCard: creditCard,
                                    bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(id: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void
    ) {
        let requestModel = UserData(baseUrl: baseUrl,
                                    path: "changeUserData.json",
                                    id: id,
                                    userName: userName,
                                    password: password,
                                    email: email,
                                    gender: gender,
                                    creditCard: creditCard,
                                    bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    struct UserData: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String
        
        let id: Int
        let userName: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        
        var parameters: Parameters? {
            return [
                "id_user": id,
                "userName": userName,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
    
    struct Logout: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "logout.json"
        
        let id: Int
        
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
}
