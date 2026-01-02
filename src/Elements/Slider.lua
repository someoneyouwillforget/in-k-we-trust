local Slider = {}

function Slider.new(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame", parent)
    SliderFrame.Size = UDim2.new(1, 0, 0, 45)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 8)
    
    local Title = Instance.new("TextLabel", SliderFrame)
    Title.Text = "  " .. text
    Title.Size = UDim2.new(1, 0, 0.5, 0)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.Gotham
    Title.TextSize = 12
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local BarBack = Instance.new("Frame", SliderFrame)
    BarBack.Size = UDim2.new(1, -30, 0, 4)
    BarBack.Position = UDim2.new(0, 15, 0.75, -2)
    BarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", BarBack)

    local BarMain = Instance.new("Frame", BarBack)
    BarMain.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    BarMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", BarMain)

    local function move(input)
        local pos = math.clamp((input.Position.X - BarBack.AbsolutePosition.X) / BarBack.AbsoluteSize.X, 0, 1)
        BarMain.Size = UDim2.new(pos, 0, 1, 0)
        local value = math.floor(min + (max - min) * pos)
        callback(value)
    end

    BarBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then move(input) end
    end)
    
    return SliderFrame
end

return Slider
