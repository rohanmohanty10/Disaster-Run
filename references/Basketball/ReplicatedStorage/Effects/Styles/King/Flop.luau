 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Teams");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: Effects (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), ReplicatedStorage (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local PassingTo = p2.PassingTo;
    local Enemy = p2.Enemy;
    local Referee = p2.Referee;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u4 = Enemy and Enemy:FindFirstChild("BALL", true) or Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "Highlight" then
            if p2.Task == "Cleanup" then
                local v5 = Character:FindFirstChild(script.Name .. "Highlight");

                if v5 then
                    v5:Destroy();

                    return;
                end;
            elseif p2.Task == "Pass" then
                if PassingTo:FindFirstChild("HumanoidRootPart") then
                    local v6 = script.Pass:Clone();
                    v6.Parent = Debris;
                    v6.CFrame = CFrame.new(u4.Position, PassingTo.HumanoidRootPart.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                    VfxManager.Emit(v6);
                    VfxManager.DestroyEffect(v6, 6);

                    return;
                end;
            else
                if p2.Task == "Shoot" then
                    local BALL = PassingTo:FindFirstChild("BALL", true);
                    local Value = ReplicatedStorage.Basketball.Value;
                    local Model = Instance.new("Model");
                    Model.Parent = Debris;

                    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
                        local v7 = PassingTo:FindFirstChild(child.Name);

                        if v7 then
                            local v8 = child:Clone();
                            v8.CFrame = v7.CFrame;
                            v8.Parent = Model;
                            Essentials:Weld(v8, v7);
                        end;
                    end;

                    local u9 = script.PassingToBall:Clone();
                    u9.Parent = Debris;
                    u9.CFrame = BALL.CFrame;
                    Essentials:Weld(u9, BALL);
                    task.delay(0.3 - v3, function() -- Line: 136
                        -- upvalues: VfxManager (ref), u9 (copy), Value (copy), Essentials (ref)
                        VfxManager.Enable(u9, false);
                        u9:FindFirstChild("WeldConstraint"):Destroy();
                        u9.CFrame = Value.CFrame;
                        Essentials:Weld(u9, Value);
                        VfxManager.Enable(u9, true);
                    end);
                    task.delay(3.3 - v3, function() -- Line: 144
                        -- upvalues: VfxManager (ref), Model (copy), u9 (copy)
                        VfxManager.Enable(Model, false);
                        VfxManager.Enable(u9, false);
                        VfxManager.DestroyEffect(Model, 2);
                        VfxManager.DestroyEffect(u9, 2);
                    end);

                    return;
                end;

                if p2.Task == "Charge" or p2.Task == "Block" then
                    local v10 = Character:FindFirstChild(script.Name .. "Highlight");

                    if v10 then
                        v10:Destroy();
                    end;

                    if not (Referee and (Referee:FindFirstChild("HumanoidRootPart") and (Referee:FindFirstChild("Head") and (Referee:FindFirstChild("Torso") and Referee:FindFirstChild("Right Arm"))))) then
                        return;
                    end;

                    local u11 = script.Ball:Clone();
                    u11.Parent = Debris;
                    u11.CFrame = u4.CFrame;
                    Essentials:Weld(u11, u4);
                    local u12 = script.Head:Clone();
                    u12.Parent = Debris;
                    u12.CFrame = Referee.Head.CFrame;
                    Essentials:Weld(u12, Referee.Head);
                    local u13 = script.Poof:Clone();
                    u13.Parent = Debris;
                    u13.CFrame = Referee.Torso.CFrame;
                    Essentials:Weld(u13, Referee.Torso);
                    task.delay(0.2 - v3, function() -- Line: 173
                        -- upvalues: VfxManager (ref), u13 (copy), Debris (ref), Enemy (copy), HumanoidRootPart (copy)
                        VfxManager.Emit(u13);
                        local v14 = script.Hit:Clone();
                        v14.Parent = Debris;
                        v14.CFrame = CFrame.new(Enemy.HumanoidRootPart.Position, HumanoidRootPart.Position) * CFrame.new(0, 0, -(Enemy.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude / 2);
                        VfxManager.Emit(v14);
                        VfxManager.DestroyEffect(v14, 2);
                    end);
                    task.delay(0.6 - v3, function() -- Line: 183
                        -- upvalues: VfxManager (ref), u12 (copy)
                        VfxManager.Enable(u12, true);
                    end);
                    task.delay(1 - v3, function() -- Line: 187
                        -- upvalues: VfxManager (ref), u12 (copy)
                        VfxManager.Enable(u12, false);
                        VfxManager.DestroyEffect(u12, 2);
                    end);

                    if p2.Task == "Charge" then
                        Effects:SubtitleV2({ { "Commentator", "Contact made. Ref appears. And we\'ve got a call!", 5 } });
                        SfxManager:playSound({
                            Sound = "BBZ King Flop Charge",
                            Parent = Referee
                        });
                        SfxManager:playSound({
                            Sound = "BBZ King Flop Charge Voice",
                            Parent = workspace
                        });
                        task.delay(1.5 - v3, function() -- Line: 204
                            -- upvalues: Debris (ref), Referee (copy), VfxManager (ref), Enemy (copy)
                            local v15 = script["Right Arm"]:Clone();
                            v15.Parent = Debris;
                            v15.CFrame = Referee["Right Arm"].CFrame;
                            VfxManager.Emit(v15);
                            VfxManager.DestroyEffect(v15, 2);
                            local v16 = script.Foul:Clone();
                            v16.Parent = Debris;
                            v16.CFrame = Enemy.HumanoidRootPart.CFrame;
                            VfxManager.Emit(v16);
                            VfxManager.DestroyEffect(v16, 2);
                        end);
                        task.delay(2.183333333333333 - v3, function() -- Line: 218
                            -- upvalues: Debris (ref), u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
                            local v17 = script.Give:Clone();
                            v17.Parent = Debris;
                            v17.CFrame = CFrame.new(u4.Position, HumanoidRootPart.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                            VfxManager.Emit(v17);
                            VfxManager.DestroyEffect(v17, 6);
                        end);
                        task.delay(2.5833333333333335 - v3, function() -- Line: 226
                            -- upvalues: VfxManager (ref), u11 (copy)
                            VfxManager.Enable(u11, false);
                            VfxManager.DestroyEffect(u11, 2);
                        end);
                        task.delay(2.9 - v3, function() -- Line: 231
                            -- upvalues: VfxManager (ref), u13 (copy), Referee (copy)
                            VfxManager.Emit(u13);
                            VfxManager.DestroyEffect(u13, 2);

                            if Referee then
                                Referee:Destroy();
                            end;
                        end);

                        return;
                    end;

                    if p2.Task == "Block" then
                        Effects:SubtitleV2({ { "Commentator", "He sells it! Ref buys it! Penalty called!", 4 } });
                        SfxManager:playSound({
                            Sound = "BBZ King Flop Block",
                            Parent = Referee
                        });
                        SfxManager:playSound({
                            Sound = "BBZ King Flop Block Voice",
                            Parent = workspace
                        });
                        task.delay(1 - v3, function() -- Line: 251
                            -- upvalues: VfxManager (ref), u11 (copy)
                            VfxManager.Enable(u11, false);
                            VfxManager.DestroyEffect(u11, 2);
                        end);
                        task.delay(1.5 - v3, function() -- Line: 256
                            -- upvalues: Debris (ref), Referee (copy), VfxManager (ref), HumanoidRootPart (copy)
                            local v18 = script["Right Arm"]:Clone();
                            v18.Parent = Debris;
                            v18.CFrame = Referee["Right Arm"].CFrame;
                            VfxManager.Emit(v18);
                            VfxManager.DestroyEffect(v18, 2);
                            local v19 = script.Foul:Clone();
                            v19.Parent = Debris;
                            v19.CFrame = HumanoidRootPart.CFrame;
                            VfxManager.Emit(v19);
                            VfxManager.DestroyEffect(v19, 2);
                        end);
                        task.delay(1.5666666666666667 - v3, function() -- Line: 270
                            -- upvalues: VfxManager (ref), u13 (copy), Referee (copy)
                            VfxManager.Emit(u13);
                            VfxManager.DestroyEffect(u13, 2);

                            if Referee then
                                Referee:Destroy();
                            end;
                        end);
                    end;
                end;
            end;

            return;
        end;

        local Highlight = Instance.new("Highlight", Character);
        Highlight.Name = script.Name .. "Highlight";
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineColor = Color3.fromRGB(228, 255, 130);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = 1;
        VfxManager.DestroyEffect(Highlight, 5);

        return;
    end;

    if p2.Number == 1 then
        Effects:SubtitleV2({ { "Commentator", "Fake look. No look pass! Beautiful!", 4 } });
    elseif p2.Number == 2 then
        Effects:SubtitleV2({ { "Commentator", "King dribbling. Sells the look. And whips a no look dime! Defender didn\'t even see it coming!", 6 } });
    end;

    SfxManager:playSound({
        Sound = "BBZ King No Look Pass",
        Parent = HumanoidRootPart
    });
    SfxManager:playSound({
        Sound = `BBZ King No Look Pass Voice{p2.Number}`,
        Parent = workspace
    });
    local u20 = script.Ball:Clone();
    u20.Parent = Debris;
    u20.CFrame = u4.CFrame;
    Essentials:Weld(u20, u4);
    task.delay(0.23333333333333334 - v3, function() -- Line: 56
        -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
        local v21 = script.Bounce:Clone();
        v21.Parent = Debris;
        v21.CFrame = CFrame.new(u4.Position.X, math.clamp(u4.Position.Y, 1, 1.5), u4.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v21);
        VfxManager.DestroyEffect(v21, 2);
    end);
    task.delay(0.45 - v3, function() -- Line: 64
        -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
        local v22 = script.Bounce:Clone();
        v22.Parent = Debris;
        v22.CFrame = CFrame.new(u4.Position.X, math.clamp(u4.Position.Y, 1, 1.5), u4.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v22);
        VfxManager.DestroyEffect(v22, 2);
    end);
    task.delay(0.7166666666666667 - v3, function() -- Line: 72
        -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
        local v23 = script.Bounce:Clone();
        v23.Parent = Debris;
        v23.CFrame = CFrame.new(u4.Position.X, math.clamp(u4.Position.Y, 1, 1.5), u4.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v23);
        VfxManager.DestroyEffect(v23, 2);
    end);
    task.delay(1.1833333333333333 - v3, function() -- Line: 80
        -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
        local v24 = script.Bounce:Clone();
        v24.Parent = Debris;
        v24.CFrame = CFrame.new(u4.Position.X, math.clamp(u4.Position.Y, 1, 1.5), u4.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v24);
        VfxManager.DestroyEffect(v24, 2);
    end);
    task.delay(1.4166666666666667 - v3, function() -- Line: 88
        -- upvalues: VfxManager (ref), u20 (copy)
        VfxManager.Enable(u20, false);
        VfxManager.DestroyEffect(u20, 2);
    end);
end;