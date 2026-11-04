 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Players (copy), Essentials (copy), TweenService (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dunk" then
        if p2.Task ~= "Layup" then
            if p2.Task == "Zone" then
                local Highlight = Instance.new("Highlight", Character);
                Highlight.Name = script.Name .. "Highlight";
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = Color3.fromRGB(119, 255, 78);
                Highlight.OutlineTransparency = 0;
                Highlight.FillTransparency = 1;
                VfxManager.DestroyEffect(Highlight, 15);
                local v4 = script.Zone:Clone();
                v4.Name = Character.Name .. script.Name .. "Zone";
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v4, HumanoidRootPart);
                TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 0
                }):Play();
                SfxManager:playSound({
                    Sound = "BBZ Alien The Reach Zone",
                    Parent = v4
                });
                SfxManager:playSound({
                    Sound = "BBZ Alien The Reach Start",
                    Parent = HumanoidRootPart
                });
                task.wait(0.25);

                if LocalPlayer.Character ~= Character then
                    TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();

                    return;
                end;

                VfxManager.DestroyEffect(v4, 15);
                TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(35, 35, 35)
                }):Play();

                while v4 and v4:IsDescendantOf(Debris) do
                    TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 0.75
                    }):Play();
                    task.wait(0.5);
                    TweenService:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Transparency = 0
                    }):Play();
                    task.wait(0.5);
                end;
            elseif p2.Task == "Cleanup" then
                local v5 = Character:FindFirstChild(script.Name .. "Highlight");

                if v5 then
                    v5:Destroy();
                end;

                local v6 = Debris:FindFirstChild(Character.Name .. script.Name .. "Zone");

                if v6 then
                    local v7 = v6:Clone();
                    v7.Parent = Debris;
                    TweenService:Create(v7, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                    VfxManager.DestroyEffect(v7, 0.25);
                    local v8 = v7:FindFirstChildOfClass("Sound");

                    if v8 then
                        v8:Destroy();
                    end;

                    local v9 = v6:FindFirstChildOfClass("Sound");

                    if v9 then
                        v9.Parent = v7;
                        TweenService:Create(v9, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Volume = 0
                        }):Play();
                    end;

                    v6:Destroy();
                    SfxManager:playSound({
                        Sound = "BBZ Alien The Reach End",
                        Parent = HumanoidRootPart
                    });
                end;
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Alien Layup",
            Parent = HumanoidRootPart
        });
        task.delay(0.4 - v3, function() -- Line: 58
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v10 = script.Shoot:Clone();
            v10.Parent = Debris;
            v10.CFrame = CFrame.new(BALL.Position);
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 6);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Alien Dunk",
        Parent = HumanoidRootPart
    });
    task.delay(0.2 - v3, function() -- Line: 29
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v11 = script.Jump1:Clone();
        v11.Parent = Debris;
        v11.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.1, HumanoidRootPart.Position.Z);
        VfxManager.BetterEmit(v11);
        VfxManager.DestroyEffect(v11, 4);
    end);
    task.delay(0.8166666666666667 - v3, function() -- Line: 37
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v12 = script.Jump2:Clone();
        v12.Parent = Debris;
        v12.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.1, HumanoidRootPart.Position.Z);
        VfxManager.BetterEmit(v12);
        VfxManager.DestroyEffect(v12, 4);
    end);
    task.delay(1.2 - v3, function() -- Line: 45
        -- upvalues: Players (ref), Character (copy), Debris (ref), VfxManager (ref)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

        if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
            local v13 = script.Shoot:Clone();
            v13.Parent = Debris;
            v13.CFrame = CFrame.new(workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position);
            VfxManager.Emit(v13);
            VfxManager.DestroyEffect(v13, 6);
        end;
    end);
end;