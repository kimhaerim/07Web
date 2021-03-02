//
//  ViewController.swift
//  07Web
//
//  Created by 김해림 on 2021/03/02.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    //웹 뷰가 로딩중인지 살펴보기 델리게이트 선언
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        //url값을 받아 URL형으로 선언
        let myRequest = URLRequest(url: myUrl!)
        //myUrl을 받아 URLRequest형으로 선언
        myWebView.load(myRequest)
        //UIWebView형의 myWebView 클래스의 load메서드를 호출
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self
        loadWebPage("http://naver.com") //웹 실행시 초기 홈페이지
    }
    
    //로딩 중인지 확인하기 위한 함수 추가
    //로딩 중일 때 인디케이터 실행하고 보이게 함
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    //로딩이 완료되었을 때 동작
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    //로딩 실패 시 동작
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        //입력 받은 url을 임시 변수에 넣음
        let flag = strUrl.hasPrefix("http://")
        //"http://"를 가지고 있는지 확인한 값을 flag에 넣음
        if !flag {
            strUrl = "http://" + strUrl
            //"http://"가 없으면 추가함
        }
        return strUrl
    }
    
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    
    @IBAction func btnGosite2(_ sender: UIButton) {
        loadWebPage("http://blog.2sam.net")
    }
    
    //HTML 문법에 맞게 작성된 문자열 변수를 웹 뷰로 나타냄
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> Stirng 변수를 이용한 웹 페이지 </p><p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        //HTML문을 변수에 저장
        myWebView.loadHTMLString(htmlString, baseURL: nil)
        //loadHTMLString 함수를 이용하여 변수에 저장된 HTML문을 웹 뷰에 나타냄
    }
    
    @IBAction  func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading() //웹 페이지의 로딩을 중지시키는 함수
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload() //웹 페이지를 재로딩시키는 함수
    }
 
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack() //이전 웹 페이지로 이동시키는 함수
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward() //다음 웹 페이지로 이동시키는 함수
    }
    
}

