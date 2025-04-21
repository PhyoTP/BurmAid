import SwiftUI

struct MyanmarView: View{
    var body: some View{
        NavigationStack{
            List{
                Text("Here are some more facts about Myanmar:")
                Section("General"){
                    HStack{
                        Spacer()
                        PhotoView(image: "detailed map", caption: "A more detailed map of the states of Myanmar")
                        Spacer()
                    }
                    Text("Myanmar was formerly named Burma")
                    Text("The people of Myanmar are called Burmese")
                    Text("The main religion of Myanmar is Theravada Buddhism")
                    Text("The capital of Myanmar is Naypyidaw, but was formerly Yangon")
                }
                Section("Culture"){
                    HStack{
                        Spacer()
                        PhotoView(image: "Thingyan", caption: "Me at the Thingyan festivities in 2019 at Woodlands Waterfront Park, Singapore")
                        Spacer()
                    }
                    Text("The Burmese New Year, more commonly known as Thingyan (သင်္ကြန် `thinchyan`), is celebrated in April annually. It is a water festival where people pour water onto other people to wash away the bad luck and is also very refreshing during the hot season.")
                }
                Section("Geography"){
                 //   TabView{
                        
                  //      PhotoView(image: "zwegabin", caption: "Me at Mount Zwegabin, a mountain in Kayin State")
                    HStack{
                        Spacer()
                        PhotoView(image: "Painite", caption: "Painite, regarded to be the rarest gem in the world",copyright: "By Rob Lavinsky, iRocks.com – CC-BY-SA-3.0, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=10168302")
                        Spacer()
                    }
                   // }
                 //   .tabViewStyle(.page)
                  //  .frame(height: 200)
                    Text("Myanmar has many high mountains, gem caves, beautiful beaches and breathtaking scenery.")
                    Text("The tallest mountain in Myanmar is Hkakabo Razi, located in the Kachin State.")
                    Text("Myanmar is the home of many jewels and gems, such as jade, ruby, and the world's rarest gem, painite.")
                }
            }
            .navigationTitle("Myanmar")
        }
    }
}
#Preview{
    MyanmarView()
}
struct PhotoView: View{
    var image: String
    var caption: String
    var copyright: String?
    var body: some View{
        VStack(alignment: .center){
            Image(image)
                .resizable()
                .scaledToFit()
            Text(caption)
                .font(.caption)
            if let copy = copyright{
                Text(copy)
                    .font(.caption2)
            }
        }
        .frame(height: 200)
    }
}
