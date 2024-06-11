import SwiftUI

struct onboardingView: View {
    @ObservedObject var logic: Logic = LogicAPI

    var body: some View {
        VStack {
            Spacer()
            Text("Welcome")
                .font(Font.custom("Spectral-Medium", size: 40))
                .foregroundColor(Color.white)
                .frame(width: 300, alignment: .leading)

            VStack(alignment: .leading) {
                onboardingDetail(
                    image: "face.smiling",
                    imageColor: .white,
                    title: "● Track Mood",
                    description: "Choose your mood every day. You can choose the appropriate emoticon for each situation and indicate the brightness of the moment."
                )
                onboardingDetail(
                    image: "gearshape",
                    imageColor: .white,
                    title: "● Personalization ",
                    description: "Customize the app to fit your needs. You can change the icon and sync your mood to iCloud."
                )
                onboardingDetail(
                    image: "quote.bubble",
                    imageColor: .white,
                    title: "● New affirmations",
                    description: "Get an unlimited number of affirmations every day for free. Add a widget to your home screen."
                )
            }

            Spacer()

            Button(action: {
                self.logic.objectWillChange.send()
                UserDefaults.standard.set(true, forKey: "onboarding")
                self.logic.welcomeCI()
            }) {
                Text("I'd like to try")
                    .font(.custom("SourceCodePro-Regular", size: 20))
                    .foregroundColor(.black)
                    .frame(width: 350, height: 45)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.top, 50)
                    .padding(.bottom)
            }
        }
    }
}

struct onboardingDetail: View {
    var image: String
    var imageColor: Color
    var title: String
    var description: String

    var body: some View {
        HStack(alignment: .center) {
            HStack(spacing: 20) {
                Image(systemName: image)
                    .font(.system(size: 40))
                    .frame(width: 50, height: 50)
                    .foregroundColor(imageColor)

                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.custom("SourceCodePro-Regular", size: 18))

                    Text(description)
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .lineLimit(5)

                }.frame(width: 250, alignment: .leading)

            }.frame(width: 340, height: 130)
        }
    }
}
