 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Johnny Wormhole Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.2333333333333333, function() -- Line: 28
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v4 = script.Bounce:Clone();
            v4.Parent = Debris;
            v4.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v4);
            VfxManager.DestroyEffect(v4, 4);
        end);
        task.delay(0.4666666666666666, function() -- Line: 36
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v5 = script.Bounce:Clone();
            v5.Parent = Debris;
            v5.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v5);
            VfxManager.DestroyEffect(v5, 4);
        end);
        task.delay(0.8444444444444444, function() -- Line: 44
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            if BALL:GetAttribute("Hidden") then
                return;
            end;

            BALL.Transparency = 1;
            local v6 = script.BigWormholeBounce:Clone();
            v6.Parent = Debris;
            v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.Angles(0, 0, 3.141592653589793);
            VfxManager.BetterEmit(v6);
            VfxManager.DestroyEffect(v6, 4);
        end);
        task.delay(0.9888888888888889, function() -- Line: 55
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            if BALL:GetAttribute("Hidden") then
                return;
            end;

            BALL.Transparency = 0;
            local v7 = script.BigWormhole:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 4);
        end);
        task.delay(1.4333333333333333, function() -- Line: 66
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            if BALL:GetAttribute("Hidden") then
                return;
            end;

            BALL.Transparency = 1;
            local v8 = script.SmallWormholeBounce:Clone();
            v8.Parent = Debris;
            v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v8);
            VfxManager.DestroyEffect(v8, 4);
        end);
        task.delay(1.8666666666666665, function() -- Line: 77
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            if BALL:GetAttribute("Hidden") then
                return;
            end;

            BALL.Transparency = 0;
            local v9 = script.SmallWormholeBounce:Clone();
            v9.Parent = Debris;
            v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v9);
            VfxManager.DestroyEffect(v9, 4);
        end);
        task.delay(2.1, function() -- Line: 88
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            if BALL:GetAttribute("Hidden") then
                return;
            end;

            BALL.Transparency = 1;
            local v10 = script.SmallWormholeBounce:Clone();
            v10.Parent = Debris;
            v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v10);
            VfxManager.DestroyEffect(v10, 4);
        end);
        task.delay(2.588888888888889, function() -- Line: 99
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            if BALL:GetAttribute("Hidden") then
                return;
            end;

            BALL.Transparency = 0;
            local v11 = script.SmallWormhole:Clone();
            v11.Parent = Debris;
            v11:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v11);
            VfxManager.DestroyEffect(v11, 4);
        end);

        return;
    end;

    if p2.Task == "Pass" then
        SfxManager:playSound({
            Sound = "BBZ Johnny Wormhole Pass",
            Parent = HumanoidRootPart
        });
        task.delay(0.2 - v3, function() -- Line: 112
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v12 = script.Bounce:Clone();
            v12.Parent = Debris;
            v12.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v12);
            VfxManager.DestroyEffect(v12, 4);
        end);
        task.delay(0.5666666666666667 - v3, function() -- Line: 120
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v13 = script.Bounce:Clone();
            v13.Parent = Debris;
            v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v13);
            VfxManager.DestroyEffect(v13, 4);
        end);
        task.delay(1.4166666666666667 - v3, function() -- Line: 128
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v14 = script.Pass:Clone();
            v14.Parent = Debris;
            v14.CFrame = CFrame.new(BALL.Position, (HumanoidRootPart.CFrame * CFrame.new(0, -3, -5.25)).Position);
            VfxManager.BetterEmit(v14, 4);
            VfxManager.DestroyEffect(v14, 4);
        end);
        task.delay(1.5166666666666666 - v3, function() -- Line: 136
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), SfxManager (ref)
            local v15 = script.Wormhole1:Clone();
            v15.Parent = Debris;
            v15:PivotTo(CFrame.new((HumanoidRootPart.CFrame * CFrame.new(0, -3, -5.25)).Position));
            VfxManager.BetterEmit(v15, 4);
            VfxManager.DestroyEffect(v15, 4);
            SfxManager:playSound({
                Sound = "BBZ Johnny Wormhole",
                Parent = v15
            });
        end);

        return;
    end;

    if p2.Task ~= "Dive" then
        if p2.Task == "Emerge" then
            SfxManager:playSound({
                Sound = "BBZ Johnny Underground Wormhole Emerge",
                Parent = HumanoidRootPart
            });
            Essentials:UnhideCharacter(Character, {}, nil, 0);
            local v16 = script.Emerge:Clone();
            v16.Parent = Debris;
            v16:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z));
            VfxManager.BetterEmit(v16);
            VfxManager.DestroyEffect(v16, 4);
            local v17 = script.Wormhole:Clone();
            v17.Parent = Debris;
            v17:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z));
            VfxManager.BetterEmit(v17);
            VfxManager.DestroyEffect(v17, 4);
            SfxManager:playSound({
                Sound = "BBZ Johnny Wormhole",
                Parent = v17
            });
        end;

        return;
    end;

    Essentials:HideCharacter(Character, {}, nil, 0);
    local v18 = script.Dive:Clone();
    v18.Parent = Debris;
    v18:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z));
    VfxManager.BetterEmit(v18);
    VfxManager.DestroyEffect(v18, 4);
    local v19 = script.Wormhole:Clone();
    v19.Parent = Debris;
    v19:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z));
    VfxManager.BetterEmit(v19);
    VfxManager.DestroyEffect(v19, 4);
    SfxManager:playSound({
        Sound = "BBZ Johnny Wormhole",
        Parent = v19
    });
    local u20 = script.Trail:Clone();
    u20.Parent = Debris;
    local _, v21, _ = HumanoidRootPart.CFrame:ToOrientation();
    local Position = HumanoidRootPart.Position;
    u20.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.6, HumanoidRootPart.Position.Z) * CFrame.fromOrientation(0, v21, 0);
    local u22 = nil;
    u22 = RunService.Heartbeat:Connect(function() -- Line: 170
        -- upvalues: Character (copy), u22 (ref), VfxManager (ref), u20 (copy), Position (ref), HumanoidRootPart (copy)
        if not (Character and (Character.Parent and Character:GetAttribute("Invis"))) then
            u22:Disconnect();
            VfxManager.Enable(u20, false);
            VfxManager.DestroyEffect(u20, 2);

            return;
        end;

        if (Position - HumanoidRootPart.Position).Magnitude == 0 then
            return;
        end;

        local _, v23, _ = CFrame.new(Position, HumanoidRootPart.Position):ToOrientation();
        Position = HumanoidRootPart.Position;
        u20.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.6, HumanoidRootPart.Position.Z) * CFrame.fromOrientation(0, v23, 0);
    end);
end;