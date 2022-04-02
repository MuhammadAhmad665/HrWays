//
//  MVP.swift
//  School App
//
//  Created by Ahmed on 24/01/2021.
//

import Foundation
import Alamofire
/**Initilizing Obj C Type Protocol Because i need to use optional Methods in protocol   **/
/**Json is Any type because its not in Onj C**/
protocol serverResponse {
    func onSuccess(json:JSON,val:String)
}

//@available(iOS 13.0, *)
class MVP: BaseViewController {
    
    /**Delegate Object of serverResponse**/
    var delegate:serverResponse!
    
    /**Setting Heder**/
    let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    // MARK: Request with body and header
    func requestWithHeaderandBody(vc:UIViewController , url:String , params:[String:Any] , method:HTTPMethod = .post, type:String = "", loading:Bool = true, refreshing: Bool = false){
        
        /**Registing Loader VC**/
        let loaderVC : LoaderViewController = UIStoryboard.controller()
        
        /**Checking Internet Connectivity**/
        if CheckInternet.Connection(){
            if loading{
                /**Persenting Loader**/
                loaderVC.modalPresentationStyle = .overCurrentContext
                vc.present(loaderVC, animated: false, completion: nil)
            }
            
            /**Alamofire Request**/
            AF.request(Apis.baseURL + url , method: method, parameters: params , encoding: JSONEncoding.default, headers: headers).response { (response) in
                
                
                /**Response From API**/
                switch response.result{
                    
                case .success(let value):
                    
                    let json = JSON(value!)
                    
                    /**On Sucess**/
                    /**Dismissing Loader**/
                    loaderVC.dismiss(animated: false, completion: nil)
                    /**Passing Data in Sucess**/
                    if let del = self.delegate{
                        del.onSuccess(json: json, val: type)
                    }
                    
                    
                    /**On API Request Failer**/
                case .failure(let err):
                    print(err.localizedDescription)
                    loaderVC.dismiss(animated: false, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        vc.showAlertWithOk(withTitle: Alert.String.alert, withMessage: "Service Failure \(err.localizedDescription)")
                    }
                    break
                }
            }
        }else{
            /**Has No Internet Connection**/
            vc.showAlertWithOk(withTitle: Alert.String.alert, withMessage: "No Internet Connection")
            print("No internet connection")
        }
    }
    
    
    //MARK: GET API Calling method Without Params
    func requestGETAPI(vc: UIViewController , url : String, method: HTTPMethod, type: String, loading: Bool) {
        
        let loaderVC : LoaderViewController = UIStoryboard.controller()
        
        
        if CheckInternet.Connection(){
            if loading{
                loaderVC.modalPresentationStyle = .overCurrentContext
                vc.present(loaderVC, animated: false, completion: nil)
            }
            
            AF.request(url, method: method , encoding: JSONEncoding.default, headers: headers).response { (response) in
                
                
                
                switch response.result{
                    
                case .success(let value):
                    let json = JSON(value!)
                    
                        loaderVC.dismiss(animated: false, completion: nil)
                        if let del = self.delegate{
                            del.onSuccess(json: json, val: type)
                        }
                    
                    
                    /**On API Request Failer**/
                case .failure(let err):
                    print(err.localizedDescription)
                    loaderVC.dismiss(animated: false, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        vc.showAlertWithOk(withTitle: Alert.String.alert, withMessage: "Service Failure \(err.localizedDescription)")
                    }

                }
                
            }
        }
        else{
            loaderVC.dismiss(animated: false, completion: nil)
            vc.showAlertWithOk(withTitle: Alert.String.alert, withMessage: "No Internet Connection")
            print("No internet connection")
        }
    }
}
