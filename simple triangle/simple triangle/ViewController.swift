//
//  ViewController.swift
//  simple triangle
//
//  Created by pino on 05.02.26.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

    private var mtkView: MTKView!
    private var renderer: Renderer!
    
    override func loadView() {
        mtkView = MTKView()
        view = mtkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        renderer = Renderer()
        renderer.setupView(mtkView)
    }

}


