//
//  BottleViewController.swift
//  Recycle
//
//  Created by Jeffery Ho on 2/9/20.
//  Copyright © 2020 SLOWip. All rights reserved.
//

import UIKit

class BottleViewController: UIViewController {

       var takenPhoto:UIImage?
        @IBOutlet weak var imageView: UIImageView!
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Rectangle 18


            var view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 375, height: 20)

            view.backgroundColor = .white



            var parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false




            // Rectangle 18


            view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 377, height: 282)

            view.backgroundColor = .white


            let layer0 = CAGradientLayer()

            layer0.colors = [

              UIColor(red: 0.975, green: 0.236, blue: 0.236, alpha: 1).cgColor,

              UIColor(red: 1, green: 0.747, blue: 0.367, alpha: 1).cgColor

            ]

            layer0.locations = [0, 1]

            layer0.startPoint = CGPoint(x: 0.25, y: 0.5)

            layer0.endPoint = CGPoint(x: 0.75, y: 0.5)

            layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.5, b: -0.76, c: 0.76, d: 2.67, tx: -0.59, ty: -0.58))

            layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)

            layer0.position = view.center

            view.layer.addSublayer(layer0)



            parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false

            view.widthAnchor.constraint(equalToConstant: 377).isActive = true

            view.heightAnchor.constraint(equalToConstant: 282).isActive = true

            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: -2).isActive = true

            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0).isActive = true




            /* status bars/≤ iPhone8/status bar/light

            Status Bar — Light
            ≤ iPhone 8
            */

            view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 375, height: 20)

            view.backgroundColor = .white



            parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false




            // We found GLASS


            view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 380, height: 170)

            view.backgroundColor = .clear


            view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

            view.font = UIFont(name: "Helvetica Neue", size: 40)


            // Line height: 40 pt


            view.textAlignment = .center

            view.text = "We found BOTTLE"


            parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false

            view.widthAnchor.constraint(equalToConstant: 385).isActive = true

            view.heightAnchor.constraint(equalToConstant: 170).isActive = true

            //view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 49).isActive = true

            //view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 90).isActive = true

            // Rectangle 1


            view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 375, height: 629)

            view.backgroundColor = .clear


            view.layer.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor


            parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false

            view.widthAnchor.constraint(equalToConstant: 375).isActive = true

            view.heightAnchor.constraint(equalToConstant: 629).isActive = true

            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true

            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 183).isActive = true



            var shapes = UIView()

            shapes.frame = view.frame

            shapes.clipsToBounds = true

            view.addSubview(shapes)


            let layer1 = CALayer()

            layer1.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1).cgColor

            layer1.bounds = shapes.bounds

            layer1.position = shapes.center

            shapes.layer.addSublayer(layer1)



            parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false

            view.widthAnchor.constraint(equalToConstant: 375).isActive = true

            view.heightAnchor.constraint(equalToConstant: 629).isActive = true

            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true

            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 183).isActive = true

            // Frame

            //imageView.image = UIImage(named: "recycle")

            let imageName = "recycle"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: -10, y: -100, width: 270, height: 208.25)
            
        
            view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 236.86, height: 208.25)

            view.backgroundColor = .clear


            parent = self.view!

            parent.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false

            view.widthAnchor.constraint(equalToConstant: 236.86).isActive = true

            view.heightAnchor.constraint(equalToConstant: 208.25).isActive = true

            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 69).isActive = true

            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 360).isActive = true

            view.addSubview(imageView)


            // Recycle It!


            view = UILabel()

            view.frame = CGRect(x: 50, y: 0, width: 158, height: 86)

            view.backgroundColor = .clear


            view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

            view.font = UIFont(name: "Helvetica Neue", size: 30)


            // Line height: 40 pt


            view.text = "Recycle It!"
            view.textAlignment = .center


            parent = self.view!

            parent.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false

            view.widthAnchor.constraint(equalToConstant: 158).isActive = true

            view.heightAnchor.constraint(equalToConstant: 86).isActive = true

            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 104).isActive = true

            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 532).isActive = true


           /*
           // not plastic


           view = UILabel()

           view.frame = CGRect(x: 0, y: 0, width: 75, height: 19)

           view.backgroundColor = .clear


           view.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)

           view.font = UIFont(name: "Helvetica Neue", size: 14)


           // Line height: 19 pt

           // (identical to box height)


           view.text = "not plastic"


           parent = self.view!

           parent.addSubview(view)

           view.translatesAutoresizingMaskIntoConstraints = false

           view.widthAnchor.constraint(equalToConstant: 75).isActive = true

           view.heightAnchor.constraint(equalToConstant: 19).isActive = true

           view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 153).isActive = true

           view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 638).isActive = true
    */
       }
       
       @IBAction func goBack(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
       
       
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }

}
