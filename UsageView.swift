ZStack {
    EmojiTextField(text: $iconRaw)
        .focused($isEmoji)
        .frame(width: 24, height: 24)
        .clipped()
    
    Circle()
        .foregroundStyle(colorScheme == .light ? .white : .clear)
    
    Circle()
        .foregroundStyle(color.asColor)
        .opacity(0.4)
        .opacity(color.asColor.inactive(colorScheme))
        .animation(.default, value: color)
    
    Button {
        isEmoji.toggle()
    } label: {
        Text(icon)
            .font(.system(size: 54))
    }
}
