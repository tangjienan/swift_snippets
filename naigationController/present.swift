//. Push the new view controller onto your existing navigation stack

let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("MyViewController") as! ViewController
self.navigationController!.pushViewController(VC1, animated: true)

// Embed your new view controller into a new navigation controller and present the new navigation controller modally

let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("MyViewController") as! ViewController
let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
self.present(navController, animated:true, completion: nil)

// set it up in the VC
let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
self.view.addSubview(navBar);
let navItem = UINavigationItem();
let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector");
navItem.leftBarButtonItem = doneItem;
navBar.setItems([navItem], animated: false);