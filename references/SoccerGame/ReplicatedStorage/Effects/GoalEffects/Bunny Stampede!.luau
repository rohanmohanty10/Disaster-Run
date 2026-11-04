  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: VfxManager (copy), SoundManager (copy), TweenService (copy)
    local v2 = script.GoalExplosion:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(p1.Pos);
    VfxManager.Emit(v2);
    SoundManager.SpawnSound("BunnyStampede", 1, v2, 200, false);
    local v3 = script.Bunny1:Clone();
    local v4 = script.Bunny2:Clone();
    local v5 = script.Bunny3:Clone();
    v3.Parent = workspace.Debris;
    v4.Parent = workspace.Debris;
    v5.Parent = workspace.Debris;
    local v6 = v3.AnimationController:LoadAnimation(v3.Animation);
    v6.Looped = true;
    v6:Play();
    local v7 = v4.AnimationController:LoadAnimation(v4.Animation);
    v7.Looped = true;
    v7:Play();
    local v8 = v5.AnimationController:LoadAnimation(v5.Animation);
    v8.Looped = true;
    v8:Play();
    v3:PivotTo(p1.Pos * CFrame.new(0, -4, -15) * CFrame.Angles(0, 1.5707963267948966, 0));
    v4:PivotTo(p1.Pos * CFrame.new(0, -4, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
    v5:PivotTo(p1.Pos * CFrame.new(0, -4, 15) * CFrame.Angles(0, 1.5707963267948966, 0));
    TweenService:Create(v3.PrimaryPart, TweenInfo.new(2.5), {
        CFrame = v3.PrimaryPart.CFrame * CFrame.new(0, 0, 50)
    }):Play();
    TweenService:Create(v4.PrimaryPart, TweenInfo.new(2.5), {
        CFrame = v4.PrimaryPart.CFrame * CFrame.new(0, 0, 75)
    }):Play();
    TweenService:Create(v5.PrimaryPart, TweenInfo.new(2.5), {
        CFrame = v5.PrimaryPart.CFrame * CFrame.new(0, 0, 50)
    }):Play();
    task.wait(2.5);
    v3:Destroy();
    v4:Destroy();
    v5:Destroy();
    v2:Destroy();
end;