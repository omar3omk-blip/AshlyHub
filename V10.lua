--// Ashly Hub v10 | Blox Fruits
--// Clean Version | Delta Mobile + PC

-- ===== Game Check =====
if game.PlaceId ~= 2753915549 then
    local p = game.Players.LocalPlayer
    local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    local f = Instance.new("Frame", g)
    f.Size = UDim2.new(0,380,0,140)
    f.Position = UDim2.new(0.5,-190,0.5,-70)
    f.BackgroundColor3 = Color3.fromRGB(30,30,45)
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,14)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,0,1,0)
    t.BackgroundTransparency = 1
    t.Text = "Ashly Hub v10 يعمل فقط في Blox Fruits"
    t.TextColor3 = Color3.fromRGB(255,80,80)
    t.TextScaled = true
    t.Font = Enum.Font.GothamBold
    task.wait(4)
    g:Destroy()
    return
end

-- ===== Services =====
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- Anti AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AshlyHubV10"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,320)
main.Position = UDim2.new(0.05,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(35,35,55)
main.Active = true
main.Draggable = true
Instance.new("UICorner",main).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "Ashly Hub v10"
title.TextColor3 = Color3.fromRGB(255,215,0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- ===== Button Maker =====
local function Button(text,y)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.85,0,0,45)
    b.Position = UDim2.new(0.075,0,y,0)
    b.Text = text
    b.TextScaled = true
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(180,0,0)
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,10)
    return b
end

-- ===== Fly =====
local flying = false
local flyConn

local function ToggleFly(btn)
    flying = not flying
    btn.Text = "Fly : "..(flying and "ON" or "OFF")
    btn.BackgroundColor3 = flying and Color3.fromRGB(0,180,0) or Color3.fromRGB(180,0,0)

    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    if flying then
        hum.PlatformStand = true
        flyConn = RunService.RenderStepped:Connect(function()
            hrp.AssemblyLinearVelocity = hum.MoveDirection * 75
        end)
    else
        hum.PlatformStand = false
        if flyConn then flyConn:Disconnect() end
    end
end

-- ===== Noclip =====
local noclip = false
RunService.Stepped:Connect(function()
    if noclip and player.Character then
        for _,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- ===== ESP =====
local espEnabled = false
local function ToggleESP(btn)
    espEnabled = not espEnabled
    btn.Text = "ESP : "..(espEnabled and "ON" or "OFF")
    btn.BackgroundColor3 = espEnabled and Color3.fromRGB(0,180,0) or Color3.fromRGB(180,0,0)

    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            if espEnabled then
                local h = Instance.new("Highlight", plr.Character)
                h.FillColor = Color3.fromRGB(255,0,0)
                h.OutlineColor = Color3.new(1,1,1)
            else
                for _,v in pairs(plr.Character:GetChildren()) do
                    if v:IsA("Highlight") then v:Destroy() end
                end
            end
        end
    end
end

-- ===== Buttons =====
local flyBtn = Button("Fly : OFF",0.2)
flyBtn.MouseButton1Click:Connect(function()
    ToggleFly(flyBtn)
end)

local noclipBtn = Button("Noclip : OFF",0.38)
noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "Noclip : "..(noclip and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0,180,0) or Color3.fromRGB(180,0,0)
end)

local espBtn = Button("ESP : OFF",0.56)
espBtn.MouseButton1Click:Connect(function()
    ToggleESP(espBtn)
end)

local closeBtn = Button("CLOSE",0.75)
closeBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("✅ Ashly Hub v10 Loaded Successfully")
