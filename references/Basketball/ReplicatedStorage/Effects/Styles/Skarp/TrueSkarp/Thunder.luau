 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Trove);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local _ = p1.BallController;
    local _ = p1.CameraController;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dash" and p2.Task ~= "Thunderclap and Flash" then
        if p2.Task == "Layup" then
            task.delay(0.3 - v3, function() -- Line: 94
                -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
                SfxManager:playSound({
                    Sound = "FlashImpact",
                    Parent = HumanoidRootPart
                });
                local v4 = script.Teleport:Clone();
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v4, HumanoidRootPart);
                VfxManager.BetterEmit(v4);
                VfxManager.DestroyEffect(v4, 2);
            end);
        end;

        return;
    end;

    local Torso = Character:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Skarp Thunderclap and Flash",
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

    local u7 = script.Torso:Clone();
    u7.Parent = Debris;
    VfxManager.Enable(Model, true);
    VfxManager.Enable(u7, true);
    local v8 = script.Dash:Clone();
    v8.Parent = Debris;
    v8.CFrame = (p2.CFrame or HumanoidRootPart.CFrame) * CFrame.new(0, 0, -9);
    VfxManager.Emit(v8);
    VfxManager.DestroyEffect(v8, 2);
    local u9 = nil;
    u9 = RunService.RenderStepped:Connect(function() -- Line: 63
        -- upvalues: Torso (copy), u7 (copy), Debris (ref), u9 (ref), HumanoidRootPart (copy)
        if Torso and (u7 and u7:IsDescendantOf(Debris)) then
            u7.CFrame = CFrame.new(Torso.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());

            return;
        end;

        u9:Disconnect();
    end);

    if p2.Task == "Thunderclap and Flash" then
        task.delay(p2.Time * 10 / 60 - v3, function() -- Line: 73
            -- upvalues: Other (copy), SfxManager (ref), Debris (ref), VfxManager (ref)
            if Other and Other:FindFirstChild("HumanoidRootPart") then
                SfxManager:playSound({
                    Sound = "BBZ Eclipse Blade Dash Enemy",
                    Parent = Other.HumanoidRootPart
                });
                local v10 = script.Mark:Clone();
                v10.Parent = Debris;
                v10.CFrame = Other.HumanoidRootPart.CFrame;
                VfxManager.Emit(v10);
                VfxManager.DestroyEffect(v10, 2);
            end;
        end);
    end;

    task.delay(0.5 - v3, function() -- Line: 87
        -- upvalues: VfxManager (ref), Model (copy), u7 (copy)
        VfxManager.Enable(Model, false);
        VfxManager.Enable(u7, false);
        VfxManager.DestroyEffect(Model, 2);
        VfxManager.DestroyEffect(u7, 2);
    end);
end;