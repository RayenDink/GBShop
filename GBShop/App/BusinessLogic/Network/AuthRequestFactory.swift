//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Rayen on 4/15/21.
//

import Alamofire

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)

    func logout(id: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)

    func register(id: Int,
                  userName: String,
                  password: String,
                  email: String,
                  gender: String,
                  creditCard: String,
                  bio: String,
                  completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void)

    func changeUserData(id: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}


