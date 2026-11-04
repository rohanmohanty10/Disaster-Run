  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10, Name: Ambush
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), TweenService (copy), VfxManager (copy), Debris (copy)
    local _ = p1.State;
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local v2 = script.Ambush:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    v2.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.SnakeIdle):Play();
    Essentials:Weld(HumanoidRootPart, v2.RootPart);
    local v3 = script.AikuEye:Clone();
    v3.CFrame = Char.Head.CFrame;
    v3.Parent = workspace.Debris;
    Essentials:Weld(Char.Head, v3);
    task.wait(0.5);

    for _, child in pairs(v2:GetChildren()) do
        if child:IsA("BasePart") and child.Transparency > 0 then
            TweenService:Create(child, TweenInfo.new(0.4), {
                Transparency = 1
            }):Play();
        end;
    end;

    VfxManager.Enable(v2, false);
    VfxManager.Enable(v3, false);
    Debris:AddItem(v2, 1);
    Debris:AddItem(v3, 1);
end;