local SliderModule = {}

function SliderModule.new(parent, text, min, max, default, callback)
    local Slider = Instance.new("Frame", parent)
    Slider.Name = text .. "Slider"
    Slider.Size = UDim2.new(1, 0, 0, 45)
    Slider.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", Slider).CornerRadius = UDim.new(0, 8)
    
    local Title = Instance.new("TextLabel", Slider)
    Title.Text = "  " .. text
    Title.Size = UDim2.new(1, 0, 0.5, 0)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.Gotham
    Title.TextSize = 12
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local BarBack = Instance.new("Frame", Slider)
    BarBack.Size = UDim2.new(1, -20, 0, 4)
    BarBack.Position = UDim2.new(0, 10, 0.75, -2)
    BarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", BarBack)

    local BarMain = Instance.new("Frame", BarBack)
    BarMain.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    BarMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", BarMain)

    -- Interaction Nonsense
    local function move(input)
        local pos = math.clamp((input.Position.X - BarBack.AbsolutePosition.X) / BarBack.AbsoluteSize.X, 0, 1)
        BarMain.Size = UDim2.new(pos, 0, 1, 0)
        local value = math.floor(min + (max - min) * pos)
        callback(value)
    end

    BarBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            move(input)
        end
    end)

    return Slider
end

return SliderModule
