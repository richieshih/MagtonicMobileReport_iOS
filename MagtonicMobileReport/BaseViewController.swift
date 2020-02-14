//
//  BaseViewController.swift
//  MagtonicMobileReport
//
//  Created by richie shih on 2019/6/24.
//  Copyright © 2019 richie shih. All rights reserved.
//

import UIKit
import NavigationDrawer
import WebKit

class BaseViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var titleBar: UINavigationBar!
    @IBOutlet weak var itemTitle: UINavigationItem!
    @IBOutlet weak var webKitView: WKWebView!
    
    var funArray = [HeaderURL]()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    let interactor = Interactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        funArray.removeAll()
        
        let fun1: HeaderURL = HeaderURL.init(header: "Youtube", urlString: "https://www.youtube.com")
        let fun2: HeaderURL = HeaderURL.init(header: "Facebook", urlString: "https://zh-tw.facebook.com")
        let fun3: HeaderURL = HeaderURL.init(header: "Twitter", urlString: "https://twitter.com")
        let fun4: HeaderURL = HeaderURL.init(header: "Google", urlString: "https://www.google.com")
        
        funArray.append(fun1)
        funArray.append(fun2)
        funArray.append(fun3)
        funArray.append(fun4)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        
        let select = defaults.integer(forKey: "MenuIndex")
        
        let urlStr = funArray[select].getUrlString()
        
        itemTitle.title = funArray[select].getHeader()
        
        if let url = URL(string: urlStr) {
            
            let request = URLRequest(url: url)
            webKitView.load(request)
        }
        
        /*
         mage.topAnchor.constraint(equalTo:
         view.safeAreaLayoutGuide.topAnchor).isActive = true
         */
        
        //titleBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        print("BaseViewController -> viewDidAppear")
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //NotificationCenter.default.removeObserver(self)
        
        super.viewDidDisappear(animated)
        
        print("BaseViewController -> viewDidDisappear")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "showSlidingMenu", sender: nil)
        
        
    }
    
    @IBAction func barItemKeyboardPressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        _ = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SlidingViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = self.interactor
        }
    }
}
