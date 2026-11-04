 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: Essentials (copy), VfxManager (copy), SfxManager (copy), Debris (copy), LocalPlayer (copy), Players (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Afterimage" then
        local v4 = Essentials:CreateClone(Character);
        v4.PrimaryPart = v4.HumanoidRootPart;
        v4:PivotTo(p2.CFrame or HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v4, 1);

        return;
    end;

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Perfect Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.15 - v3, function() -- Line: 37
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v5 = script.Dribble.Bounce1:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v5, 2);
            shared.vfx.emit(v5);
        end);
        task.delay(0.26666666666666666 - v3, function() -- Line: 46
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v6 = script.Dribble.Bounce2:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v6);
        end);
        task.delay(0.5166666666666667 - v3, function() -- Line: 55
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v7 = script.Dribble.Bounce1:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v7, 2);
            shared.vfx.emit(v7);
        end);
        task.delay(0.75 - v3, function() -- Line: 64
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
            SfxManager:playSound({
                Sound = "BBZ Perfection V2 Teleport",
                Parent = HumanoidRootPart
            });
            local v8 = script.Dribble.Teleport:Clone();
            v8.Parent = Debris;
            v8.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v8, HumanoidRootPart);
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8);
        end);
        task.delay(1 - v3, function() -- Line: 76
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v9 = script.Dribble.Bounce2:Clone();
            v9.Parent = Debris;
            v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v9, 2);
            shared.vfx.emit(v9);
        end);

        return;
    end;

    if p2.Task == "Move" then
        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Perfect Move",
            Parent = HumanoidRootPart
        });
        local u10 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
        task.delay(0.15 - v3, function() -- Line: 92
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v11 = script.Move.Bounce:Clone();
            v11.Parent = Debris;
            v11:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v11, 2);
            shared.vfx.emit(v11);
        end);
        task.delay(0.2 - v3, function() -- Line: 101
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref), Character (copy), u10 (copy)
            SfxManager:playSound({
                Sound = "BBZ Perfection V2 Teleport",
                Parent = HumanoidRootPart
            });
            local v12 = script.Move.Teleport:Clone();
            v12.Parent = Debris;
            v12.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v12, HumanoidRootPart);
            VfxManager.DestroyEffect(v12, 2);
            shared.vfx.emit(v12);
            Essentials:HideCharacter(Character, u10);
        end);
        task.delay(0.4 - v3, function() -- Line: 115
            -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), Character (copy), u10 (copy)
            local v13 = script.Move.Teleport:Clone();
            v13.Parent = Debris;
            v13.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v13, HumanoidRootPart);
            VfxManager.DestroyEffect(v13, 2);
            shared.vfx.emit(v13);
            Essentials:UnhideCharacter(Character, u10);
        end);
        task.delay(0.6333333333333333 - v3, function() -- Line: 127
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v14 = script.Move.Bounce:Clone();
            v14.Parent = Debris;
            v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v14, 2);
            shared.vfx.emit(v14);
        end);

        return;
    end;

    if p2.Task == "Slam" then
        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Perfect Slam",
            Parent = HumanoidRootPart
        });
        task.delay(0.31666666666666665 - v3, function() -- Line: 138
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v15 = script.Slam.Slam:Clone();
            v15.Parent = Debris;
            v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v15, 2);
            shared.vfx.emit(v15);
        end);
        task.delay(0.9166666666666666 - v3, function() -- Line: 147
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
            SfxManager:playSound({
                Sound = "BBZ Perfection V2 Teleport",
                Parent = HumanoidRootPart
            });
            local v16 = script.Slam.Teleport:Clone();
            v16.Parent = Debris;
            v16.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v16, HumanoidRootPart);
            VfxManager.DestroyEffect(v16, 2);
            shared.vfx.emit(v16);
        end);
        task.delay(1.2333333333333334 - v3, function() -- Line: 159
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v17 = script.Slam.Shoot:Clone();
            v17.Parent = Debris;
            v17:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v17, 2);
            shared.vfx.emit(v17);
        end);

        return;
    end;

    if p2.Task == "Dunk" then
        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Perfect Slam Dunk",
            Parent = HumanoidRootPart
        });
        task.delay(0.06666666666666667 - v3, function() -- Line: 170
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v18 = script.Dunk.Bounce:Clone();
            v18.Parent = Debris;
            v18:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v18, 2);
            shared.vfx.emit(v18);
        end);
        task.delay(0.36666666666666664 - v3, function() -- Line: 179
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v19 = script.Dunk.Bounce:Clone();
            v19.Parent = Debris;
            v19:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v19, 2);
            shared.vfx.emit(v19);
        end);
        task.delay(0.5333333333333333 - v3, function() -- Line: 188
            -- upvalues: Character (copy), Debris (ref), Essentials (ref), VfxManager (ref), LocalPlayer (ref)
            if not Character:FindFirstChild("Torso") then
                return;
            end;

            local v20 = script.Dunk.Torso:Clone();
            v20.Parent = Debris;
            v20.CFrame = Character.Torso.CFrame;
            Essentials:Weld(v20, Character.Torso);
            VfxManager.DestroyEffect(v20, 2);
            shared.vfx.emit(v20);

            if LocalPlayer.Character == Character then
                local v21 = script.Dunk.RushLines:Clone();
                v21.Parent = Debris;
                VfxManager.DestroyEffect(v21, 2);
                shared.vfx.emit(v21);
            end;
        end);
        task.delay(1.2833333333333334 - v3, function() -- Line: 208
            -- upvalues: Players (ref), Character (copy), Debris (ref), VfxManager (ref), LocalPlayer (ref)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

            if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
                local v22 = script.Dunk.Shoot:Clone();
                v22.Parent = Debris;
                v22.CFrame = CFrame.new(workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position);
                VfxManager.DestroyEffect(v22, 4);
                shared.vfx.emit(v22);
            end;

            if LocalPlayer.Character == Character then
                local v23 = script.Dunk.CameraFX:Clone();
                v23.Parent = Debris;
                VfxManager.DestroyEffect(v23, 4);
                shared.vfx.emit(v23);
            end;
        end);

        return;
    end;

    if p2.Task ~= "Highlight" then
        if p2.Task == "Grab" then
            SfxManager:playSound({
                Sound = "BBZ Perfection V2 Instant Grab",
                Parent = HumanoidRootPart
            });
            SfxManager:playSound({
                Sound = "BBZ Perfection V2 Teleport",
                Parent = HumanoidRootPart
            });
            local v24 = script.Grab.Teleport:Clone();
            v24.Parent = Debris;
            v24.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v24, HumanoidRootPart);
            VfxManager.DestroyEffect(v24, 2);
            shared.vfx.emit(v24);
            local u25 = Character:FindFirstChild(script.Name .. "Highlight");

            if u25 then
                TweenService:Create(u25, TweenInfo.new(0.2), {
                    FillTransparency = 0
                }):Play();
            end;

            task.delay(0.2 - v3, function() -- Line: 253
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), u25 (copy), TweenService (ref)
                local v26 = script.Grab.Grab:Clone();
                v26.Parent = Debris;
                v26:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v26, 2);
                shared.vfx.emit(v26);

                if u25 then
                    TweenService:Create(u25, TweenInfo.new(0.95), {
                        FillTransparency = 1,
                        OutlineColor = Color3.fromRGB(0, 0, 0)
                    }):Play();
                end;
            end);
            task.delay(1.15 - v3, function() -- Line: 266
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v27 = script.Grab.Throw:Clone();
                v27.Parent = Debris;
                v27:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v27, 2);
                shared.vfx.emit(v27);
            end);
        end;

        return;
    end;

    local Highlight = Instance.new("Highlight", Character);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 1.15 - v3);
end;