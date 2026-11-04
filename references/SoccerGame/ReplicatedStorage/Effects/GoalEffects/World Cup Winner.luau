  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), VfxManager (copy)
    local v2 = ReplicatedStorage.Assets.GoalEffects["World Cup Winner"]:Clone();
    local v3 = script.Trophy:Clone();
    local v4 = p1.Pos * CFrame.new(20, 60, 0);
    local v5 = p1.Pos * CFrame.new(20, 12, 0);
    v3.Parent = workspace.Debris;
    v3:PivotTo(v4);
    TweenService:Create(v3.PrimaryPart, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = v5
    }):Play();
    task.wait(0.3);
    local Shooters = v2.Shooters;
    Shooters.Parent = workspace.Debris;
    Shooters:PivotTo(p1.Pos * CFrame.new(0, -4.4, 0));
    VfxManager.Enable(Shooters, true);
    VfxManager.Emit(Shooters);
    task.wait(5);
    VfxManager.Enable(Shooters, false);
    task.wait(2);
    v2:Destroy();
    Shooters:Destroy();
    v3:Destroy();
end;