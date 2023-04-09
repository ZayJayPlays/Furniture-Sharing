
import UIKit

class FurnitureDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            photoImageView.image = image
        } else {
            photoImageView.image = nil
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default, handler: { (_) in imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true)
            })
            alertController.addAction(choosePhotoAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let takePhotoAction = UIAlertAction(title: "Take a Photo", style: .default, handler: { (_) in imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true)
            })
            alertController.addAction(takePhotoAction)
        }

        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        
        if let image = photoImageView.image, let text = furnitureDescriptionLabel.text {
            let activityView = UIActivityViewController(activityItems: [image, text], applicationActivities: [])
            present(activityView, animated: true)
        }
        
        // Initialize UIAtivityViewController
        // Present itu
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]! as! UIImage
        furniture!.imageData = image.jpegData(compressionQuality: 0.9)
        dismiss(animated: true)
        updateView()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
