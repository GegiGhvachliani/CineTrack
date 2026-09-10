//
//  SearchRangeSlider.swift
//  Search
//

import SwiftUI

import DesignSystemTokens

struct SearchRangeSlider: View {

    // MARK: - Properties

    let bounds: ClosedRange<Int>
    let step: Int
    let lowerTitle: (Int) -> String
    let upperTitle: (Int) -> String

    @Binding
    var lowerValue: Int
    @Binding
    var upperValue: Int

    @State
    private var activeThumb: Thumb?

    // MARK: - Body

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                valueLabel(title: SearchStrings.Content.from, value: lowerTitle(lowerValue))
                Spacer()
                valueLabel(title: SearchStrings.Content.upperBound, value: upperTitle(upperValue))
            }

            GeometryReader { proxy in
                let width = max(proxy.size.width - Self.thumbDiameter, 1)

                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(ColorTokens.Background.primary)
                        .frame(height: 5)

                    Capsule()
                        .fill(ColorTokens.Brand.primary)
                        .frame(
                            width: upperThumbPosition(width: width) - lowerThumbPosition(width: width),
                            height: 5
                        )
                        .offset(x: lowerThumbPosition(width: width))

                    thumb
                        .offset(x: lowerThumbPosition(width: width))

                    thumb
                        .offset(x: upperThumbPosition(width: width))
                }
                .frame(height: Self.thumbDiameter)
                .gesture(rangeDragGesture(width: width))
            }
            .frame(height: Self.thumbDiameter)
            .padding(.horizontal, Self.thumbDiameter / 2)
        }
    }

    // MARK: - UI components

    private var thumb: some View {
        Circle()
            .fill(ColorTokens.Brand.primary)
            .frame(width: Self.thumbDiameter, height: Self.thumbDiameter)
            .shadow(color: .black.opacity(0.25), radius: 2, y: 1)
    }

    private func valueLabel(title: String, value: String) -> some View {
        Text(SearchStrings.Format.rangeValue(title: title, value: value))
            .font(.system(size: 13, weight: .semibold, design: .rounded))
            .foregroundStyle(ColorTokens.Text.main)
    }

    // MARK: - Slider calculations

    private func lowerThumbPosition(width: CGFloat) -> CGFloat {
        position(for: lowerValue, width: width)
    }

    private func upperThumbPosition(width: CGFloat) -> CGFloat {
        position(for: upperValue, width: width)
    }

    private func position(for value: Int, width: CGFloat) -> CGFloat {
        let progress = CGFloat(value - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound)
        return progress * width
    }

    private func rangeDragGesture(width: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                if activeThumb == nil {
                    let lowerDistance = abs(value.startLocation.x - lowerThumbPosition(width: width))
                    let upperDistance = abs(value.startLocation.x - upperThumbPosition(width: width))
                    activeThumb = lowerDistance <= upperDistance ? .lower : .upper
                }

                let selectedValue = valueAt(location: value.location.x, width: width)

                switch activeThumb {
                case .lower:
                    lowerValue = min(selectedValue, upperValue)
                case .upper:
                    upperValue = max(selectedValue, lowerValue)
                case nil:
                    break
                }
            }
            .onEnded { _ in
                activeThumb = nil
            }
    }

    private func valueAt(location: CGFloat, width: CGFloat) -> Int {
        let progress = min(max(location / width, 0), 1)
        let rawValue = CGFloat(bounds.lowerBound) + progress * CGFloat(bounds.upperBound - bounds.lowerBound)
        let roundedValue = Int((rawValue / CGFloat(step)).rounded()) * step

        return min(max(roundedValue, bounds.lowerBound), bounds.upperBound)
    }

    private static let thumbDiameter: CGFloat = 22

    private enum Thumb {
        case lower
        case upper
    }
}

#Preview {
    SearchRangeSlider(
        bounds: 1900...2026,
        step: 1,
        lowerTitle: String.init,
        upperTitle: String.init,
        lowerValue: .constant(1980),
        upperValue: .constant(2020)
    )
    .padding()
    .background(Color.black)
}
