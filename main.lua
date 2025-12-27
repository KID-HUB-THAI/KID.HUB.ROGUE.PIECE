local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open", -- lucide icon. optional
    Author = "by .ftgs and .ftgs", -- optional
})
local Tab = Window:Tab({
    Title = "Main",
    Icon = "optional", -- optional
    Locked = false,
})
local RunService = game:GetService("RunService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Serverside")

local args = {
    "Server",
    "Misc",
    "Observation",
    1
}

local running = false
local loopConn

local Toggle = Tab:Toggle({
    Title = "Observation Loop",
    Desc = "(ต้องมีObservationก่อนถึงจะเปิดได้)() Loop Observation (ยิงค้าง)",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        running = state
        print("Loop:", state)

        if running then
            -- เริ่ม loop ยิงตลอด
            if loopConn then loopConn:Disconnect() end
            loopConn = RunService.Heartbeat:Connect(function()
                Remote:FireServer(unpack(args))
            end)
        else
            -- หยุด loop (แต่ไม่สั่งปิด Observation)
            if loopConn then
                loopConn:Disconnect()
                loopConn = nil
            end
        end
    end
})
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Serverside")

-- รวม args ทั้งหมด (ยกเว้น Observation)
local AllArgs = {
    -- Haki ON


    -- Combat
    {"Server","Combat","M1s","Combat",1},
    {"Server","Combat","M1s","Sukuna",1},
    {"Server","Combat","M1s","Aizen",1},

    -- Sword
    {"Server","Sword","M1s","Katana",1},
    {"Server","Sword","M1s","Dual Katana",1},
    {"Server","Sword","M1s","Dark Blade",1},
    {"Server","Sword","M1s","Zangetsu",1},
    {"Server","Sword","M1s","Tanjiro's Nichirin",1},
    {"Server","Sword","M1s","Dual Dagger",1},
    {"Server","Sword","M1s","Yuta's Katana",1},

    -- Metal Bat (2 คำสั่ง)
    {"Server","Sword","M1s","Metal Bat",4},
    {"Server","Sword","Swing","Metal Bat"},
}

local loopConn

local Toggle = Tab:Toggle({
    Title = "Auto All (No Observation)",
    Desc = "รวมทุกอย่างอัตโนมัติในปุ่มเดียว",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        print("Auto All:", state)

        if state then
            if loopConn then loopConn:Disconnect() end
            loopConn = RunService.Heartbeat:Connect(function()
                for _, args in ipairs(AllArgs) do
                    Remote:FireServer(unpack(args))
                end
            end)
        else
            if loopConn then
                loopConn:Disconnect()
                loopConn = nil
            end
        end
    end
})




local Tab = Window:Tab({
    Title = "Tp",
    Icon = "optional", -- optional
    Locked = false,
})
-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MapsFolder = workspace:WaitForChild("Maps")
local SelectedIsland

local function getIslands()nds()
    local islands = {}
    for _, island in ipairs(MapsFolder:GetChildren()) do
        if island:IsA("Model") then
            table.insert(islands, island.Name)
        end
    end
    return islands
end

local islandList = getIslands()
SelectedIsland = islandList[1]

local Dropdown = Tab:Dropdown({
    Title = "Select Island",
    Desc = "เลือกเกาะ",
    Values = islandList,
    Value = islandList[1],
    Callback = function(option)
        SelectedIsland = option
    end
})nd
})

local Button = Tab:Button({
    Title = "Teleport",
    Desc = "วาปไปเหนือเกาะ 50 studs",
    Locked = false,
    Callback = function()
        if not SelectedIsland then return end

        local island = MapsFolder:FindFirstChild(SelectedIsland)
        if not island then return end

        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local offset = Vector3.new(0, 50, 0) -- สูงกว่าเกาะ 50 studs

        if island.PrimaryPart then
            hrp.CFrame = island.PrimaryPart.CFrame + offset
        else
            local part = island:FindFirstChildWhichIsA("BasePart", true)
            if part then
                hrp.CFrame = part.CFrame + offset
            end
        end
    end
})



local Tab = Window:Tab({
    Title = "fram",
    Icon = "optional", -- optional
    Locked = false,
})
-- servicesvices
-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CharactersFolder = workspace:WaitForChild("Main"):WaitForChild("Characters")

local SelectedIsland
local SelectedMonster
local SelectedIndex

-- ดึงรายชื่อเกาะ
local function getIslands()
    local list = {}
    for _, island in ipairs(CharactersFolder:GetChildren()) do
        table.insert(list, island.Name)
    end
    return list
end

-- ดึงชื่อมอนในเกาะ
local function getMonsters(islandName)
    local list = {}
    local island = CharactersFolder:FindFirstChild(islandName)
    if island then
        for _, mon in ipairs(island:GetChildren()) do
            table.insert(list, mon.Name)
        end
    end
    return list
end

-- ดึงเลขตัวมอน (1-5)
local function getIndexes(islandName, monName)
    local list = {}
    local island = CharactersFolder:FindFirstChild(islandName)
    local mon = island and island:FindFirstChild(monName)
    if mon then
        for _, p in ipairs(mon:GetChildren()) do
            if p:IsA("BasePart") then
                table.insert(list, p.Name)
            end
        end
    end
    table.sort(list)
    return list
end

-- Dropdown เกาะ
local islandList = getIslands()
SelectedIsland = islandList[1]

local IslandDropdown = Tab:Dropdown({
    Title = "Select Island",
    Desc = "เลือกเกาะ",
    Values = islandList,
    Value = islandList[1],
    Callback = function(opt)
        SelectedIsland = opt
        local mons = getMonsters(opt)
        SelectedMonster = mons[1]
        MonsterDropdown:Refresh(mons, true)
    end
})

-- Dropdown มอน
local MonsterDropdown
MonsterDropdown = Tab:Dropdown({
    Title = "Select Monster",
    Desc = "เลือกชื่อมอน",
    Values = {},
    Value = nil,
    Callback = function(opt)
        SelectedMonster = opt
        local idx = getIndexes(SelectedIsland, opt)
        SelectedIndex = idx[1]
        IndexDropdown:Refresh(idx, true)
    end
})

-- Dropdown เลขตัว (1-5)
local IndexDropdown
IndexDropdown = Tab:Dropdown({
    Title = "Select Index",
    Desc = "เลือกตัวที่ (1-5)",
    Values = {},
    Value = nil,
    Callback = function(opt)
        SelectedIndex = opt
    end
})

-- ปุ่ม TP
local Button = Tab:Button({
    Title = "TP to Monster",
    Desc = "วาปไปบนหัวมอนที่เลือก",
    Locked = false,
    Callback = function()
        if not (SelectedIsland and SelectedMonster and SelectedIndex) then return end

        local island = CharactersFolder:FindFirstChild(SelectedIsland)
        local monFolder = island and island:FindFirstChild(SelectedMonster)
        local part = monFolder and monFolder:FindFirstChild(SelectedIndex)

        if part and part:IsA("BasePart") then
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0) -- อยู่เหนือหัว
        else
            warn("ไม่พบมอนตามที่เลือก")
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local CharactersFolder = workspace:WaitForChild("Main"):WaitForChild("Characters")

local SelectedIsland
local SelectedMonster
local SelectedIndex
local HeightOffset = 70 -- ค่าเริ่มต้นจาก Slider

local followConn

-- ===== Slider ปรับความสูง =====
local Slider = Tab:Slider({
    Title = "TP Height",
    Desc = "ปรับระยะเหนือหัวมอน",
    Step = 1,
    Value = {
        Min = 20,
        Max = 120,
        Default = 70,
    },
    Callback = function(value)
        HeightOffset = value
    end
})

-- ===== ปุ่มเริ่ม/หยุดการตาม =====
local FollowToggle = Tab:Toggle({
    Title = "Follow Monster",
    Desc = "TP ค้างไว้บนหัวมอน + หันหน้าลง",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        if state then
            if followConn then followConn:Disconnect() end
            followConn = RunService.Heartbeat:Connect(functi                if not (SelectedIsland and SelectedMonster and SelectedIndex) then return end

                local island = CharactersFolder:FindFirstChild(SelectedIsland)
                local monFolder = island and island:FindFirstChild(SelectedMonster)
                local part = monFolder and monFolder:FindFirstChild(SelectedIndex)

                if part and part:IsA("BasePart") then
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local targetPos = part.Position + Vector3.new(0, HeightOffset, 0)
                        -- หันหน้าลงไปหามอน
                        hrp.CFrame = CFrame.new(targetPos, part.Position)
                    end
                end
            end)
        else
            if followConn then
                followConn:Disconnect()
                followConn = nil
            end
        end
    end
})
