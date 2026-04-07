//
//  ViewController.swift
//  texture
//
//  Created by pino on 29.03.26.
//

import UIKit
import MetalKit

final class ViewController: UIViewController {

    private let metalView = MTKView()
    private var renderer: Renderer?
    
    override func loadView() {
        view = metalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        do {
            let context = try MetalContext()
            let renderer = try Renderer(context: context)
            renderer.setupView(metalView)
            self.renderer = renderer
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
