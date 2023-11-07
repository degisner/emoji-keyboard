import SwiftUI

class UIEmojiTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
           return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.text = text
        emojiTextField.textAlignment = .center
        emojiTextField.font = UIFont.systemFont(ofSize: 17)
        emojiTextField.tintColor = UIColor.clear
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let strippedString = string

                // replace current content with stripped content
                if let replaceStart = textField.position(from: textField.beginningOfDocument, offset: range.location),
                    let replaceEnd = textField.position(from: replaceStart, offset: range.length),
                    let textRange = textField.textRange(from: replaceStart, to: replaceEnd) {

                    textField.replace(textRange, withText: strippedString)
                }
                return false
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

