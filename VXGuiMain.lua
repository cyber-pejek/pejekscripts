
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VXGui"
screenGui.ResetOnSpawn = false

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
end

local function createShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.Size = UDim2.new(1, 12, 1, 12)
    shadow.Position = UDim2.new(0, -6, 0, -6)
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
end

local openButton = Instance.new("TextButton")
openButton.Name = "OpenVX"
openButton.Text = "vx"
openButton.Size = UDim2.new(0, 70, 0, 38)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
openButton.TextColor3 = Color3.new(1,1,1)
openButton.Font = Enum.Font.GothamBlack
openButton.TextSize = 28
openButton.ZIndex = 4
createCorner(openButton, 12)
openButton.Parent = screenGui
createShadow(openButton)

-- Hover effect for vx button
openButton.MouseEnter:Connect(function()
    openButton.BackgroundColor3 = Color3.fromRGB(120, 200, 255)
end)
openButton.MouseLeave:Connect(function()
    openButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
end)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 370, 0, 520)
mainFrame.Position = UDim2.new(0, 80, 0, 40)
mainFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ZIndex = 3
createCorner(mainFrame, 10)
mainFrame.Parent = screenGui
createShadow(mainFrame)

local title = Instance.new("TextLabel")
title.Text = "VX Scripts"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(85, 170, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 30
title.ZIndex = 5
title.Parent = mainFrame

-- ScrollingFrame for features
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 1, -60)
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be set dynamically
scrollFrame.ScrollBarThickness = 8
scrollFrame.ZIndex = 4
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 8)
scrollCorner.Parent = scrollFrame

-- Movable GUI (do not remove)
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Key input for unlocking features
local controls = {} -- Store controls for layout and scroll

local keyLabel = Instance.new("TextLabel")
keyLabel.Text = "Enter unlock key:"
keyLabel.Size = UDim2.new(0, 120, 0, 30)
keyLabel.Position = UDim2.new(0, 10, 0, 0)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextSize = 18
keyLabel.ZIndex = 5
keyLabel.Parent = scrollFrame
table.insert(controls, keyLabel)

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 150, 0, 30)
keyBox.Position = UDim2.new(0, 140, 0, 0)
keyBox.PlaceholderText = "Enter key..."
keyBox.Text = ""
keyBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
createCorner(keyBox, 6)
keyBox.ZIndex = 5
keyBox.Parent = scrollFrame
table.insert(controls, keyBox)

local unlockLabel = Instance.new("TextLabel")
unlockLabel.Text = "Features Locked"
unlockLabel.Size = UDim2.new(0, 200, 0, 30)
unlockLabel.Position = UDim2.new(0, 10, 0, 40)
unlockLabel.BackgroundTransparency = 1
unlockLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
unlockLabel.Font = Enum.Font.GothamBold
unlockLabel.TextSize = 18
unlockLabel.ZIndex = 5
unlockLabel.Parent = scrollFrame
table.insert(controls, unlockLabel)

local unlocked = false
local unlockKey = "penekscripts"
keyBox.FocusLost:Connect(function(enter)
    if keyBox.Text == unlockKey then
        unlocked = true
        unlockLabel.Text = "Features Unlocked!"
        unlockLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
    else
        unlocked = false
        unlockLabel.Text = "Features Locked"
        unlockLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

local function createButton(text)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0, 340, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.ZIndex = 5
    createCorner(btn, 7)
    btn.Parent = scrollFrame
    table.insert(controls, btn)
    return btn
end

local function createLabel(text, width, height)
    local lbl = Instance.new("TextLabel")
    lbl.Text = text
    lbl.Size = UDim2.new(0, width, 0, height)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.Parent = scrollFrame
    table.insert(controls, lbl)
    return lbl
end

local function createTextbox(placeholder, width, height)
    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(0, width, 0, height)
    tb.PlaceholderText = placeholder
    tb.Text = ""
    tb.BackgroundColor3 = Color3.fromRGB(60,60,60)
    tb.TextColor3 = Color3.new(1,1,1)
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 18
    createCorner(tb, 6)
    tb.Parent = scrollFrame
    table.insert(controls, tb)
    return tb
end

-- Features
local flyEnabled = false
local infJumpEnabled = false
local noclipEnabled = false
local godModeEnabled = false

-- Fly
local flyBtn = createButton("Fly")
flyBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    flyEnabled = not flyEnabled
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            if flyEnabled then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "VXFly"
                bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
                bodyVelocity.Velocity = Vector3.new(0,0,0)
                bodyVelocity.Parent = humanoidRootPart
                flyBtn.Text = "Fly (ON)"
            else
                local bv = humanoidRootPart:FindFirstChild("VXFly")
                if bv then bv:Destroy() end
                flyBtn.Text = "Fly"
            end
        end
    end
end)

-- Inf Jump
local infJumpBtn = createButton("Infinite Jump")
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and unlocked then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
infJumpBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    infJumpEnabled = not infJumpEnabled
    infJumpBtn.Text = infJumpEnabled and "Infinite Jump (ON)" or "Infinite Jump"
end)

-- Noclip
local noclipBtn = createButton("Noclip")
noclipBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = noclipEnabled and "Noclip (ON)" or "Noclip"
end)
RunService.Stepped:Connect(function()
    if noclipEnabled and unlocked then
        local character = LocalPlayer.Character
        if character then
            for _, part in character:GetDescendants() do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Speed Control (textbox + button)
local speedLabel = createLabel("Set WalkSpeed:", 120, 30)
local speedTextbox = createTextbox("Enter speed (16-2000)", 120, 30)
local speedBtn = createButton("Set Speed")
local minSpeed, maxSpeed = 16, 2000

speedBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    local val = tonumber(speedTextbox.Text)
    if val then
        val = math.clamp(val, minSpeed, maxSpeed)
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = val
            end
        end
    end
end)

-- Teleport to Player (textbox only, no button)
local tpLabel = createLabel("Teleport to Player (enter nickname):", 250, 30)
local tpTextbox = createTextbox("Player Name", 120, 30)
-- Remove teleport button, use FocusLost event instead
tpTextbox.FocusLost:Connect(function(enter)
    if not unlocked then return end
    local targetName = tpTextbox.Text
    targetName = string.gsub(targetName, "^%s*(.-)%s*$", "%1") -- trim whitespace
    targetName = string.lower(targetName)
    local targetPlayer = nil
    for _, player in Players:GetPlayers() do
        if string.lower(player.Name) == targetName then
            targetPlayer = player
            break
        end
    end
    if targetPlayer and targetPlayer.Character then
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local myChar = LocalPlayer.Character
        if targetRoot and myChar then
            local myRoot = myChar:FindFirstChild("HumanoidRootPart")
            if myRoot then
                myChar:PivotTo(targetRoot.CFrame + Vector3.new(0, 3, 0))
            end
        end
    end
end)

-- God Mode (float 20 studs above ground)
local godBtn = createButton("God Mode (float 20 studs above ground)")
godBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    godModeEnabled = not godModeEnabled
    godBtn.Text = godModeEnabled and "God Mode (ON)" or "God Mode (float 20 studs above ground)"
end)

RunService.RenderStepped:Connect(function()
    if godModeEnabled and unlocked then
        local character = LocalPlayer.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                -- Raycast down to find ground
                local rayOrigin = root.Position
                local rayDirection = Vector3.new(0, -100, 0)
                local params = RaycastParams.new()
                params.FilterDescendantsInstances = {character}
                params.FilterType = Enum.RaycastFilterType.Blacklist
                local result = Workspace:Raycast(rayOrigin, rayDirection, params)
                local groundY = result and result.Position.Y or 0
                local targetY = groundY + 20
                root.CFrame = CFrame.new(root.Position.X, targetY, root.Position.Z)
            end
        end
    end
end)

-- Extra: Rainbow Character
local rainbowBtn = createButton("Rainbow Character")
local rainbowEnabled = false
rainbowBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    rainbowEnabled = not rainbowEnabled
    rainbowBtn.Text = rainbowEnabled and "Rainbow Character (ON)" or "Rainbow Character"
end)
task.spawn(function()
    while true do
        task.wait(0.2)
        if rainbowEnabled and unlocked then
            local character = LocalPlayer.Character
            if character then
                for _, part in character:GetDescendants() do
                    if part:IsA("BasePart") then
                        part.Color = Color3.fromHSV(math.random(),1,1)
                    end
                end
            end
        end
    end
end)

-- Extra: Instant Respawn
local respawnBtn = createButton("Instant Respawn")
respawnBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    LocalPlayer:LoadCharacter()
end)

-- Ultra Bypass Button
local ultraBypassBtn = createButton("Ultra Bypass (AntiCheat Killer)")
ultraBypassBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
ultraBypassBtn.TextColor3 = Color3.fromRGB(255,255,255)
ultraBypassBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    local suspicious = {"anti","cheat","ac","detect","ban","kick","security","guard","safe","log","report","remote","handler","monitor"}
    local function isSuspicious(str)
        str = string.lower(str or "")
        for _, word in suspicious do
            if string.find(str, word) then
                return true
            end
        end
        return false
    end
    local function tryDestroy(obj)
        pcall(function()
            obj:Destroy()
        end)
    end
    -- Scan and destroy scripts in common locations
    local locations = {
        LocalPlayer:FindFirstChild("PlayerScripts"),
        LocalPlayer:FindFirstChild("PlayerGui"),
        game:GetService("StarterGui"),
        game:GetService("ReplicatedFirst"),
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts"),
        game:GetService("StarterPlayer"):FindFirstChild("StarterCharacterScripts"),
        game:GetService("Workspace"),
        game:GetService("ServerScriptService"),
    }
    for _, loc in locations do
        if loc then
            for _, obj in loc:GetDescendants() do
                if obj:IsA("LocalScript") or obj:IsA("ModuleScript") or obj:IsA("Script") then
                    if isSuspicious(obj.Name) or isSuspicious(obj.Parent and obj.Parent.Name) then
                        tryDestroy(obj)
                    end
                end
                if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") or obj:IsA("BindableEvent") or obj:IsA("BindableFunction") then
                    if isSuspicious(obj.Name) then
                        tryDestroy(obj)
                    end
                end
            end
        end
    end
    -- Extra: Remove any scripts that connect to Humanoid.HealthChanged or Humanoid.Died
    local function deepScanForHumanoidHooks()
        for _, player in Players:GetPlayers() do
            if player.Character then
                for _, obj in player.Character:GetDescendants() do
                    if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
                        if isSuspicious(obj.Name) then
                            tryDestroy(obj)
                        end
                    end
                end
            end
        end
    end
    deepScanForHumanoidHooks()
    -- Extra: Remove any suspicious scripts in Workspace
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            if isSuspicious(obj.Name) then
                tryDestroy(obj)
            end
        end
    end
end)

-- DESTRUCTIVE MAP BUTTONS
local destroyPartsBtn = createButton("Delete All Parts (Map Nuke)")
destroyPartsBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 120)
destroyPartsBtn.TextColor3 = Color3.fromRGB(255,255,255)
destroyPartsBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            pcall(function() obj:Destroy() end)
        end
    end
end)

local explodeMapBtn = createButton("Explode Everything (Map BOOM)")
explodeMapBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 80)
explodeMapBtn.TextColor3 = Color3.fromRGB(255,255,255)
explodeMapBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            local explosion = Instance.new("Explosion")
            explosion.Position = obj.Position
            explosion.BlastRadius = 12
            explosion.BlastPressure = 500000
            explosion.Parent = Workspace
        end
    end
end)

local rainbowMapBtn = createButton("Rainbow Map (Colorful Destruction)")
rainbowMapBtn.BackgroundColor3 = Color3.fromRGB(120, 255, 120)
rainbowMapBtn.TextColor3 = Color3.fromRGB(0,0,0)
rainbowMapBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            obj.Color = Color3.fromHSV(math.random(),1,1)
        end
    end
end)

local gravityChaosBtn = createButton("Gravity Chaos (Map Mayhem)")
gravityChaosBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 255)
gravityChaosBtn.TextColor3 = Color3.fromRGB(255,255,255)
gravityChaosBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    local originalGravity = Workspace.Gravity
    local newGravity = math.random(10, 500)
    Workspace.Gravity = newGravity
    gravityChaosBtn.Text = "Gravity Chaos ("..newGravity..")"
    task.spawn(function()
        task.wait(5)
        Workspace.Gravity = originalGravity
        gravityChaosBtn.Text = "Gravity Chaos (Map Mayhem)"
    end)
end)

-- NEW DESTRUCTIVE MAP BUTTONS

-- 1. Shatter Map
local shatterMapBtn = createButton("Shatter Map (Break All Parts)")
shatterMapBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
shatterMapBtn.TextColor3 = Color3.fromRGB(80,80,80)
shatterMapBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            local pos = obj.Position
            local size = obj.Size
            pcall(function()
                obj:Destroy()
            end)
            -- Simulate shatter by spawning small parts
            for i = 1, 6 do
                local part = Instance.new("Part")
                part.Size = size/3
                part.Position = pos + Vector3.new(math.random(-2,2), math.random(-2,2), math.random(-2,2))
                part.Anchored = false
                part.Color = Color3.fromHSV(math.random(),1,1)
                part.Material = Enum.Material.Glass
                part.Parent = Workspace
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(math.random(-30,30),math.random(20,60),math.random(-30,30))
                bv.MaxForce = Vector3.new(1e5,1e5,1e5)
                bv.Parent = part
                game:GetService("Debris"):AddItem(part, 2)
            end
        end
    end
end)

-- 2. Black Hole
local blackHoleBtn = createButton("Black Hole (Suck Everything)")
blackHoleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
blackHoleBtn.TextColor3 = Color3.fromRGB(255,0,255)
blackHoleBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    local center = Vector3.new(0, 50, 0)
    local hole = Instance.new("Part")
    hole.Shape = Enum.PartType.Ball
    hole.Size = Vector3.new(20,20,20)
    hole.Position = center
    hole.Anchored = true
    hole.Color = Color3.fromRGB(0,0,0)
    hole.Material = Enum.Material.Neon
    hole.Parent = Workspace
    game:GetService("Debris"):AddItem(hole, 3)
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = (center - obj.Position).Unit * 120
            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            bv.Parent = obj
            game:GetService("Debris"):AddItem(bv, 1.5)
            task.spawn(function()
                task.wait(2)
                pcall(function() obj:Destroy() end)
            end)
        end
    end
end)

-- 3. Lava Flood
local lavaFloodBtn = createButton("Lava Flood (Map Lava)")
lavaFloodBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
lavaFloodBtn.TextColor3 = Color3.fromRGB(255,255,255)
lavaFloodBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            obj.Color = Color3.fromRGB(255, 80, 0)
            obj.Material = Enum.Material.Neon
            obj.Anchored = false
            obj.Position = obj.Position + Vector3.new(0, 30, 0)
        end
    end
end)

-- 4. Delete Terrain
local deleteTerrainBtn = createButton("Delete Terrain (Remove All)")
deleteTerrainBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 0)
deleteTerrainBtn.TextColor3 = Color3.fromRGB(255,255,255)
deleteTerrainBtn.MouseButton1Click:Connect(function()
    if not unlocked then return end
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain:Clear()
    end
end)

-- Layout controls vertically in scrollFrame in requested order
local function layoutControls()
    local y = 0
    local padding = 10

    -- Key unlock controls
    keyLabel.Position = UDim2.new(0, 10, 0, y)
    keyBox.Position = UDim2.new(0, 140, 0, y)
    y = y + keyLabel.AbsoluteSize.Y + padding
    unlockLabel.Position = UDim2.new(0, 10, 0, y)
    y = y + unlockLabel.AbsoluteSize.Y + padding

    -- Top features: Fly, Inf Jump, Noclip
    flyBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + flyBtn.AbsoluteSize.Y + padding
    infJumpBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + infJumpBtn.AbsoluteSize.Y + padding
    noclipBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + noclipBtn.AbsoluteSize.Y + padding

    -- Speed controls
    speedLabel.Position = UDim2.new(0, 10, 0, y)
    speedTextbox.Position = UDim2.new(0, 140, 0, y)
    speedBtn.Position = UDim2.new(0, 270, 0, y)
    y = y + speedLabel.AbsoluteSize.Y + padding

    -- Teleport controls (no button, just label and textbox)
    tpLabel.Position = UDim2.new(0, 10, 0, y)
    tpTextbox.Position = UDim2.new(0, 270, 0, y)
    y = y + tpLabel.AbsoluteSize.Y + padding

    -- God Mode
    godBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + godBtn.AbsoluteSize.Y + padding

    -- Ultra Bypass Button
    ultraBypassBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + ultraBypassBtn.AbsoluteSize.Y + padding

    -- Destructive Map Buttons
    destroyPartsBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + destroyPartsBtn.AbsoluteSize.Y + padding
    explodeMapBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + explodeMapBtn.AbsoluteSize.Y + padding
    rainbowMapBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + rainbowMapBtn.AbsoluteSize.Y + padding
    gravityChaosBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + gravityChaosBtn.AbsoluteSize.Y + padding

    -- New destructive buttons
    shatterMapBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + shatterMapBtn.AbsoluteSize.Y + padding
    blackHoleBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + blackHoleBtn.AbsoluteSize.Y + padding
    lavaFloodBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + lavaFloodBtn.AbsoluteSize.Y + padding
    deleteTerrainBtn.Position = UDim2.new(0, 10, 0, y)
    y = y + deleteTerrainBtn.AbsoluteSize.Y + padding

    -- Remaining controls (extras)
    for i, ctrl in controls do
        if ctrl ~= keyLabel and ctrl ~= keyBox and ctrl ~= unlockLabel and
           ctrl ~= flyBtn and ctrl ~= infJumpBtn and ctrl ~= noclipBtn and
           ctrl ~= speedLabel and ctrl ~= speedTextbox and ctrl ~= speedBtn and
           ctrl ~= tpLabel and ctrl ~= tpTextbox and
           ctrl ~= godBtn and ctrl ~= ultraBypassBtn and
           ctrl ~= destroyPartsBtn and ctrl ~= explodeMapBtn and ctrl ~= rainbowMapBtn and ctrl ~= gravityChaosBtn and
           ctrl ~= shatterMapBtn and ctrl ~= blackHoleBtn and ctrl ~= lavaFloodBtn and ctrl ~= deleteTerrainBtn then
            ctrl.Position = UDim2.new(0, 10, 0, y)
            y = y + ctrl.AbsoluteSize.Y + padding
        end
    end
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end

layoutControls()

-- Open/Close GUI
openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")


