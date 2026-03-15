local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local flying = false
local speed = 80

-- CLEANUP
if player.PlayerGui:FindFirstChild("CenturionVercel") then player.PlayerGui.CenturionVercel:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "CenturionVercel"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true

local theme = {
    Black = Color3.fromRGB(0, 0, 0),
    White = Color3.fromRGB(255, 255, 255),
    Border = Color3.fromRGB(51, 51, 51),
    DarkGray = Color3.fromRGB(15, 15, 15)
}

-- MAIN FRAME
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 500, 0, 400)
main.Position = UDim2.new(0.5, -250, 0.4, -200)
main.BackgroundColor3 = theme.Black
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", main)
stroke.Color = theme.Border

-- MINIMIZE BUTTON (The "_")
local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.BackgroundTransparency = 1
minBtn.Text = "_"
minBtn.TextColor3 = theme.White
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18

-- DRAGGABLE "C" TOGGLE (Starts Hidden)
local toggle = Instance.new("TextButton", sg)
toggle.Size = UDim2.new(0, 50, 0, 50)
toggle.Position = UDim2.new(0, 20, 0.5, -25)
toggle.BackgroundColor3 = theme.Black
toggle.Text = "C"
toggle.TextColor3 = theme.White
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 25
toggle.Visible = false
toggle.Active = true
toggle.Draggable = true -- Mobile friendly dragging
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)
local tStroke = Instance.new("UIStroke", toggle)
tStroke.Color = theme.White
tStroke.Thickness = 2

-- ANIMATION LOGIC
local function minimize()
    main:TweenPosition(UDim2.new(0.5, -250, 1.2, 0), "In", "Quart", 0.5, true, function()
        main.Visible = false
        toggle.Visible = true
        toggle.GroupTransparency = 1
        TweenService:Create(toggle, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()
    end)
end

local function restore()
    toggle.Visible = false
    main.Visible = true
    main:TweenPosition(UDim2.new(0.5, -250, 0.4, -200), "Out", "Back", 0.5, true)
end

minBtn.MouseButton1Click:Connect(minimize)
toggle.MouseButton1Click:Connect(restore)

-- HUB CONTENT (Header & Sidebar)
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1, 0, 0, 50)
header.Text = "  Centurion / Apex"
header.TextColor3 = theme.White
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.TextXAlignment = Enum.TextXAlignment.Left
header.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -70)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 0
local grid = Instance.new("UIGridLayout", scroll)
grid.CellSize = UDim2.new(0, 150, 0, 35)
grid.CellPadding = UDim2.new(0, 10, 0, 10)

-- ADD THE LOADSTRING FUNCTION
local function addBtn(name, func)
    local b = Instance.new("TextButton", scroll)
    b.Text = name
    b.BackgroundColor3 = theme.DarkGray
    b.TextColor3 = theme.White
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local s = Instance.new("UIStroke", b)
    s.Color = theme.Border
    b.MouseButton1Click:Connect(func)
end

-- BUTTONS
addBtn("EXECUTE CHUB", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gp1547416-coder/chub/refs/heads/main/main.lua"))()
end)

addBtn("FLY CONTROL", function()
    flying = not flying
    -- Fly logic here
end)

-- INITIAL BOOT
main.Position = UDim2.new(0.5, -250, 1.2, 0)
main:TweenPosition(UDim2.new(0.5, -250, 0.4, -200), "Out", "Quart", 0.8, true)
