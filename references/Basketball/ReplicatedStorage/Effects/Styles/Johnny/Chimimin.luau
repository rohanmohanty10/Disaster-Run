 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy), Essentials (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Tusk = Character:FindFirstChild("Tusk");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "Zone" then
            if p2.Task == "Cleanup" then
                local v3 = Debris:FindFirstChild(Character.Name .. script.Name .. "Zone");

                if v3 then
                    v3:Destroy();

                    return;
                end;
            elseif p2.Task == "Defense" then
                if not Tusk then
                    return;
                end;

                local v4 = script.Block:Clone();
                v4.Parent = Debris;
                v4.CFrame = Tusk.PrimaryPart.CFrame * CFrame.new(0, 0, 3.5);
                Essentials:Weld(v4, Tusk.PrimaryPart);
                VfxManager.BetterEmit(v4);
                VfxManager.DestroyEffect(v4, 4);
            end;

            return;
        end;

        if Tusk then
            SfxManager:playSound({
                Sound = "BBZ Johnny Chimimin",
                Parent = Tusk
            });
            local Highlight = Instance.new("Highlight", Tusk);
            Highlight.Name = script.Name .. "Highlight";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 0;
            TweenService:Create(Highlight, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine), {
                FillTransparency = 1,
                OutlineColor = Color3.fromRGB(0, 0, 0)
            }):Play();
        end;

        local v5 = script.Zone:Clone();
        v5.Name = Character.Name .. script.Name .. "Zone";
        v5.Parent = Debris;
        v5.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v5, HumanoidRootPart);
        TweenService:Create(v5, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
        task.wait(0.25);

        if LocalPlayer.Character == Character then
            VfxManager.DestroyEffect(v5, 5);
            TweenService:Create(v5, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(75, 75, 75)
            }):Play();

            return;
        end;

        VfxManager.DestroyEffect(v5, 0.5);
        TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Johnny Tusk Dribble",
        Parent = HumanoidRootPart
    });
    local v6 = script.Summon:Clone();
    v6.Parent = Debris;
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 3);
    VfxManager.BetterEmit(v6);
    VfxManager.DestroyEffect(v6, 4);
    local v7 = script.Wormhole:Clone();
    v7.Parent = Debris;
    v7:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 5));
    VfxManager.BetterEmit(v7);
    VfxManager.DestroyEffect(v7, 4);
    task.delay(1.4666666666666666, function() -- Line: 41
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v8 = script.StandBounce:Clone();
        v8.Parent = Debris;
        v8.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v8);
        VfxManager.DestroyEffect(v8, 4);
    end);
    task.delay(2, function() -- Line: 49
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v9 = script.StandBounce:Clone();
        v9.Parent = Debris;
        v9.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v9);
        VfxManager.DestroyEffect(v9, 4);
    end);
    task.delay(2.216666666666667, function() -- Line: 57
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v10 = script.Spin:Clone();
        v10.Parent = Debris;
        v10:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -6.5));
        VfxManager.BetterEmit(v10);
        VfxManager.DestroyEffect(v10, 2);
    end);
    task.delay(2.3833333333333333, function() -- Line: 65
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v11 = script.Throw1:Clone();
        v11.Parent = Debris;
        v11.CFrame = CFrame.new(BALL.Position, HumanoidRootPart.Position) * CFrame.Angles(-1.5707963267948966, 0, 0);
        VfxManager.BetterEmit(v11);
        VfxManager.DestroyEffect(v11, 4);
    end);
    task.delay(2.8333333333333335, function() -- Line: 73
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v12 = script.Bounce:Clone();
        v12.Parent = Debris;
        v12.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v12);
        VfxManager.DestroyEffect(v12, 4);
    end);
    task.delay(3.3833333333333333, function() -- Line: 81
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v13 = script.Bounce:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v13);
        VfxManager.DestroyEffect(v13, 4);
    end);
    task.delay(4.183333333333334, function() -- Line: 89
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v14 = script.Throw2:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(CFrame.new(HumanoidRootPart.Position, BALL.Position):ToOrientation()) * CFrame.Angles(-1.5707963267948966, 0, 0);
        VfxManager.BetterEmit(v14);
        VfxManager.DestroyEffect(v14, 4);
    end);
    task.delay(4.6, function() -- Line: 97
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v15 = script.Throw3:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        VfxManager.BetterEmit(v15);
        VfxManager.DestroyEffect(v15, 4);
    end);
    task.delay(5.2, function() -- Line: 105
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v16 = script.Wormhole:Clone();
        v16.Parent = Debris;
        v16:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 5));
        VfxManager.BetterEmit(v16);
        VfxManager.DestroyEffect(v16, 4);
    end);
end;