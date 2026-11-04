  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    local v2 = ReplicatedStorage.Assets.GoalEffects["Cherry Blossom"].VFX["Cherry Blossom"]:Clone();
    v2.Parent = workspace;
    v2.CFrame = p1.Pos;
    VfxManager.Emit(v2);
    local v3 = ReplicatedStorage.Assets.GoalEffects["Cherry Blossom"].Charge:Clone();
    v3.Parent = game.SoundService;
    v3:Play();
    task.wait(0.9);
    local v4 = ReplicatedStorage.Assets.GoalEffects["Cherry Blossom"].Explode:Clone();
    v4.Parent = game.SoundService;
    v4:Play();
    task.wait(0.1);
    local v5 = ReplicatedStorage.Assets.GoalEffects["Cherry Blossom"].Presence:Clone();
    v5.Parent = game.SoundService;
    v5:Play();
    v5.Volume = 0;
    local v6 = TweenService:Create(v5, TweenInfo.new(0.5), {
        Volume = 0.7
    });
    v6:Play();
    local v7 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        TintColor = Color3.new(0.878431, 0.180392, 1)
    });
    v7:Play();
    local v8 = ReplicatedStorage.Assets.GoalEffects["Cherry Blossom"].VFX["CherryBlossom Area"]:Clone();
    v8.Parent = workspace;
    v8.CFrame = p1.Pos;
    task.wait(4);
    local v9 = TweenService:Create(v5, TweenInfo.new(0.5), {
        Volume = 0
    });
    v9:Play();
    local v10 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        TintColor = Color3.new(1, 1, 1)
    });
    v10:Play();
    VfxManager.Enable(v8, false);
    task.wait(0.5);
    v8:Destroy();
    v2:Destroy();
    v6:Destroy();
    v9:Destroy();
    v7:Destroy();
    v10:Destroy();
    table.clear(p1);
end;