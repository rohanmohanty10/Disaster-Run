  

local game_ReplicatedStorage = game.ReplicatedStorage;
local TweenService = game:GetService("TweenService");
local VfxManager = require(game.ReplicatedStorage.Shared.VfxManager);
local Essentials = require(game.ReplicatedStorage.Shared.Essentials);
script.Parent.OnClientEvent:Connect(function(u1) -- Line: 7
    -- upvalues: VfxManager (copy), TweenService (copy), game_ReplicatedStorage (copy), Essentials (copy)
    VfxManager.Enable(u1, false);

    for _, descendant in u1:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) then
            descendant.LocalTransparencyModifier = 1;
            TweenService:Create(descendant, TweenInfo.new(0.6), {
                LocalTransparencyModifier = 0
            }):Play();
        end;
    end;

    task.delay(0.25, function() -- Line: 15
        -- upvalues: VfxManager (ref), u1 (copy), game_ReplicatedStorage (ref), Essentials (ref)
        VfxManager.Enable(u1, true);
        local v2 = game_ReplicatedStorage.Assets.Auras.Trap.Activate:Clone();
        v2.Emit.CFrame = CFrame.new(0, 0, 0);
        v2.Emit2.CFrame = CFrame.new(0, 0, 0);
        v2.CFrame = u1.PrimaryPart.CFrame;
        v2.Parent = u1;
        Essentials:Weld(v2, u1.PrimaryPart);
        VfxManager.Emit(v2);
    end);
end);