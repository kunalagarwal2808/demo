//
//  ProductsMenuViewController.swift
//  TitanSpineiPhone
//
//  Created by Bifortis on 2/26/16.
//  Copyright © 2016 ideaplunge. All rights reserved.
//

import UIKit

class ProductsMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // kunal is here
    var productsNameArray :NSMutableArray = []
    var productsImageArray : NSMutableArray = []
    var productsDescriptionArray : NSMutableArray = []
    

    @IBOutlet weak var productsMenuCollectionView: UICollectionView!
    
    @IBOutlet weak var contactTabButton: UIButton!
    @IBOutlet weak var productsTabButton: UIButton!
    
    @IBOutlet weak var salesTabButton: UIButton!
    @IBOutlet weak var surfaceTechnologyTabButton: UIButton!

    @IBOutlet weak var productsBarUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsMenuCollectionView.dataSource = self
        productsMenuCollectionView.delegate = self
        
        let urlString : String = "http://125.99.248.6:3005/api/products/"
        
        let url = NSURL(string: urlString)
        do
        {
        let data = try NSData(contentsOfURL: url!, options: [])
            do{
                
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data,  options: NSJSONReadingOptions()) as? NSArray
            
        
        for result in jsonData! {
            let productName = result["name"] as! NSString
            let imageArray = result["image"] as! NSMutableArray
            let imageName = imageArray[0] as! NSString
            let imageURL = NSURL(string: ("http://125.99.248.6:3005/" + (imageName as String)))
            let imageData = NSData(contentsOfURL: imageURL!)
            let productsImage : UIImage = (UIImage(data: imageData!))!
            let description = result["description"] as! NSString
            productsNameArray.addObject(productName)
            productsImageArray.addObject(productsImage)
            productsDescriptionArray.addObject(description)
                }
            } catch{
                
               print("JSON is not returning data")
            }
        } catch{
            
//            let alert = UIAlertController(title: "WARNING!", message: "No Internet Connectivity", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
//            
//            self.presentViewController(alert, animated: true, completion: nil)

        }
            
        
        self.productsTabButton.setTitleColor(UIColor(red: 213.0/255, green: 178.0/255, blue: 123.0/255, alpha: 1.0)
, forState: UIControlState.Normal)
      self.surfaceTechnologyTabButton.setTitleColor(UIColor(red: 213.0/255, green: 178.0/255, blue: 123.0/255, alpha: 1.0)
            , forState: UIControlState.Normal)
        self.salesTabButton.setTitleColor(UIColor(red: 213.0/255, green: 178.0/255, blue: 123.0/255, alpha: 1.0)
            , forState: UIControlState.Normal)
        self.contactTabButton.setTitleColor(UIColor(red: 213.0/255, green: 178.0/255, blue: 123.0/255, alpha: 1.0)
            , forState: UIControlState.Normal)
        self.productsBarUIView.backgroundColor = UIColor(red: 213.0/255, green: 178.0/255, blue: 123.0/255, alpha: 1.0)
        
        self.productsTabButton.titleLabel!.font = UIFont(name: "Lato-Bold", size: 12)
        self.surfaceTechnologyTabButton.titleLabel!.font = UIFont(name: "Lato-Bold", size: 12)
        self.salesTabButton.titleLabel!.font = UIFont(name: "Lato-Bold", size: 12)
        self.contactTabButton.titleLabel!.font = UIFont(name: "Lato-Bold", size: 12)

        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productsNameArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell   {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath) as! ProductsMenuCollectionViewCell
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 213.0/255, green: 178.0/255, blue: 123.0/255, alpha: 1.0).CGColor
        cell.productsMenuTitleLabel.text = productsNameArray[indexPath.row] as? String
        cell.productsMenuIconImage.image = productsImageArray[indexPath.row] as? UIImage
        cell.productsMenuTitleLabel.font = UIFont(name: "Lato-Bold", size:20 )
        cell.productsMenuTitleLabel.textColor = UIColor(red: 102.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1.0)
        
        return cell
    }
    
    
    
    @IBAction func onContactClick(sender: UIButton) {
      let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("ContactViewController")
        self.presentViewController(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func onSalesClick(sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("SalesViewController")
        self.presentViewController(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func onSurfaceTechnologyClick(sender: UIButton) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("SurfaceTechnologyViewController")
        self.presentViewController(vc, animated: false, completion: nil)
    }
    
    @IBAction func onProductsClick(sender: UIButton) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("ProductsMenuViewController")
        self.presentViewController(vc, animated: false, completion: nil)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("productsHomeSegue", sender: self)
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "productsHomeSegue")
        {
            if let cell = sender as? ProductsMenuCollectionViewCell
            {
            let indexPath = productsMenuCollectionView.indexPathForCell(cell)
            let detailVC = segue.destinationViewController as! ProductsHomeViewController
            detailVC.imageDescription = self.productsDescriptionArray[indexPath!.row] as! NSString
            detailVC.productName = self.productsNameArray[indexPath!.row] as! NSString
            detailVC.productPic = (self.productsImageArray[indexPath!.row] as? UIImage)
            detailVC.productsImagePicArray = self.productsImageArray
            detailVC.productsNameArray = self.productsNameArray
        
            
            }
            else
            {
            print("kunal")
            }
        }

    }
    
    
    }
