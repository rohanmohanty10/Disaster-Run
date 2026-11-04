 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local _ = ReplicatedStorage.Basketball.Value;

    if p2.Task == "Forward" then
        SfxManager:playSound({
            Sound = "BBZ Goat Forward",
            Parent = HumanoidRootPart
        });
        task.delay(0.26666666666666666 - v3, function() -- Line: 28
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v4 = script.Bounce:Clone();
            v4.Parent = Debris;
            v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v4);
            VfxManager.DestroyEffect(v4, 4);
        end);
        task.delay(0.5666666666666667 - v3, function() -- Line: 36
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v5 = script.Bounce:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v5);
            VfxManager.DestroyEffect(v5, 4);
        end);
        task.delay(0.8833333333333333 - v3, function() -- Line: 44
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v6 = script.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v6);
            VfxManager.DestroyEffect(v6, 4);
        end);
        task.delay(1.25 - v3, function() -- Line: 52
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v7 = script.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 4);
        end);
        task.delay(1.6166666666666667 - v3, function() -- Line: 60
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v8 = script.Bounce:Clone();
            v8.Parent = Debris;
            v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v8);
            VfxManager.DestroyEffect(v8, 4);
        end);
        task.delay(1.7666666666666666 - v3, function() -- Line: 68
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v9 = script.Bounce:Clone();
            v9.Parent = Debris;
            v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v9);
            VfxManager.DestroyEffect(v9, 4);
        end);

        return;
    end;

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "Layup" then
            if p2.Task == "Charge" then
                local u10 = Character:FindFirstChild(script.Name .. "Goat");

                if not u10 then
                    return;
                end;

                SfxManager:playSound({
                    Sound = "BBZ Goat Charge",
                    Parent = HumanoidRootPart
                });
                Essentials:HideCharacter(Character, { u10.PrimaryPart }, nil, 0);
                local u11 = script.Charge:Clone();
                task.delay(0.25 - v3, function() -- Line: 114
                    -- upvalues: u11 (copy), Debris (ref), HumanoidRootPart (copy), Essentials (ref)
                    u11.Parent = Debris;
                    u11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 1.5707963267948966, 0);
                    Essentials:Weld(u11, HumanoidRootPart);
                end);
                task.delay(2 - v3, function() -- Line: 120
                    -- upvalues: Essentials (ref), Character (copy), u10 (copy), VfxManager (ref), u11 (copy)
                    Essentials:UnhideCharacter(Character, { u10.PrimaryPart });
                    VfxManager.Enable(u11, false);
                    VfxManager.DestroyEffect(u11, 2);
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Goat Sky Lob Layup",
            Parent = HumanoidRootPart
        });
        task.delay(0.95 - v3, function() -- Line: 97
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            local v12 = script.Shoot:Clone();
            v12:PivotTo(CFrame.new(BALL.Position));
            v12.Parent = Debris;
            VfxManager.BetterEmit(v12);
            VfxManager.DestroyEffect(v12, 4);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Goat Dribble",
        Parent = HumanoidRootPart
    });
    local v13 = script.Teleport:Clone();
    v13.Parent = Debris;
    v13.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v13, HumanoidRootPart);
    VfxManager.BetterEmit(v13);
    VfxManager.DestroyEffect(v13, 2);
    local u14 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
    Essentials:HideCharacter(Character, u14);
    task.delay(0.2, function() -- Line: 91
        -- upvalues: Essentials (ref), Character (copy), u14 (copy)
        Essentials:UnhideCharacter(Character, u14);
    end);
end;