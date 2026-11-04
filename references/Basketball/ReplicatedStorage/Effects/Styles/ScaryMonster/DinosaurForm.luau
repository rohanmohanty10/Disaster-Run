 
 

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
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.HasBall then
        local v4 = Character:FindFirstChild(script.Name .. "Tail");
        SfxManager:playSound({
            Sound = "BBZ Scary Monster Tail Form",
            Parent = HumanoidRootPart
        });
        task.delay(0.23333333333333334 - v3, function() -- Line: 32
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), BALL (copy)
            local v5 = script.Spawn:Clone();
            v5.Parent = Debris;
            v5:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v5, 4);
            local v6 = script.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v5, v6);
        end);
        task.delay(0.6333333333333333 - v3, function() -- Line: 46
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v7 = script.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v7, 2);
            shared.vfx.emit(v7);
        end);
        local v8 = SfxManager:playSound({
            Sound = "BBZ Scary Monster Form",
            Parent = HumanoidRootPart
        });

        while v4 and v4.Parent do
            task.wait();
        end;

        if v8 and v8.Parent then
            TweenService:Create(v8, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
            VfxManager.DestroyEffect(v8, 0.25);
        end;
    else
        local u9 = Character:FindFirstChild(script.Name .. "Dinosaur");

        if p2.Task == "Transform" then
            SfxManager:playSound({
                Sound = "BBZ Scary Monster Dinosaur Form",
                Parent = HumanoidRootPart
            });
            local v10 = script.Transform:Clone();
            v10.Parent = Debris;
            v10:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v10, 4);
            shared.vfx.emit(v10);
            Essentials:HideCharacter(Character, u9 and ({ u9.PrimaryPart } or {}) or {}, nil, 0);
            task.delay(3 - v3, function() -- Line: 80
                -- upvalues: u9 (copy), Essentials (ref), Character (copy)
                if u9 then
                    u9:Destroy();
                end;

                Essentials:UnhideCharacter(Character, {});
            end);
            local v11 = SfxManager:playSound({
                Sound = "BBZ Scary Monster Form",
                Parent = HumanoidRootPart
            });
            local v12 = SfxManager:playSound({
                Sound = "BBZ Scary Monster Dinosaur Form Run",
                Parent = HumanoidRootPart
            });

            while u9 and u9.Parent do
                task.wait();
            end;

            if v11 and v11.Parent then
                TweenService:Create(v11, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
                VfxManager.DestroyEffect(v11, 0.25);
            end;

            if v12 and v12.Parent then
                TweenService:Create(v12, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
                VfxManager.DestroyEffect(v12, 0.25);
            end;
        else
            if p2.Task == "Roar" then
                SfxManager:playSound({
                    Sound = "BBZ Scary Monster Dinosaur Form Roar",
                    Parent = HumanoidRootPart
                });

                return;
            end;

            if p2.Task == "Cleanup" then
                SfxManager:playSound({
                    Sound = "BBZ Scary Monster Dinosaur Form",
                    Parent = HumanoidRootPart
                });

                if u9 then
                    u9:Destroy();
                end;

                Essentials:UnhideCharacter(Character, {});
                local v13 = script.Transform:Clone();
                v13.Parent = Debris;
                v13:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v13, 4);
                shared.vfx.emit(v13);
            end;
        end;
    end;
end;