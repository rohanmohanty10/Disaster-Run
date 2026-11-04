 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Players (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v4 = workspace:FindFirstChild(script.Name .. Character.Name .. "Clone1");
    local v5 = workspace:FindFirstChild(script.Name .. Character.Name .. "Clone2");
    local BALL = Character:FindFirstChild("BALL", true);
    local v6 = {
        Sound = "BBZ Valentine Dirty Dunks Done Dirt Cheap"
    };
    local v7;

    if v5 then
        v7 = v5:FindFirstChild("Torso") or HumanoidRootPart;
    else
        v7 = HumanoidRootPart;
    end;

    v6.Parent = v7;
    SfxManager:playSound(v6);

    if v4 then
        for _, descendant in v4:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
                task.delay(0.48333333333333334 - v3, function() -- Line: 33
                    -- upvalues: descendant (copy)
                    descendant.Transparency = 0;
                end);
            end;
        end;
    end;

    if v5 then
        for _, descendant in v5:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
                task.delay(1.8166666666666667 - v3, function() -- Line: 44
                    -- upvalues: descendant (copy)
                    descendant.Transparency = 0;
                end);
            end;
        end;
    end;

    task.delay(3 - v3, function() -- Line: 51
        -- upvalues: BALL (copy)
        BALL.Transparency = 1;
    end);
    task.delay(0.48333333333333334 - v3, function() -- Line: 55
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v8 = script.Summon:Clone();
        v8.Parent = Debris;
        v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 4.75);
        VfxManager.BetterEmit(v8);
        VfxManager.DestroyEffect(v8, 4);
    end);
    task.delay(1.8166666666666667 - v3, function() -- Line: 63
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v9 = script.Summon:Clone();
        v9.Parent = Debris;
        v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 7.5);
        VfxManager.BetterEmit(v9);
        VfxManager.DestroyEffect(v9, 4);
        local v10 = script.Throw:Clone();
        v10.Parent = Debris;
        v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 10, 1) * CFrame.fromOrientation(1.3962634015954636, 3.141592653589793, 3.141592653589793);
        VfxManager.BetterEmit(v10);
        VfxManager.DestroyEffect(v10, 4);
    end);
    task.delay(3.3833333333333333 - v3, function() -- Line: 77
        -- upvalues: Debris (ref), u2 (copy), VfxManager (ref)
        local v11 = script.Teleport:Clone();
        v11.Parent = Debris;
        v11.CFrame = u2.Goal * CFrame.new(0, 0, -1.5);
        VfxManager.BetterEmit(v11);
        VfxManager.DestroyEffect(v11, 4);
    end);
    task.delay(3.55 - v3, function() -- Line: 85
        -- upvalues: Players (ref), Character (copy), Debris (ref), VfxManager (ref)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

        if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
            local v12 = script.Dunk:Clone();
            v12.Parent = Debris;
            v12.CFrame = CFrame.new(workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 4);
        end;
    end);
end;