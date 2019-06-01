//
//  APIClient.swift
//  sampleList
//
//  Created by 石川佑樹 on 2019/06/01.
//  Copyright © 2019 石川佑樹. All rights reserved.
//

import Foundation
import Alamofire

//結果ジェネリクス
enum Result<T> {
    case Success(T)
//    case Other()
    case ParseError(NSError)
    case ConnectionError(NSError)
//    case Unauthenticated()
}



class APIClient<T: Decodable> {
    
    func getApiResponse(url: String, completionHandler: @escaping (Result<T>) -> () = {_ in}) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<423)
            .responseJSON { (response) in
                
                
                let decoder: JSONDecoder = JSONDecoder()
                
                switch response.result {
                case .success:
                    
                    do {
                        let statusCode = response.response?.statusCode
                        if statusCode == 200 {
                            
                            //JSONパース
                            let retJson = try decoder.decode(T.self, from: response.data!)
                            print("通信成功")
                            completionHandler(Result<T>.Success(retJson))
                        } else if statusCode == 422 {
                            
                            print("通信成功(その他)")
//                            completionHandler(Result.Other())
                        } else if statusCode == 401 {
                            
//                            completionHandler(Result<T>.Unauthenticated())
                        } else {
                            
                            print("その他は失敗扱い")
                            completionHandler(Result.ConnectionError(self.createError()))
                        }
                        
                    } catch {
                        
                        print("パースエラー")
                        completionHandler(Result<T>.ParseError(self.createError()))
                    }
                case .failure(let error):
                    print("通信失敗エラーハンドリングは？")
                    //アラートを表示してタップで終了でいいのでは？
                    
                    print("----------------------")
                    
                    completionHandler(Result<T>.ConnectionError(error as NSError))
                    
                }
        }
    }
    
    /// エラーを生成
    ///
    /// - Returns: NSError
    func createError() -> NSError {
        return NSError(domain: "エラーが発生しました", code: -1, userInfo: nil)
    }
}
