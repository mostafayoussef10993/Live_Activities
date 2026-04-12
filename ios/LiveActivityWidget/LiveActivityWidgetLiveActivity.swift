import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState

    public struct ContentState: Codable, Hashable {}

    var id = UUID()
}

extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}

struct FootballLiveActivityView: View {
    let context: ActivityViewContext<LiveActivitiesAppAttributes>

    // Read data from shared UserDefaults
    let sharedDefault = UserDefaults(suiteName: "group.com.youssef.liveactivities.4JV5D2RFJA")!

    var teamAName: String { sharedDefault.string(forKey: context.attributes.prefixedKey("teamAName")) ?? "Team A" }
    var teamBName: String { sharedDefault.string(forKey: context.attributes.prefixedKey("teamBName")) ?? "Team B" }
    var teamAScore: Int { sharedDefault.integer(forKey: context.attributes.prefixedKey("teamAScore")) }
    var teamBScore: Int { sharedDefault.integer(forKey: context.attributes.prefixedKey("teamBScore")) }
    var teamAImageUrl: String? { sharedDefault.string(forKey: context.attributes.prefixedKey("teamAImageUrl")) }
    var teamBImageUrl: String? { sharedDefault.string(forKey: context.attributes.prefixedKey("teamBImageUrl")) }

    var body: some View {
            let _ = print("🏝️ Widget rendering - teamA: \(teamAName), score: \(teamAScore):\(teamBScore)")
    let _ = print("🏝️ AppGroup readable: \(sharedDefault.dictionaryRepresentation().keys.prefix(5))")
        HStack {
            // Team A
            VStack(spacing: 4) {
                AsyncImage(url: URL(string: teamAImageUrl ?? "")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 48, height: 48)
                .clipShape(Circle())

                Text(teamAName)
                    .font(.caption)
                    .foregroundColor(.white)
            }

            Spacer()

            // Score
            VStack(spacing: 2) {
                Text("\(teamAScore) : \(teamBScore)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }

            Spacer()

            // Team B
            VStack(spacing: 4) {
                AsyncImage(url: URL(string: teamBImageUrl ?? "")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 48, height: 48)
                .clipShape(Circle())

                Text(teamBName)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.black)
    }
}

struct FootballLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            FootballLiveActivityView(context: context)
        } dynamicIsland: { context in
            let shared = UserDefaults(suiteName: "group.com.youssef.liveactivities.4JV5D2RFJA")!
            let teamA = shared.string(forKey: context.attributes.prefixedKey("teamAName")) ?? "PSG"
            let teamB = shared.string(forKey: context.attributes.prefixedKey("teamBName")) ?? "CHE"
            let scoreA = shared.integer(forKey: context.attributes.prefixedKey("teamAScore"))
            let scoreB = shared.integer(forKey: context.attributes.prefixedKey("teamBScore"))
            let teamAUrl = shared.string(forKey: context.attributes.prefixedKey("teamAImageUrl"))
            let teamBUrl = shared.string(forKey: context.attributes.prefixedKey("teamBImageUrl"))

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack(spacing: 2) {
                        AsyncImage(url: URL(string: teamAUrl ?? "")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        Text(teamA)
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(spacing: 2) {
                        AsyncImage(url: URL(string: teamBUrl ?? "")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        Text(teamB)
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(scoreA)  :  \(scoreB)")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("⚽ Live Match")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                }
            } compactLeading: {
                AsyncImage(url: URL(string: teamAUrl ?? "")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Text(String(teamA.prefix(1)))
                        .foregroundColor(.white)
                        .font(.caption2)
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            } compactTrailing: {
                AsyncImage(url: URL(string: teamBUrl ?? "")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Text(String(teamB.prefix(1)))
                        .foregroundColor(.white)
                        .font(.caption2)
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            } minimal: {
                Text("⚽")
                    .font(.caption)
            }
        }
    }
}