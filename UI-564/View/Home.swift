//
//  Home.swift
//  UI-564
//
//  Created by nyannyan0328 on 2022/05/17.
//

import SwiftUI

struct Home: View {
    @StateObject var model : TakViewModel = .init()
    @Namespace var animation
    @Environment(\.self) var env
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var results : FetchedResults<Task>
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:20){
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    
                    Text("Welcom Back")
                        .font(.title3.weight(.bold))
                    
                    Text("Her's Update Today")
                        .font(.largeTitle.weight(.bold))
                }
                  .frame(maxWidth: .infinity,alignment: .leading)
          
                CustomSegmentBar()
                    .padding(.top,3)
                
                
                TaskView()
                
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            
            Button {
                
                model.openEditTask.toggle()
                
            } label: {
                
                Label {
                    Text("Add Task")
                } icon: {
                    Image(systemName: "plus.rectangle.fill")
                    
                }
                

            }
            .foregroundColor(.white)
            .padding(.vertical,13)
            .padding(.horizontal,20)
            .background{
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    
            }
            .padding()
            .frame(maxWidth: .infinity,alignment: .center)
            .background{
                
                
                LinearGradient(colors: [
                
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                    .white
                
                
                ], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            }

        }
        .sheet(isPresented: $model.openEditTask) {
            
        } content: {
            
            AddNewTaskView()
                .environmentObject(model)
            
        }

    }
    
    @ViewBuilder
    func TaskView()->some View{
        LazyVStack(spacing:15){
            
            
            DynamicFileterdView(currentTab: model.currentTab) { (task : Task) in
                taskRowView(task: task)
            }
            
            
        }
        
        
    }
    @ViewBuilder
    func taskRowView(task : Task)->some View{
        
        
        
        VStack(alignment: .leading, spacing: 15) {
            
            
            HStack{
                
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background{
                        
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                
                Spacer()
                
                
                if !task.isCompleted && model.currentTab != "Failed"{
                    
                    
                    Button {
                        
                        model.editTask = task
                        model.openEditTask = true
                        model.setUpTask()
                        
                    } label: {
                        
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.black)
                    }

                }
                
                
                
            }
            
            Text(task.title ?? "")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(.black)
                .padding(.vertical,10)
            
            
            
            HStack(alignment: .bottom, spacing: 15) {
                
                VStack(alignment: .leading, spacing: 13) {
                    
                    Label {
                        
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        
                        
                        Image(systemName: "calendar")
                        
                    }
                    .font(.caption)
                    
                    
                    Label {
                        
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                        
                    } icon: {
                        Image(systemName: "clock")
                    }


                }
                  .frame(maxWidth: .infinity,alignment: .leading)
                
                
                if !task.isCompleted && model.currentTab != "Failed"{
                    
                    
                    Button {
                        
                        task.isCompleted.toggle()
                         try?  env.managedObjectContext.save()
                        
                    } label: {
                        
                        
                        Circle()
                            .strokeBorder(.black,lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                        
                    }

                    
                    
                }
            }
            
            
            
            
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .center)
        .background{
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(task.color ?? "Yellow"))
            
        }
        
        
    }
    @ViewBuilder
    func CustomSegmentBar()->some View{
        
        let tabs = ["Today","UpComing","Taks Done","Failed"]
        
        HStack(spacing:15){
            
            ForEach(tabs,id:\.self){tab in
                
                Text(tab)
                    .font(.caption)
                    .foregroundColor(model.currentTab == tab ? .white : .black)
                    .padding(.vertical,13)
                    .padding(.horizontal,20)
                    .background{
                        
                        
                        if model.currentTab == tab{
                            
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                        
                        
                        
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            model.currentTab = tab
                        }
                    }
                
            }
            
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
