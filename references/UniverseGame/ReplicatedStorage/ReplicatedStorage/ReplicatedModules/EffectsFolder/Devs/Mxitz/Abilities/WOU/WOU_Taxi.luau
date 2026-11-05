  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
local TaxiSpawn = script.TaxiSpawn;
ContentProvider:PreloadAsync({ TaxiSpawn });
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, u2) -- Line: 15
    -- upvalues: Sequence_V2 (copy), AssetHandler (copy), TaxiSpawn (copy), TweenService (copy)
    if not (p1 and p1:IsDescendantOf(workspace)) then
        return;
    end;

    local u3 = Sequence_V2.new();
    local u4 = nil;
    local u5 = nil;
    u3:AddFrame(0, function(p6) -- Line: 25
        -- upvalues: u4 (ref), AssetHandler (ref), u2 (copy), u5 (ref), TaxiSpawn (ref)
        u4 = AssetHandler.CloneAsset("Models/Taxi", {
            AbilityName = "Wonder Of U"
        });
        u4.RootPart.CFrame = u2 * CFrame.new(0, -50, 0);
        u4.Parent = workspace.Effects;
        u5 = u4.Controller.Animator:LoadAnimation(TaxiSpawn);
        u5:Play(nil, nil, 0.75);
        p6:GetCache();
    end);
    u3:AddFrame(3, function(p7) -- Line: 38
        -- upvalues: u4 (ref), u2 (copy)
        u4.RootPart.CFrame = u2;
    end);
    u3:AddFrame(90, function(p8) -- Line: 42
        -- upvalues: u5 (ref)
        u5:AdjustSpeed(0);
    end);
    u3:AddFrame(150, function(p9) -- Line: 46
    end);
    u3:GetTrove():Connect(p1.Humanoid.Died, function() -- Line: 52
        -- upvalues: u3 (copy)
        u3:Stop();
    end);
    u3:Play();

    while p1 and u3:IsPlaying() do
        task.wait(0.1);
    end;

    u5.TimePosition = 1.15;
    u5:AdjustSpeed(0.65);
    TweenService:Create(u4.Mesh, TweenInfo.new(1), {
        Transparency = 1
    }):Play();
    task.delay(1, u4.Destroy, u4);
end;