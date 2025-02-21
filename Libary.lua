--[[
	Phoslo UI Library
	Modern & Nostalgic CSGO-Inspired Roblox UI Library
	Version 1.1.0
]]

local PhosloLib = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local function createInstance(class, properties)
    local instance = Instance.new(class)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

function PhosloLib:CreateWindow(title)
    local ScreenGui = createInstance("ScreenGui", {Parent = LocalPlayer:WaitForChild("PlayerGui")})
    
    local Window = createInstance("Frame", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.3, 0, 0.2, 0),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0,
        Draggable = true,
        Active = true
    })
    
    local UICorner = createInstance("UICorner", {
        Parent = Window,
        CornerRadius = UDim.new(0, 6)
    })
    
    local UIStroke = createInstance("UIStroke", {
        Parent = Window,
        Thickness = 2,
        Color = Color3.fromRGB(80, 80, 80)
    })
    
    local TitleBar = createInstance("TextLabel", {
        Parent = Window,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        Text = title,
        TextSize = 18,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSansBold
    })
    
    local CloseButton = createInstance("TextButton", {
        Parent = TitleBar,
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -40, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        Text = "X",
        TextSize = 20,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    return Window
end

function PhosloLib:CreateTab(parent, name)
    local TabButton = createInstance("TextButton", {
        Parent = parent,
        Size = UDim2.new(0, 120, 0, 30),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSansBold
    })
    
    return TabButton
end

function PhosloLib:CreateToggle(parent, name, callback)
    local Toggle = createInstance("TextButton", {
        Parent = parent,
        Size = UDim2.new(0, 120, 0, 30),
        BackgroundColor3 = Color3.fromRGB(70, 70, 70),
        Text = name .. " [OFF]",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSansBold
    })
    
    local toggled = false
    Toggle.MouseButton1Click:Connect(function()
        toggled = not toggled
        Toggle.Text = name .. (toggled and " [ON]" or " [OFF]")
        callback(toggled)
    end)
    
    return Toggle
end

function PhosloLib:CreateSlider(parent, name, min, max, callback)
    local SliderFrame = createInstance("Frame", {
        Parent = parent,
        Size = UDim2.new(0, 220, 0, 40),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    })
    
    local Slider = createInstance("Frame", {
        Parent = SliderFrame,
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    
    local SliderValue = createInstance("TextLabel", {
        Parent = SliderFrame,
        Size = UDim2.new(0, 50, 0, 40),
        Position = UDim2.new(1, -50, 0, 0),
        Text = tostring(min),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSansBold
    })
    
    local function update(input)
        local size = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
        Slider.Size = UDim2.new(size, 0, 1, 0)
        local value = math.floor(min + (max - min) * size)
        SliderValue.Text = tostring(value)
        callback(value)
    end
    
    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            update(input)
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    
    return SliderFrame
end

return PhosloLib
