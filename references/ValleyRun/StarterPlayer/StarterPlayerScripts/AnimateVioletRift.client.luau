 

 

local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("MapLocator")).interactables(10);
local MergeMachine = v1:WaitForChild("MergeMachine", 60);

if not MergeMachine then
    warn("AnimateVioletRift: no MergeMachine in " .. v1:GetFullName() .. " after 60 s; waiting for it");
    MergeMachine = v1:WaitForChild("MergeMachine", (1 / 0));
end;

local Base_Obsidian = MergeMachine:WaitForChild("Base_Obsidian", 30);
local v2;

if Base_Obsidian then
    v2 = Base_Obsidian:IsA("BasePart");
else
    v2 = Base_Obsidian;
end;

assert(v2, "Missing Base_Obsidian mesh");

for i = 0, 7 do
    local v3 = MergeMachine:WaitForChild(string.format("CenterGem_%02d", i), 30);
    assert(v3, "Missing center gem");
    local _ = i;
end;

for i = 0, 14 do
    local v4 = MergeMachine:WaitForChild(string.format("OrbitGem_%02d", i), 30);
    assert(v4, "Missing orbit gem");
    local _ = i;
end;

local CFrame2 = Base_Obsidian.CFrame;
local u5 = {};

for _, descendant in MergeMachine:GetDescendants() do
    if descendant:IsA("BasePart") then
        descendant.Anchored = true;

        if descendant.Name:match("^OrbitGem_") or descendant.Name:match("^CenterGem_") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            local v6 = {
                part = descendant,
                initial = CFrame2:ToObjectSpace(descendant.CFrame),
                orbit = descendant.Name:match("^OrbitGem_") ~= nil,
                phase = (tonumber(descendant.Name:match("_(%d+)")) or 0) * 1.618
            };
            table.insert(u5, v6);
        elseif descendant.Name:match("^Glow_") or descendant.Name:match("^Base_Rune_") then
            descendant.Material = Enum.Material.Neon;
            descendant.Color = Color3.fromRGB(190, 45, 255);
            descendant.CanCollide = false;
        end;
    end;
end;

local os_clock_ret = os.clock();
local u7 = 1;
local u8 = 0;
local u9 = false;

local function refreshAway() -- Line: 48
    -- upvalues: u9 (ref), LocalPlayer (copy)
    u9 = LocalPlayer:GetAttribute("InMatch") == true and true or LocalPlayer:GetAttribute("Spectating") == true;
end;

local u10 = { LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(refreshAway), LocalPlayer:GetAttributeChangedSignal("Spectating"):Connect(refreshAway) };
u9 = LocalPlayer:GetAttribute("InMatch") == true and true or LocalPlayer:GetAttribute("Spectating") == true;
local u11 = nil;
u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 57
    -- upvalues: MergeMachine (ref), u11 (ref), u10 (copy), u9 (ref), os_clock_ret (copy), u7 (ref), u8 (ref), Base_Obsidian (copy), u5 (copy)
    if not MergeMachine.Parent then
        u11:Disconnect();

        for _, v in u10 do
            v:Disconnect();
        end;

        return;
    end;

    if u9 then
        return;
    end;

    local _ = os.clock() - os_clock_ret;
    local v13 = MergeMachine:GetAttribute("MergePhase") or "Collecting";
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v14 = MergeMachine:GetAttribute("PhaseStarted") or workspace:GetServerTimeNow();
    local math_max_ret = math.max(0, ServerTimeNow - v14);
    local v15 = 1;

    if v13 == "Charging" then
        v15 = math.clamp(math_max_ret / 3.4, 0, 1) * 6 + 1;
    elseif v13 == "Collapse" then
        v15 = math.clamp(math_max_ret / 1.8, 0, 1) * 9 + 7;
    elseif v13 == "Reveal" then
        v15 = math.exp(-math_max_ret * 1.8) * 15 + 1;
    end;

    u7 = u7 + (v15 - u7) * (1 - math.exp(-p12 * 8));
    u8 = u8 + p12 * u7;
    local CFrame3 = Base_Obsidian.CFrame;
    local v16 = Base_Obsidian.Size.Y / 1.38;

    for _, v in u5 do
        if v.part.Parent then
            local Position = v.initial.Position;
            local CFrame_Angles_ret = CFrame.Angles(0, u8 * (v.orbit and 0.7 or 1.1), 0);

            if v.orbit then
                local v17 = math.sin(u8 * 1.2 + v.phase) * 0.12 * v16;
                v.part.CFrame = CFrame3 * CFrame.Angles(0, u8 * 0.22, 0) * CFrame.new(Position + Vector3.new(0, v17, 0)) * v.initial.Rotation * CFrame_Angles_ret;
            else
                v.part.CFrame = CFrame3 * CFrame.new(Position) * CFrame_Angles_ret * v.initial.Rotation;
            end;
        end;
    end;
end);