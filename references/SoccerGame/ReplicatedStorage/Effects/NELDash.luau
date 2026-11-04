  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local _ = game.Lighting;
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Shared.Popup);

local function Weld(p1, p2) -- Line: 13
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p1;
    WeldConstraint.Part1 = p2;
    WeldConstraint.Parent = p1;

    return WeldConstraint;
end;

return function(p3) -- Line: 20
    -- upvalues: EmitModule (copy)
    local HumanoidRootPart = p3.Character:FindFirstChild("HumanoidRootPart");
    local v4 = script.DashVFX:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame);
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v4.PrimaryPart;
    WeldConstraint.Parent = v4.PrimaryPart;
end;