override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                           name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                           name: NSNotification.Name.UIKeyboardWillHide, object: nil)
}

func keyboardWillHide() {
    self.view.frame.origin.y = 0
}

func keyboardWillChange(notification: NSNotification) {

    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if YOURTEXTVIEW.isFirstResponder {
            self.view.frame.origin.y = -keyboardSize.height
        }
    }
}


//Remove observers:

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.UIKeyboardWillHide, object: nil)
}