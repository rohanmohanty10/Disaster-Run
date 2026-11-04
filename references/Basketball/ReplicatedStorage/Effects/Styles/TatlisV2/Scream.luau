 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local TatlisV2ScreenEffect = require(script.Parent.Parent.ScreenEffects.TatlisV2ScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 20
    -- upvalues: SfxManager (copy), VfxManager (copy), DarkScreenEffect (copy), Debris (copy), TatlisV2ScreenEffect (copy), Players (copy), Knit (copy), CameraShaker (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local u4 = workspace:FindFirstChild(Character.Name .. script.Name .. "Skeleton");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Deadly Distance" then
        if p2.Task == "Scream" then
            SfxManager:playSound({
                Sound = "BBZ Tatlis V2 Scream",
                Parent = HumanoidRootPart
            });
            task.delay(0.5333333333333333 - v3, function() -- Line: 91
                -- upvalues: Knit (ref), CameraShaker (ref), TatlisV2ScreenEffect (ref), DarkScreenEffect (ref), Debris (ref), Head (copy), Essentials (ref), VfxManager (ref)
                Knit.GetController("CameraController").CamShake:Shake(CameraShaker.Presets.Explosion);
                TatlisV2ScreenEffect();
                DarkScreenEffect();
                local v5 = script.Head:Clone();
                v5.Parent = Debris;
                v5.CFrame = Head.CFrame;
                Essentials:Weld(v5, Head);
                VfxManager.DestroyEffect(v5, 2);
                shared.vfx.emit(v5);
            end);
        end;

        return;
    end;

    local v6 = {
        Sound = "BBZ Tatlis V2 Deadly Distance"
    };
    local v7;

    if u4 then
        v7 = u4:FindFirstChild("RootPart") or HumanoidRootPart;
    else
        v7 = HumanoidRootPart;
    end;

    v6.Parent = v7;
    SfxManager:playSound(v6);

    if u4 then
        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
                task.delay(0.5833333333333334 - v3, function() -- Line: 38
                    -- upvalues: descendant (copy)
                    descendant.Transparency = 0;
                end);
            end;
        end;

        VfxManager.Enable(u4, true);
        task.delay(1.85 - v3, function() -- Line: 46
            -- upvalues: VfxManager (ref), u4 (copy)
            VfxManager.Enable(u4, false);
        end);
    end;

    task.delay(0.4166666666666667 - v3, function() -- Line: 51
        -- upvalues: DarkScreenEffect (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        DarkScreenEffect();
        local v8 = script.Pass:Clone();
        v8.Parent = Debris;
        v8:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v8, 2);
        shared.vfx.emit(v8);
    end);
    task.delay(0.5833333333333334 - v3, function() -- Line: 62
        -- upvalues: TatlisV2ScreenEffect (ref), BALL (copy), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        TatlisV2ScreenEffect();
        BALL.Transparency = 1;
        local v9 = script.Pop:Clone();
        v9.Parent = Debris;
        v9:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v9, 2);
        shared.vfx.emit(v9);
    end);
    task.delay(1.3166666666666667 - v3, function() -- Line: 75
        -- upvalues: TatlisV2ScreenEffect (ref), Players (ref), Character (copy), Debris (ref), VfxManager (ref)
        TatlisV2ScreenEffect();
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

        if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
            local v10 = script.Dunk:Clone();
            v10.Parent = Debris;
            v10.CFrame = CFrame.new(workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position);
            VfxManager.DestroyEffect(v10, 4);
            shared.vfx.emit(v10);
        end;
    end);
end;