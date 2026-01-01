if game.PlaceId ~= 2753915549 then
    warn("Ashly Hub v10 يعمل فقط في Blox Fruits")
    return
end--// Ashly Hub v10 | Blox Fruits
--// Clean Version | Delta Mobile + PC
    local farmBtn = Instance.new("TextButton")
farmBtn.Size = UDim2.new(0.8,0,0,45)
farmBtn.Position = UDim2.new(0.1,0,0.1,0)
farmBtn.Text = "Auto Farm : OFF"
farmBtn.Font = Enum.Font.GothamBold
farmBtn.TextScaled = true
farmBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
farmBtn.TextColor3 = Color3.new(1,1,1)
farmBtn.Parent = pages["Farm"]  -- ضعه داخل صفحة Farm
    local RepStorage = game:GetService("ReplicatedStorage")
local DamageRemote = RepStorage:WaitForChild("DamageEnemy")  -- يضرب العدو
local QuestRemote = RepStorage:WaitForChild("QuestProgress") -- يقبل المهمة
local ChestRemote = RepStorage:WaitForChild("CollectChest")  -- يجمع الصناديق
    local autoFarm = false

farmBtn.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    farmBtn.Text = "Auto Farm : "..(autoFarm and "ON" or "OFF")
    farmBtn.BackgroundColor3 = autoFarm and Color3.fromRGB(0,180,0) or Color3.fromRGB(170,0,0)

    spawn(function()
        while autoFarm do
            task.wait(0.5)

            -- مثال: ضرب جميع الأعداء
            for _, npc in pairs(workspace.Enemies:GetChildren()) do
                DamageRemote:FireServer(npc, 50)  -- 50 = الضرر
            end

            -- مثال: قبول مهام
            QuestRemote:FireServer("QuestID") -- ضع ID المهمة المناسبة

            -- مثال: جمع صناديق
            for _, chest in pairs(workspace.Chests:GetChildren()) do
                ChestRemote:FireServer(chest)
            end
        end
    end)
end)
    
