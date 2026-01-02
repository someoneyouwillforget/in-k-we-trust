local Dropdown = {}

function Dropdown.new(parent, text, options, callback)
    local open = false
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Frame.ClipsDescendants = true
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local MainBtn = Instance.new("TextButton", Frame)
    MainBtn.Size = UDim2.new(1, 0, 0, 40)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Text = "  " .. text .. " (Select)"
    MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainBtn.Font = Enum.Font.Gotham
    MainBtn.TextSize = 13
    MainBtn.TextXAlignment = Enum.TextXAlignment.Left

    local OptionHolder = Instance.new("Frame", Frame)
    OptionHolder.Position = UDim2.new(0, 0, 0, 40)
    OptionHolder.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionHolder.BackgroundTransparency = 1
    Instance.new("UIListLayout", OptionHolder)

    for _, opt in pairs(options) do
        local OptBtn = Instance.new("TextButton", OptionHolder)
        OptBtn.Size = UDim2.new(1, 0, 0, 30)
        OptBtn.BackgroundTransparency = 1
        OptBtn.Text = "      " .. opt
        OptBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.MouseButton1Click:Connect(function()
            callback(opt)
            MainBtn.Text = "  " .. text .. " (" .. opt .. ")"
        end)
    end

    MainBtn.MouseButton1Click:Connect(function()
        open = not open
        Frame.Size = open and UDim2.new(1, 0, 0, 40 + (#options * 30)) or UDim2.new(1, 0, 0, 40)
    end)
    return Frame
end

return Dropdown
