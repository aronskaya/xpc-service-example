/*
 * MIT License
 *
 * Copyright (c) 2019 aronskaya (Julia Vashchenko)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet private weak var window: NSWindow!
    @IBOutlet private weak var replyLabel: NSTextField!
    
    private let appController = AppController()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        appController.start()
    }

    @IBAction private func getAnswerButtonPressed(_ sender: Any) {
        self.window.shake()
        appController.getDecision { (decision) in
            // reply blocks are called on arbitrary thread, so we need to
            // reroute the call to main thread in order to update UI
            DispatchQueue.main.async {
                self.replyLabel.stringValue = decision
            }
        }
    }
}

