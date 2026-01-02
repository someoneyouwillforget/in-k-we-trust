local Section = {}

function Section.new(parent, text)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 25)
    Frame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Text = text:upper()
    Label.TextColor3 = Color3.fromRGB(100, 100, 100)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 10
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    
    local Line = Instance.new("Frame", Frame)
    Line.Position = UDim2.new(0, Label.TextBounds.X + 10, 0.5, 0)
    Line.Size = UDim2.new(1, -(Label.TextBounds.X + 20), 0, 1)
    Line.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Line.BorderSizePixel = 0
    
    return Frame
end

return Section
