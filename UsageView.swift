ZStack {
    EmojiTextField(text: $iconRaw)
        .focused($isEmoji)
        .frame(width: 24, height: 24)
        .clipped()
    
    Circle()
        .foregroundStyle(.white)
    
    Circle()
        .foregroundStyle(color)
        .opacity(0.4)
    
    Button {
        isEmoji.toggle()
    } label: {
        Text(icon)
            .font(.system(size: 54))
    }
}
