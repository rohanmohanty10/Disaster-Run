  

 

require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Lighting = game:GetService("Lighting");
local Petal = _G.Petal;
local u1 = Petal("New");
local Tween = Petal("Util").Tween;
local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 12
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");

return function(p5) -- Line: 19
    -- upvalues: u1 (copy), Lighting (copy), PlayerGui (copy), Tween (copy)
    local v6 = p5.Duration or 1;
    local v7, v8 = unpack(p5.FadeDurations or { 0.35, 0.75 });
    local u9 = u1("BlurEffect")({
        Size = 0,
        Parent = Lighting
    });
    local u10 = u1("Frame")({
        ZIndex = 10,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.new(),
        Parent = PlayerGui.Core
    });
    Tween(u9, v7, "Quad", "Out", {
        Size = 30
    });
    Tween(u10, v7, "Quad", "Out", {
        BackgroundTransparency = 0.001
    });
    task.wait(v6);
    task.delay(v8, function() -- Line: 43
        -- upvalues: u9 (copy), u10 (copy)
        u9:Destroy();
        u10:Destroy();
    end);
    Tween(u9, v8, "Quad", "Out", {
        Size = 0
    });
    Tween(u10, v8, "Quad", "Out", {
        BackgroundTransparency = 1
    });
end;