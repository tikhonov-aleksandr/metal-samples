//
//  ViewController.swift
//  texture
//
//  Created by pino on 29.03.26.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

    private var metalView: MTKView!
    private var renderer: Renderer!
    
    override func loadView() {
        metalView = MTKView()
        view = metalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        renderer = Renderer()
        renderer.setupView(metalView)
    }


}

