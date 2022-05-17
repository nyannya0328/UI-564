//
//  AddNewTaskView.swift
//  UI-564
//
//  Created by nyannyan0328 on 2022/05/17.
//

import SwiftUI

struct AddNewTaskView: View {
    @EnvironmentObject var model : TakViewModel
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        VStack(spacing:15){
            
                Text("Edtit Task")
                .font(.largeTitle.weight(.heavy))
                .frame(maxWidth: .infinity,alignment: .center)
                .overlay(alignment: .leading) {
                    
                    
                    Button {
                        env.dismiss()
                    } label: {
                        
                        Image(systemName: "arrow.left")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                    }

                }
                .overlay(alignment: .trailing) {
                    
                    Button {
                        
                        if let editeTask = model.editTask{
                            
                            env.managedObjectContext.delete(editeTask)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                        
                    } label: {
                        
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .opacity(model.editTask == nil ? 0 : 1)

                    
                }
            
            
            
            VStack(alignment: .leading, spacing: 14) {
                
                
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let colors : [String] = ["Yellow","Green","Blue","Purple","Red","Orange"]
                
                
                HStack(spacing:15){
                    
                    
                    ForEach(colors,id:\.self){color in
                        
                        
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
                            .background{
                                
                                if model.taskColor == color{
                                    
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-5)
                                    
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                
                                model.taskColor = color
                            }
                        
                    }
                }
                
                Divider()
                    .padding(.vertical,15)
                
                
            }
              .frame(maxWidth: .infinity,alignment: .leading)
            
            
            VStack(alignment: .leading, spacing: 14) {
                
                
                Text("Task Dead Line")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                     Text(model.taskDedline.formatted(date: .abbreviated, time: .omitted) + ", " + model.taskDedline.formatted(date: .omitted, time: .standard))
                        .font(.caption.weight(.black))
                
            }
              .frame(maxWidth: .infinity,alignment: .leading)
              .overlay(alignment: .bottomTrailing) {
                  
                  Button {
                      model.showDatePicker.toggle()
                  } label: {
                      Image(systemName: "calendar")
                          .font(.title3.weight(.bold))
                          .foregroundColor(.black)
                  }

              }
            
            
            Divider()
                .padding(.vertical,15)
            
            
            VStack(alignment: .leading, spacing: 14) {
                
                
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                TextField("Enter", text: $model.taskTitle)
                    
                
            }
              .frame(maxWidth: .infinity,alignment: .leading)
      
            Divider()
            
            
            VStack(alignment: .leading, spacing: 14) {
                
                
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                let taskTypes: [String] = ["Basic","Urgent","Important"]
                
                HStack(spacing:15){
                    
                    
                    ForEach(taskTypes,id:\.self){type in
                        
                        Text(type)
                            .font(.callout.weight(.black))
                            .padding(.vertical,10)
                            .padding(.horizontal,15)
                            .background{
                                
                                if model.taskType == type{
                                    
                                    Capsule()
                                        .stroke(.gray)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                }
                                
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation{ model.taskType = type}
                            }
                          
                    }
                      .frame(maxWidth: .infinity,alignment: .leading)
                }
                
            }
              .frame(maxWidth: .infinity,alignment: .leading)
      
            Divider()
            
            
            Button {
                
                if model.addToTask(contex: env.managedObjectContext){
                    
                    env.dismiss()
                }
                
            } label: {
                
                Text("SAVE TASK")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.gray)
                    .padding(.horizontal,100)
                    .padding(.vertical,12)
                    .background{
                        
                        Capsule()
                            .fill(.black)
                        
                    }
            }
          .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottom)
          .disabled(model.taskTitle == "")
          .opacity(model.taskTitle == "" ? 0.6 : 1)

            
            
                
            
            
        
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .overlay {
            
            ZStack{
                
                if model.showDatePicker{
                    
                    Rectangle()
                        .fill(.ultraThinMaterial).ignoresSafeArea()
                        .onTapGesture {
                            
                            model.showDatePicker = false
                        }
                    
                    
                    DatePicker("", selection: $model.taskDedline,in: Date.now...Date.distantFuture)
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                        .padding()
                        .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                    
                    
                }
            }
        }
    }
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
            .environmentObject(TakViewModel())
    }
}
