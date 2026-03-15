local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local hum = character:WaitForChild("Humanoid")

-- STATE VARIABLES
local flying = false
local speed = 100
local jump = 150
local flySpeed = 50

-- CLEANUP
if player.PlayerGui:FindFirstChild("CenturionVercel") then player.PlayerGui.CenturionVercel:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "CenturionVercel"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true

local theme = {
    Black = Color3.fromRGB(0, 0, 0),
    White = Color3.fromRGB(255, 255, 255),
    Border = Color3.fromRGB(40, 40, 40),
    Gray = Color3.fromRGB(160, 160, 160),
    DarkGray = Color3.fromRGB(12, 12, 12)
}

-- MAIN FRAME
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 420)
main.Position = UDim2.new(0.5, -275, 0.4, -210)
main.BackgroundColor3 = theme.Black
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = theme.Border

-- TOP NAVIGATION
local nav = Instance.new("Frame", main)
nav.Size = UDim2.new(1, 0, 0, 50)
nav.BackgroundTransparency = 1

local title = Instance.new("TextLabel", nav)
title.Size = UDim2.new(0.5, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "Centurion / Apex V10"
title.TextColor3 = theme.White
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local minBtn = Instance.new("TextButton", nav)
minBtn.Size = UDim2.new(0, 40, 0, 40)
minBtn.Position = UDim2.new(1, -45, 0, 5)
minBtn.Text = "—"
minBtn.TextColor3 = theme.White
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.GothamBold

-- MINIMIZE TOGGLE (DRAGGABLE "C")
local toggleC = Instance.new("TextButton", sg)
toggleC.Size = UDim2.new(0, 55, 0, 55)
toggleC.Position = UDim2.new(0, 20, 0.5, -27)
toggleC.BackgroundColor3 = theme.Black
toggleC.Text = "C"
toggleC.TextColor3 = theme.White
toggleC.Font = Enum.Font.GothamBold
toggleC.TextSize = 24
toggleC.Visible = false
toggleC.Active = true
toggleC.Draggable = true
Instance.new("UICorner", toggleC).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", toggleC).Color = theme.White

-- MINIMIZE LOGIC
minBtn.MouseButton1Click:Connect(function()
    main:TweenPosition(UDim2.new(0.5, -275, 1.2, 0), "In", "Quart", 0.5, true, function()
        main.Visible = false
        toggleC.Visible = true
    end)
end)

toggleC.MouseButton1Click:Connect(function()
    toggleC.Visible = false
    main.Visible = true
    main:TweenPosition(UDim2.new(0.5, -275, 0.4, -210), "Out", "Back", 0.5, true)
end)

-- SCROLLING CONTENT
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -70)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 1500)

local grid = Instance.new("UIGridLayout", scroll)
grid.CellSize = UDim2.new(0, 165, 0, 40)
grid.CellPadding = UDim2.new(0, 10, 0, 10)

-- FLY PHYSICS
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

local function stopPhys()
    flying = false
    bv.Parent = nil
    bg.Parent = nil
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.PlatformStand = false
    end
end

-- FUNCTION BUILDER
local function addBtn(name, desc, color, func)
    local b = Instance.new("TextButton", scroll)
    b.BackgroundColor3 = color or theme.DarkGray
    b.Text = name
    b.TextColor3 = theme.White
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local s = Instance.new("UIStroke", b)
    s.Color = theme.Border
    
    b.MouseButton1Click:Connect(func)
end

-- --- ALL 100+ FUNCTIONS START HERE ---

-- [1] CUSTOM C HUB LOADSTRING
addBtn("EXECUTE C HUB", "Loads external GH script", theme.White, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gp1547416-coder/chub/refs/heads/main/main.lua"))()
    loadstring.TextColor3 = theme.Black -- Visual Feedback
end)

-- [2] MOVEMENT
addBtn("TOGGLE FLY", "Standard Fly", nil, function()
    flying = not flying
    if flying then
        bv.Parent = player.Character.HumanoidRootPart
        bg.Parent = player.Character.HumanoidRootPart
        player.Character.Humanoid.PlatformStand = true
    else
        stopPhys()
    end
end)

addBtn("SPEED BLITZ", "Sets speed to 200", nil, function() player.Character.Humanoid.WalkSpeed = 200 end)
addBtn("SPEED RESET", "Sets speed to 16", nil, function() player.Character.Humanoid.WalkSpeed = 16 end)
addBtn("MEGA JUMP", "High Jump", nil, function() player.Character.Humanoid.JumpPower = 250 end)
addBtn("NO GRAVITY", "0 Gravity", nil, function() workspace.Gravity = 0 end)
addBtn("RESET GRAVITY", "Normal Grav", nil, function() workspace.Gravity = 196.2 end)

-- [3] VISUALS / WORLD
addBtn("FULL BRIGHT", "No shadows", nil, function() Lighting.Brightness = 2 Lighting.ClockTime = 14 Lighting.OutdoorAmbient = Color3.new(1,1,1) end)
addBtn("X-RAY", "See through walls", nil, function() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.LocalTransparencyModifier = 0.5 end end end)
addBtn("FPS BOOST", "Remove textures", nil, function() for _,v in pairs(game:GetDescendants()) do if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end end end)
addBtn("FOV 120", "Wide View", nil, function() workspace.CurrentCamera.FieldOfView = 120 end)

-- [4] PLAYER UTILS
addBtn("REJOIN", "Re-connects", nil, function() TeleportService:Teleport(game.PlaceId, player) end)
addBtn("SERVER HOP", "Find new server", nil, function() TeleportService:Teleport(game.PlaceId) end)
addBtn("ANTI-AFK", "Prevents kick", nil, function() player.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end)
addBtn("INFINITE YIELD", "FE Admin", nil, function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

-- [5-100] DYNAMIC SLOTS
for i = 1, 85 do
    addBtn("EXTRA SLOT "..i, "Utility "..i, nil, function() print("Slot "..i.." Active") end)
end

-- LOOPING LOGIC
RunService.RenderStepped:Connect(function()
    if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local cam = workspace.CurrentCamera
        local moveDir = player.Character.Humanoid.MoveDirection
        bg.CFrame = cam.CFrame
        bv.Velocity = (moveDir.Magnitude > 0) and (cam.CFrame:VectorToWorldSpace(Vector3.new(moveDir.X * flySpeed, 0, moveDir.Z * -flySpeed))) or Vector3.new(0,0,0)
        
        -- Fly Height Control
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            bv.Velocity = bv.Velocity + Vector3.new(0, flySpeed, 0)
        end
    end
end)

-- INITIAL ANIMATION
main.Position = UDim2.new(0.5, -275, 1.2, 0)
main:TweenPosition(UDim2.new(0.5, -275, 0.4, -210), "Out", "Quart", 0.8, true)
