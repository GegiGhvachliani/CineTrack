import SwiftUI
import WebKit

import SharedCore

struct EmbeddedVideoPlayer: UIViewRepresentable {

    // MARK: - Properties

    let video: MovieVideo
    @Binding
    var isPlaying: Bool
    @Binding
    var playbackError: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(
            isPlaying: $isPlaying,
            playbackError: $playbackError
        )
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.userContentController.add(context.coordinator, name: "playbackState")

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.allowsBackForwardNavigationGestures = false
        context.coordinator.load(video: video, in: webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.update(
            video: video,
            isPlaying: isPlaying,
            in: webView
        )
    }

    static func dismantleUIView(_ webView: WKWebView, coordinator: Coordinator) {
        webView.evaluateJavaScript("if (window.player) { player.pauseVideo(); }")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "playbackState")
    }

    final class Coordinator: NSObject, WKScriptMessageHandler {
        private var isPlaying: Binding<Bool>
        private var playbackError: Binding<String?>
        private let appOrigin = "https://\((Bundle.main.bundleIdentifier ?? "com.gegi.CineTrack").lowercased())"
        private var loadedVideoID: String?
        private var isPlayerReady = false
        private var desiredIsPlaying = false

        init(
            isPlaying: Binding<Bool>,
            playbackError: Binding<String?>
        ) {
            self.isPlaying = isPlaying
            self.playbackError = playbackError
        }

        func load(video: MovieVideo, in webView: WKWebView) {
            loadedVideoID = video.id
            isPlayerReady = false

            guard video.site == .youtube else {
                webView.loadHTMLString(unavailableVideoHTML, baseURL: nil)
                return
            }

            webView.loadHTMLString(
                youtubeHTML(videoKey: video.key),
                baseURL: URL(string: appOrigin)
            )
        }

        func update(
            video: MovieVideo,
            isPlaying: Bool,
            in webView: WKWebView
        ) {
            let hasChanges = desiredIsPlaying != isPlaying
            desiredIsPlaying = isPlaying

            if loadedVideoID != video.id {
                load(video: video, in: webView)
                return
            }

            if hasChanges {
                applyDesiredPlaybackState(in: webView)
            }
        }

        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            guard let state = message.body as? [String: Any] else {
                return
            }

            DispatchQueue.main.async {
                if let code = state["error"] as? NSNumber {
                    self.isPlayerReady = false
                    self.desiredIsPlaying = false
                    self.isPlaying.wrappedValue = false
                    self.playbackError.wrappedValue = VideosListStrings.Format.playbackError(code: code.intValue)
                    return
                }
                if let isReady = state["isReady"] as? NSNumber, isReady.boolValue {
                    self.isPlayerReady = true
                    self.applyDesiredPlaybackState(in: message.webView)
                    return
                }

                if let isPlaying = state["isPlaying"] as? NSNumber {
                    self.desiredIsPlaying = isPlaying.boolValue
                    self.isPlaying.wrappedValue = isPlaying.boolValue
                }
            }
        }

        private func applyDesiredPlaybackState(in webView: WKWebView?) {
            guard isPlayerReady else {
                return
            }

            let playbackAction = desiredIsPlaying ? "playVideo" : "pauseVideo"
            webView?.evaluateJavaScript(
                "if (window.player) { player.\(playbackAction)(); }"
            )
        }

        private func youtubeHTML(videoKey: String) -> String {
            guard let keyData = try? JSONEncoder().encode(videoKey),
                let keyJSON = String(data: keyData, encoding: .utf8)
            else {
                return unavailableVideoHTML
            }
            return """
                <!doctype html>
                <html><head>
                <meta name="referrer" content="strict-origin-when-cross-origin">
                <style>html,body,#player{margin:0;width:100%;height:100%;background:#000;overflow:hidden;}</style>
                </head>
                <body><div id="player"></div>
                <script src="https://www.youtube.com/iframe_api"></script>
                <script>
                var player;
                function onYouTubeIframeAPIReady() {
                  player = new YT.Player('player', {
                    videoId: \(keyJSON),
                    playerVars: { playsinline: 1, controls: 1, rel: 0, enablejsapi: 1, origin: '\(appOrigin)', widget_referrer: '\(appOrigin)' },
                    events: { onReady: onPlayerReady, onStateChange: reportState, onError: onPlayerError }
                  });
                }
                function onPlayerReady() {
                  window.webkit.messageHandlers.playbackState.postMessage({ isReady: 1, currentTime: 0, duration: player.getDuration() || 0, isPlaying: 0 });
                }
                function onPlayerError(event) {
                  window.webkit.messageHandlers.playbackState.postMessage({ error: event.data });
                }
                function reportState(event) {
                  if (event.data === 1 || event.data === 2 || event.data === 0) {
                    window.webkit.messageHandlers.playbackState.postMessage({ currentTime: player.getCurrentTime() || 0, duration: player.getDuration() || 0, isPlaying: event.data === 1 ? 1 : 0 });
                  }
                }
                </script></body></html>
                """
        }

        private var unavailableVideoHTML: String {
            "<html><body style='margin:0;background:#000;color:#fff;display:flex;align-items:center;justify-content:center;font-family:-apple-system' >\(VideosListStrings.Content.videoUnavailable)</body></html>"
        }
    }
}
