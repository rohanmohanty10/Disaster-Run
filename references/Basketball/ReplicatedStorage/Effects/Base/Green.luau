 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), VfxManager (copy)
    local HumanoidRootPart = p2.Char:FindFirstChild("HumanoidRootPart");
    local v3 = script.Green:Clone();
    v3.Parent = Debris;
    v3.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z);
    VfxManager.Emit(v3);
    VfxManager.DestroyEffect(v3, 4);
end;