//
//  DateView.swift
//  Laugh Cry Think App
//
//  Created by Leticia Rios on 2/5/24.
//

import SwiftUI

struct DateView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        
        DateView()
            .environmentObject(dateHolder)
            .padding()
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
    }
}
