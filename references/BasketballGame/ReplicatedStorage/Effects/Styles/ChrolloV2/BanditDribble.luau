 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), LocalPlayer (copy), DarkScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Chrollo V2 Bandit Dribble",
            Parent = HumanoidRootPart
        });
        local u4 = script.Dribble.Aura:Clone();
        u4.Parent = Debris;
        u4.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u4, HumanoidRootPart);
        task.delay(0.15, function() -- Line: 37
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v5 = script.Dribble.Bounce:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v5, 2);
            shared.vfx.emit(v5);
        end);
        task.delay(0.5, function() -- Line: 46
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v6 = script.Dribble.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v6);
        end);
        task.delay(0.8166666666666667 - v3, function() -- Line: 55
            -- upvalues: VfxManager (ref), u4 (copy), LocalPlayer (ref), Character (copy), DarkScreenEffect (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy), Essentials (ref)
            VfxManager.Enable(u4, false);
            VfxManager.DestroyEffect(u4, 2);

            if LocalPlayer.Character == Character then
                DarkScreenEffect();
            end;

            local v7 = script.Dribble.BounceSlash:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v7, 2);
            local v8 = script.Dribble.Slash:Clone();
            v8.Parent = Debris;
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            Essentials:Weld(v8, HumanoidRootPart);
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v7, v8);
        end);
        task.delay(0.5833333333333334 - v3, function() -- Line: 77
            -- upvalues: Essentials (ref), Character (copy), VfxManager (ref)
            local v9 = tick();

            repeat
                task.wait(0.05 * (1 + (tick() - v9) / 0.4166666666666667));
                local v10 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v10, 1);
            until tick() - v9 > 0.4166666666666667;
        end);

        return;
    end;

    if p2.Task == "Dribble Spin" then
        SfxManager:playSound({
            Sound = "BBZ Chrollo V2 Bandit Dribble Spin",
            Parent = HumanoidRootPart
        });
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.DribbleSpin.AuraBodyPartsToWeld:GetChildren()) do
            local v11 = Character:FindFirstChild(child.Name);

            if v11 then
                local v12 = child:Clone();
                v12.CFrame = v11.CFrame;
                v12.Parent = Model;
                Essentials:Weld(v12, v11);
            end;
        end;

        shared.vfx.emit(Model);
        task.delay(0.3 - v3, function() -- Line: 102
            -- upvalues: LocalPlayer (ref), Character (copy), Other (copy), DarkScreenEffect (ref), Debris (ref), VfxManager (ref), HumanoidRootPart (copy), Essentials (ref)
            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                DarkScreenEffect();
                local v13 = script.DribbleSpin.CameraFX:Clone();
                v13.Parent = Debris;
                VfxManager.DestroyEffect(v13, 2);
                shared.vfx.emit(v13);
            end;

            local v14 = script.DribbleSpin.Throw:Clone();
            v14.Parent = Debris;
            v14:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v14, 2);
            shared.vfx.emit(v14);
            local v15 = tick();

            repeat
                task.wait(0.1);
                local v16 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v16, 1);
            until tick() - v15 > 0.5;
        end);
        task.delay(0.75 - v3, function() -- Line: 127
            -- upvalues: VfxManager (ref), Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), Essentials (ref)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
            local v17 = script.DribbleSpin.BounceSlash:Clone();
            v17.Parent = Debris;
            v17:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v17, 2);
            local v18 = script.DribbleSpin.Slash:Clone();
            v18.Parent = Debris;
            v18.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            Essentials:Weld(v18, HumanoidRootPart);
            VfxManager.DestroyEffect(v18, 2);
            shared.vfx.emit(v17, v18);
        end);

        return;
    end;

    if p2.Task ~= "Cut" then
        if p2.Task == "Cut Back" then
            SfxManager:playSound({
                Sound = "BBZ Chrollo V2 Cut Back",
                Parent = HumanoidRootPart
            });
            local v19 = Debris:FindFirstChild(Character.Name .. script.Name .. "Rush");

            if v19 then
                VfxManager.Enable(v19, false);
            end;

            if LocalPlayer.Character == Character then
                DarkScreenEffect();
            end;

            task.wait(0.31666666666666665 - v3);
            local v20 = script.Cut.FlashStep:Clone();
            v20.Parent = Debris;
            v20.CFrame = HumanoidRootPart.CFrame;
            VfxManager.DestroyEffect(v20, 2);
            shared.vfx.emit(v20);
            local v21 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v21, 1);
            Essentials:HideCharacter(Character, {});
            task.wait(0.5);
            Essentials:UnhideCharacter(Character, {});

            if LocalPlayer.Character == Character then
                DarkScreenEffect();
            end;

            local v22 = script.Cut.FlashStep:Clone();
            v22.Parent = Debris;
            v22.CFrame = CFrame.new(p2.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            VfxManager.DestroyEffect(v22, 2);
            shared.vfx.emit(v22);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Chrollo V2 Bandit\'s Cut",
        Parent = HumanoidRootPart
    });
    local v23 = script.Cut.Rush:Clone();
    v23.Name = Character.Name .. script.Name .. "Rush";
    v23.Parent = Debris;
    v23:PivotTo(HumanoidRootPart.CFrame);
    Essentials:Weld(v23.PrimaryPart, HumanoidRootPart);
    VfxManager.DestroyEffect(v23, 2);
    shared.vfx.emit(v23);
end;