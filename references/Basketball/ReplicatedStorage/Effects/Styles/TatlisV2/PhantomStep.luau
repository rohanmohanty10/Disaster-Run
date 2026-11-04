 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local TatlisV2ScreenEffect = require(script.Parent.Parent.ScreenEffects.TatlisV2ScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), LocalPlayer (copy), DarkScreenEffect (copy), TatlisV2ScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Step" then
        if p2.Task == "Catch" then
            if LocalPlayer.Character == Character then
                TatlisV2ScreenEffect();
            end;

            local v4 = script.Catch:Clone();
            v4.Parent = Debris;
            v4.CFrame = HumanoidRootPart.CFrame;
            VfxManager.DestroyEffect(v4, 2);
            shared.vfx.emit(v4);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = p2.HasBall and "BBZ Tatlis V2 Phantom Step With Ball" or "BBZ Tatlis V2 Phantom Step Without Ball",
        Parent = HumanoidRootPart
    });
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v5 = Character:FindFirstChild(child.Name);

        if v5 then
            local v6 = child:Clone();
            v6.CFrame = v5.CFrame;
            v6.Parent = Model;
            Essentials:Weld(v6, v5);
        end;
    end;

    shared.vfx.emit(Model);
    task.delay(0.65 - v3, function() -- Line: 47
        -- upvalues: VfxManager (ref), Model (copy)
        VfxManager.Enable(Model, false);
        VfxManager.DestroyEffect(Model, 2);
    end);
    task.delay(0.23333333333333334 - v3, function() -- Line: 52
        -- upvalues: LocalPlayer (ref), Character (copy), Other (copy), DarkScreenEffect (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
            DarkScreenEffect();
        end;

        local v7 = script.Pass:Clone();
        v7.Parent = Debris;
        v7:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v7, 2);
        shared.vfx.emit(v7);
    end);
end;