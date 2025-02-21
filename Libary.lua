--[[
    Phoslo UI Library
    Modern & Nostalgic CSGO-Inspired Roblox UI Library
    Version 1.0.1
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
        BackgroundColor3 = Color3.fromRGB(25, 0, 0),
        BorderSizePixel = 2,
        BorderColor3 = Color3.fromRGB(150, 20, 20)
    })
    
    local UICorner = createInstance("UICorner", {
        Parent = Window,
        CornerRadius = UDim.new(0, 6)
    })
    
    local TitleBar = createInstance("TextLabel", {
        Parent = Window,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(35, 0, 0),
        BorderSizePixel = 0,
        Text = title,
        TextSize = 20,
        TextColor3 = Color3.fromRGB(255, 50, 50),
        Font = Enum.Font.GothamBold
    })
    
    local UIStroke = createInstance("UIStroke", {
        Parent = Window,
        Color = Color3.fromRGB(255, 50, 50),
        Thickness = 2
    })
    
    local CloseButton = createInstance("TextButton", {
        Parent = TitleBar,
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -40, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        Text = "X",
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Dragging functionality
    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
        end
    end)
    
    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return Window
end

return PhosloLib
