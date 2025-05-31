--[[
  Ultimate Trolling GUI for Roblox Executor
  Massive collection of trolling functions with no visual effects
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabButtons = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TabContent = Instance.new("Frame")

ScreenGui.Name = "UltimateTrollMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.Active = true
MainFrame.Draggable = true

TabButtons.Name = "TabButtons"
TabButtons.Parent = MainFrame
TabButtons.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
TabButtons.BorderSizePixel = 0
TabButtons.Position = UDim2.new(0, 0, 0, 40)
TabButtons.Size = UDim2.new(0, 130, 0, 410)

UIListLayout.Parent = TabButtons
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(0, 550, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "ULTIMATE TROLL MENU v5.0"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 20.000

CloseButton.Name = "CloseButton"
CloseButton.Parent = Title
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.93, 0, 0.1, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18.000
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

TabContent.Name = "TabContent"
TabContent.Parent = MainFrame
TabContent.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TabContent.BorderSizePixel = 0
TabContent.Position = UDim2.new(0.236, 0, 0.1, 0)
TabContent.Size = UDim2.new(0, 420, 0, 410)

-- Tab creation function
local function createTab(name, content)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name.."Tab"
    TabButton.Parent = TabButtons
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(0, 120, 0, 40)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 16.000
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name.."Frame"
    TabFrame.Parent = TabContent
    TabFrame.Active = true
    TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TabFrame.BorderSizePixel = 0
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.CanvasSize = UDim2.new(0, 0, content and #content * 0.12 or 2, 0)
    TabFrame.ScrollBarThickness = 5
    TabFrame.Visible = false
    
    if content then
        local layout = Instance.new("UIListLayout")
        layout.Parent = TabFrame
        layout.Padding = UDim.new(0, 5)
        
        for _, item in pairs(content) do
            if item.type == "button" then
                local button = Instance.new("TextButton")
                button.Parent = TabFrame
                button.Size = UDim2.new(0.95, 0, 0, 45)
                button.Position = UDim2.new(0.025, 0, 0, 0)
                button.Text = item.text
                button.Font = Enum.Font.SourceSansBold
                button.TextSize = 15
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                button.TextColor3 = Color3.fromRGB(255, 100, 100)
                button.BorderSizePixel = 0
                
                if item.callback then
                    button.MouseButton1Click:Connect(item.callback)
                end
            elseif item.type == "label" then
                local label = Instance.new("TextLabel")
                label.Parent = TabFrame
                label.Size = UDim2.new(0.95, 0, 0, 30)
                label.Position = UDim2.new(0.025, 0, 0, 0)
                label.Text = item.text
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 16
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255, 150, 150)
                label.TextXAlignment = Enum.TextXAlignment.Left
            elseif item.type == "textbox" then
                local frame = Instance.new("Frame")
                frame.Parent = TabFrame
                frame.Size = UDim2.new(0.95, 0, 0, 70)
                frame.BackgroundTransparency = 1
                
                local label = Instance.new("TextLabel")
                label.Parent = frame
                label.Size = UDim2.new(1, 0, 0.4, 0)
                label.Text = item.text or ""
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 14
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255, 150, 150)
                label.TextXAlignment = Enum.TextXAlignment.Left
                
                local textbox = Instance.new("TextBox")
                textbox.Parent = frame
                textbox.Size = UDim2.new(1, 0, 0.6, 0)
                textbox.Position = UDim2.new(0, 0, 0.4, 0)
                textbox.Font = Enum.Font.SourceSans
                textbox.TextSize = 14
                textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                textbox.BorderSizePixel = 0
                textbox.PlaceholderText = item.placeholder or ""
                textbox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                
                if item.callback then
                    textbox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            item.callback(textbox.Text)
                        end
                    end)
                end
            end
        end
    end
    
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(TabContent:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        TabFrame.Visible = true
    end)
    
    return TabFrame
end

-- Player Troll Functions
local playerTrolls = {
    {type = "label", text = "PLAYER TROLLS:"},
    
    {type = "button", text = "FLING PLAYER", callback = function()
        local target = getPlayerFromList()
        if target then
            local char = target.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local fling = Instance.new("BodyAngularVelocity")
                    fling.AngularVelocity = Vector3.new(9999, 9999, 9999)
                    fling.MaxTorque = Vector3.new(9999999, 9999999, 9999999)
                    fling.P = 999999
                    fling.Parent = root
                    task.delay(3, function() fling:Destroy() end)
                end
            end
        end
    end},
    
    {type = "button", text = "FREEZE PLAYER", callback = function()
        local target = getPlayerFromList()
        if target then
            local char = target.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = true
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "UNFREEZE PLAYER", callback = function()
        local target = getPlayerFromList()
        if target then
            local char = target.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = false
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "LOOP KILL PLAYER", callback = function()
        local target = getPlayerFromList()
        if target then
            _G.LoopKill = not _G.LoopKill
            if _G.LoopKill then
                spawn(function()
                    while _G.LoopKill and target and target.Character do
                        target.Character:BreakJoints()
                        wait(0.5)
                    end
                end)
            end
        end
    end},
    
    {type = "button", text = "INVISIBLE PLAYER", callback = function()
        local target = getPlayerFromList()
        if target then
            local char = target.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "DISABLE JUMP", callback = function()
        local target = getPlayerFromList()
        if target then
            local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = 0
            end
        end
    end},
    
    {type = "button", text = "DISABLE MOVEMENT", callback = function()
        local target = getPlayerFromList()
        if target then
            local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 0
            end
        end
    end},
    
    {type = "button", text = "REVERSE CONTROLS", callback = function()
        local target = getPlayerFromList()
        if target then
            local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local moveDir = humanoid.MoveDirection
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
                
                local connection
                connection = humanoid.Running:Connect(function(speed)
                    if speed > 0 then
                        humanoid:Move(-moveDir)
                    end
                end)
                
                task.delay(10, function()
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                    if connection then connection:Disconnect() end
                end)
            end
        end
    end},
    
    {type = "button", text = "RANDOM TELEPORT", callback = function()
        local target = getPlayerFromList()
        if target and target.Character then
            local root = target.Character:FindFirstChild("HumanoidRootPart")
            if root then
                spawn(function()
                    for i = 1, 20 do
                        root.CFrame = CFrame.new(
                            math.random(-500, 500),
                            math.random(10, 100),
                            math.random(-500, 500)
                        )
                        wait(0.2)
                    end
                end)
            end
        end
    end},
    
    {type = "button", text = "SPAM CHAT", callback = function()
        local target = getPlayerFromList()
        if target then
            _G.SpamChat = not _G.SpamChat
            if _G.SpamChat then
                spawn(function()
                    while _G.SpamChat do
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                            "GET TROLLED "..target.Name.."! "..math.random(1000,9999),
                            "All"
                        )
                        wait(0.5)
                    end
                end)
            end
        end
    end},
    
    {type = "button", text = "DISABLE TOOLS", callback = function()
        local target = getPlayerFromList()
        if target then
            local backpack = target:FindFirstChild("Backpack")
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        tool.Parent = nil
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "CRASH PLAYER", callback = function()
        local target = getPlayerFromList()
        if target then
            local char = target.Character
            if char then
                for i = 1, 100 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(1,1,1)
                    part.Anchored = true
                    part.CFrame = char:GetPivot()
                    part.Parent = workspace
                    game:GetService("Debris"):AddItem(part, 10)
                end
            end
        end
    end},
    
    {type = "textbox", text = "CUSTOM SPEED:", placeholder = "Enter speed value", callback = function(value)
        local target = getPlayerFromList()
        if target then
            local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = tonumber(value) or 16
            end
        end
    end},
    
    {type = "textbox", text = "CUSTOM JUMP:", placeholder = "Enter jump power", callback = function(value)
        local target = getPlayerFromList()
        if target then
            local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = tonumber(value) or 50
            end
        end
    end}
}

-- Server Troll Functions
local serverTrolls = {
    {type = "label", text = "SERVER TROLLS:"},
    
    {type = "button", text = "BREAK TOOLS", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local backpack = player:FindFirstChild("Backpack")
                if backpack then
                    for _, tool in pairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            tool:Destroy()
                        end
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "DISABLE ALL JUMPS", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = 0
                end
            end
        end
    end},
    
    {type = "button", text = "SLOW ALL PLAYERS", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 5
                end
            end
        end
    end},
    
    {type = "button", text = "RANDOM TELEPORT ALL", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(
                        math.random(-500, 500),
                        math.random(10, 100),
                        math.random(-500, 500)
                    )
                end
            end
        end
    end},
    
    {type = "button", text = "SPAM SERVER CHAT", callback = function()
        _G.SpamServerChat = not _G.SpamServerChat
        if _G.SpamServerChat then
            spawn(function()
                while _G.SpamServerChat do
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "SERVER TROLLED BY "..LocalPlayer.Name.."! "..math.random(1000,9999),
                        "All"
                    )
                    wait(0.5)
                end
            end)
        end
    end},
    
    {type = "button", text = "LAG SERVER", callback = function()
        _G.LagServer = not _G.LagServer
        if _G.LagServer then
            spawn(function()
                while _G.LagServer do
                    for i = 1, 100 do
                        local part = Instance.new("Part")
                        part.Size = Vector3.new(1,1,1)
                        part.Anchored = true
                        part.Parent = workspace
                        game:GetService("Debris"):AddItem(part, 10)
                    end
                    wait(0.1)
                end
            end)
        end
    end},
    
    {type = "button", text = "BREAK REMOTES", callback = function()
        for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                remote:Destroy()
            end
        end
    end},
    
    {type = "button", text = "DISABLE RESPAWNS", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                end
            end
        end
    end},
    
    {type = "button", text = "RANDOM KILL ALL", callback = function()
        spawn(function()
            for i = 1, 10 do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        player.Character:BreakJoints()
                    end
                end
                wait(0.5)
            end
        end)
    end},
    
    {type = "button", text = "MASS INVISIBLE", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "MASS FREEZE", callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = true
                    end
                end
            end
        end
    end},
    
    {type = "button", text = "MASS FLING", callback = function()
        for _, player in pairs(Players:GetPlayers())
