 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: Debris (copy), VfxManager (copy), SfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Ghost = p2.Ghost;
    local HumanoidRootPart = Ghost:FindFirstChild("HumanoidRootPart");

    if p2.Task ~= "Spawn" then
        if p2.Task ~= "Despawn" then
            if p2.Task == "Shoot" then
                local v3 = script.Shoot:Clone();
                v3.Parent = Debris;
                v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1, -1) * CFrame.Angles(0.7853981633974483, 0, 0);
                VfxManager.Emit(v3);
                VfxManager.DestroyEffect(v3, 2);
                SfxManager:playSound({
                    Sound = "BBZ Ghost Phantom Twin Shoot",
                    Parent = v3
                });
            end;

            return;
        end;

        local v4 = script.Despawn:Clone();
        v4.Parent = Debris;
        v4.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
        VfxManager.Emit(v4);
        VfxManager.DestroyEffect(v4, 4);
        SfxManager:playSound({
            Sound = "BBZ Ghost Phantom Twin Despawn",
            Parent = v4
        });
        local v5 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

        if v5 then
            VfxManager.Enable(v5, false);
            VfxManager.DestroyEffect(v5, 2);
        end;

        Ghost:Destroy();

        return;
    end;

    local v6 = script.Spawn:Clone();
    v6.Parent = Debris;
    v6.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
    VfxManager.Emit(v6);
    VfxManager.DestroyEffect(v6, 4);
    SfxManager:playSound({
        Sound = "BBZ Ghost Phantom Twin Spawn",
        Parent = v6
    });
    local Model = Instance.new("Model", Debris);
    Model.Name = Character.Name .. script.Name .. "Aura";
    VfxManager.DestroyEffect(Model, 8);

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v7 = Ghost:FindFirstChild(child.Name);

        if v7 then
            local v8 = child:Clone();
            v8.CFrame = v7.CFrame;
            v8.Parent = Model;
            Essentials:Weld(v8, v7);
        end;
    end;

    VfxManager.Enable(Model, true);
end;