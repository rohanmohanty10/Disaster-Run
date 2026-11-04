 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");
Trove.new();

return function(p1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), Debris (copy), RunService (copy), VfxManager (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local _ = p1.BallController;
    local _ = p1.CameraController;
    local Character = p2.Character;
    local v3 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if p2.Task == "Spawn" then
        Effects:SubtitleV2({
            { v3, "Which one is real? Take a guess.", 2 }
        });
        Character.Archivable = true;
        local u4 = Character:Clone();
        Character.Archivable = false;
        u4.Parent = p2.Hitbox;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        HumanoidRootPart2.Anchored = true;
        u4.PrimaryPart = HumanoidRootPart2;
        local u5 = {};

        for _, descendant in pairs(u4:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                descendant:Destroy();
            end;
        end;

        table.insert(u5, {
            Character = HumanoidRootPart,
            Clone = HumanoidRootPart2
        });

        for _, descendant in pairs(Character:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                local v6 = descendant:Clone();
                v6.Parent = u4;
                v6.Anchored = true;

                for _, descendant2 in pairs(v6:GetDescendants()) do
                    if descendant2:IsA("BasePart") or (descendant2:IsA("Motor6D") or (descendant2:IsA("Weld") or (descendant2:IsA("WeldConstraint") or (descendant2:IsA("BallSocketConstraint") or descendant2:IsA("RigidConstraint"))))) then
                        descendant2:Destroy();
                    end;
                end;

                table.insert(u5, {
                    Character = descendant,
                    Clone = v6
                });
            end;
        end;

        if u4:FindFirstChild("Torso") and (u4:FindFirstChild("FrontJersey") and u4:FindFirstChild("BackJersey")) then
            u4.FrontJersey.Adornee = u4.Torso;
            u4.BackJersey.Adornee = u4.Torso;
        end;

        local u9 = Character.ChildAdded:Connect(function(p7) -- Line: 87
            -- upvalues: u4 (copy), Character (ref)
            if not (p7:IsA("BasePart") or p7:IsA("Model")) then
                local v8 = p7:Clone();
                v8.Parent = u4;

                if v8:IsA("Highlight") and v8.Adornee == Character then
                    v8.Adornee = u4;
                end;
            end;
        end);
        local u12 = Character.ChildRemoved:Connect(function(p10) -- Line: 98
            -- upvalues: u4 (copy)
            local v11 = u4:FindFirstChild(p10.Name);

            if v11 then
                v11:Destroy();
            end;
        end);
        local u13 = nil;
        local BALL = Character:FindFirstChild("BALL", true);
        local BALL2 = u4:FindFirstChild("BALL");

        if BALL and BALL2 then
            local u14 = BALL.Trails:FindFirstChildOfClass("Trail");
            local u15 = BALL2.Trails:FindFirstChildOfClass("Trail");

            if u14 and u15 then
                u13 = u14:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 112
                    -- upvalues: u15 (copy), u14 (copy)
                    u15.Enabled = u14.Enabled;
                end);
            end;
        end;

        local Ring = workspace:FindFirstChild("Ring");
        local u16;

        if Ring then
            u16 = Ring:Clone();
            u16.Parent = Debris;
            u16.CFrame = CFrame.new(HumanoidRootPart2.Position.X, 1, HumanoidRootPart2.Position.Z) * Ring.CFrame.Rotation;
        else
            u16 = nil;
        end;

        local Start = p2.Start;
        local u17 = nil;
        u17 = RunService.RenderStepped:Connect(function() -- Line: 129
            -- upvalues: Start (copy), HumanoidRootPart (ref), u4 (copy), u9 (copy), u12 (copy), u13 (ref), u17 (ref), u16 (ref), Debris (ref), VfxManager (ref), SfxManager (ref), u5 (copy), Ring (copy), HumanoidRootPart2 (copy)
            if not Start then
                return;
            end;

            local v18 = Start.Value:ToObjectSpace(HumanoidRootPart.CFrame);
            local v19, v20, v21 = v18:ToOrientation();
            local v22 = CFrame.new(-v18.X, v18.Y, v18.Z) * CFrame.fromOrientation(v19, -v20, -v21);

            if u4 and u4:IsDescendantOf(workspace) then
                local C0 = HumanoidRootPart.RootJoint.C0;
                local v23, v24, v25 = C0:ToOrientation();
                HumanoidRootPart.RootJoint.C0 = CFrame.new(HumanoidRootPart.RootJoint.C0.Position) * CFrame.fromOrientation(v23, -v24, -v25);

                for _, v in pairs(u5) do
                    v.Clone.CFrame = v.Character.CFrame;
                end;

                HumanoidRootPart.RootJoint.C0 = C0;
                local Position = (Start.Value * v22).Position;

                if Position.X > 153.542 then
                    Position = Vector3.new(153.542, Position.Y, Position.Z);
                elseif Position.X < -153.5825 then
                    Position = Vector3.new(-153.5825, Position.Y, Position.Z);
                end;

                if Position.Z > -206.319 then
                    Position = Vector3.new(Position.X, Position.Y, -206.319);
                elseif Position.Z < -388.706 then
                    Position = Vector3.new(Position.X, Position.Y, -388.706);
                end;

                u4:PivotTo(CFrame.new(Position) * CFrame.fromOrientation((Start.Value * v22):ToOrientation()));

                if u16 and Ring then
                    u16.CFrame = CFrame.new(HumanoidRootPart2.Position.X, 1, HumanoidRootPart2.Position.Z) * Ring.CFrame.Rotation;
                end;

                return;
            end;

            if u9 then
                u9:Disconnect();
            end;

            if u12 then
                u12:Disconnect();
            end;

            if u13 then
                u13:Disconnect();
            end;

            if u17 then
                u17:Disconnect();
            end;

            u16:Destroy();
            local v26 = script.Despawn:Clone();
            v26.Parent = Debris;
            v26.CFrame = Start.Value * v22;
            VfxManager.BetterEmit(v26);
            VfxManager.DestroyEffect(v26, 2);
            SfxManager:playSound({
                Sound = "BBZ Joker Trick Mirror Despawn",
                Parent = v26
            });
        end);
        local v27 = script.Spawn:Clone();
        v27.Parent = Debris;
        v27.CFrame = HumanoidRootPart.CFrame;
        VfxManager.BetterEmit(v27);
        VfxManager.DestroyEffect(v27, 4);
        SfxManager:playSound({
            Sound = "BBZ Joker Trick Mirror Spawn",
            Parent = v27
        });
        SfxManager:playSound({
            Sound = "BBZ Joker Trick Mirror Spawn Voice",
            Parent = v27
        });
    elseif p2.Task == "Stun" then
        local HumanoidRootPart2 = p2.Enemy:FindFirstChild("HumanoidRootPart");
        Effects:SubtitleV2({
            { v3, "Thats not me, silly! AHAHAHAHA", 3 }
        });
        local v28 = script.Stun:Clone();
        v28.Parent = Debris;
        v28.CFrame = HumanoidRootPart2.CFrame;
        VfxManager.BetterEmit(v28);
        VfxManager.DestroyEffect(v28, 5);
        SfxManager:playSound({
            Sound = "BBZ Joker Trick Mirror Stun",
            Parent = v28
        });
        SfxManager:playSound({
            Sound = "BBZ Joker Trick Mirror Stun Voice",
            Parent = HumanoidRootPart2
        });
    end;
end;