//
//  CountryCodeListView.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 18/07/23.
//

import SwiftUI

import SwiftUI

struct CountryCodeListView: View {
    @Binding var selectedCountryCode: String
    @Binding var showCountryCodeList: Bool
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            TextField("Search Country", text: self.$searchText)
            List(NSLocale.isoCountryCodes, id: \.self) { countryCode in
                
                
                
                if (Locale.current.localizedString(forRegionCode: countryCode) ?? "").localizedCaseInsensitiveContains(searchText)
                    || searchText.isEmpty ||
                    countryCode.localizedCaseInsensitiveContains(searchText) {
                    Button {
                        self.selectedCountryCode = countryCode
                        self.showCountryCodeList = false
                    } label: {
                        HStack {
                            Text(self.getFlag(forCountryCode: countryCode))
                            Text(Locale.current.localizedString(forRegionCode: countryCode) ?? "")
                            Spacer()
                            Text(countryCode)
                        }
                    }
                }
            }
        }
    }
    
    func isAvailableCountryCode(_ countryCode: String) -> Bool {
        return (Locale.current.localizedString(forRegionCode: countryCode) ?? "").localizedCaseInsensitiveContains(searchText)
        || searchText.isEmpty ||
        countryCode.localizedCaseInsensitiveContains(searchText)
    }
    
    func getFlag(forCountryCode code: String) -> String {
        return String(String.UnicodeScalarView(code.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
          }))
    }
}



struct CountryCodeListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCodeListView(selectedCountryCode: .constant("IN"), showCountryCodeList: .constant(true))
    }
}
