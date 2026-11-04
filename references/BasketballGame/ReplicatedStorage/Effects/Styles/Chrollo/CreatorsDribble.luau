 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "First" then
        SfxManager:playSound({
            Sound = "BBZ Chrollos Speed Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.283 - v3, function() -- Line: 28
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v4 = script.Dribble:Clone();
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v4.Parent = Debris;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 3);
            end;
        end);
        task.delay(0.5 - v3, function() -- Line: 38
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.Dribble:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end);
        task.delay(0.75 - v3, function() -- Line: 48
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v6 = script.Dribble:Clone();
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
            end;
        end);

        return;
    end;

    if p2.Task ~= "Second" then
        if p2.Task == "Layup" then
            SfxManager:playSound({
                Sound = "BBZ Chrollos Layup",
                Parent = HumanoidRootPart
            });
            task.delay(0.117 - v3, function() -- Line: 140
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v7 = script.StompEffect1:Clone();
                    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.4659737348556519, -3.0459206104278564, -0.8807296752929688) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v7.Parent = Debris;
                    VfxManager.Emit(v7);
                    VfxManager.DestroyEffect(v7, 3);
                end;
            end);
            task.delay(0.333 - v3, function() -- Line: 150
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v8 = script.StompEffect1:Clone();
                    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.050026535987854, -3.0459206104278564, -1.314727783203125) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v8.Parent = Debris;
                    VfxManager.Emit(v8);
                    VfxManager.DestroyEffect(v8, 3);
                end;
            end);
            task.delay(0.733 - v3, function() -- Line: 160
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v9 = script.Shoot:Clone();
                    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, 4.429873943328857, -0.8088531494140625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v9.Parent = Debris;
                    VfxManager.Emit(v9);
                    VfxManager.DestroyEffect(v9, 3);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Chrollos Drive",
        Parent = HumanoidRootPart
    });
    local u10 = script.Dash:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Debris;
    Essentials:Weld(u10.PrimaryPart, HumanoidRootPart);
    VfxManager.DestroyEffect(u10, 6);
    task.delay(0.1 - v3, function() -- Line: 69
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), TweenService (ref), u10 (copy)
        if HumanoidRootPart then
            local v11 = script.Dribble:Clone();
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v11.Parent = Debris;
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 3);
            local PointLight = v11.Light.PointLight;
            PointLight.Brightness = 5;
            TweenService:Create(PointLight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
            VfxManager.Enable(u10, true);
        end;
    end);
    task.delay(0.65 - v3, function() -- Line: 87
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), TweenService (ref)
        if HumanoidRootPart then
            local v12 = script.Dribble:Clone();
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v12.Parent = Debris;
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 3);
            local PointLight = v12.Light.PointLight;
            PointLight.Brightness = 5;
            TweenService:Create(PointLight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
        end;
    end);
    task.delay(1.117 - v3, function() -- Line: 101
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), TweenService (ref)
        if HumanoidRootPart then
            local v13 = script.Dribble:Clone();
            v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v13.Parent = Debris;
            VfxManager.Emit(v13);
            VfxManager.DestroyEffect(v13, 3);
            local PointLight = v13.Light.PointLight;
            PointLight.Brightness = 5;
            TweenService:Create(PointLight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
        end;
    end);
    task.delay(1.283 - v3, function() -- Line: 116
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), TweenService (ref), u10 (copy)
        if HumanoidRootPart then
            local v14 = script.Dribble:Clone();
            v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.8318557739257812) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v14.Parent = Debris;
            VfxManager.Emit(v14);
            VfxManager.DestroyEffect(v14, 3);
            local PointLight = v14.Light.PointLight;
            PointLight.Brightness = 5;
            TweenService:Create(PointLight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
        end;

        if u10 then
            VfxManager.Enable(u10, false);
            VfxManager.DestroyEffect(u10, 2);
        end;
    end);
end;