 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris2 = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris2 (copy), VfxManager (copy), Essentials (copy), Debris (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Dribbling" then
        SfxManager:playSound({
            Sound = "BBZ perfect dribble",
            Parent = HumanoidRootPart
        }).TimePosition = 0.4;
        local v4 = script.Dribbling.FirstDribble:Clone();
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.18012619018554688, -2.8731839656829834, -0.72607421875) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v4.Parent = Debris2;
        VfxManager.Emit(v4);
        VfxManager.DestroyEffect(v4, 2);
        task.delay(0.233 - v3, function() -- Line: 36
            -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref), Essentials (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v5 = script.Dribbling.Enable:Clone();
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6990280151367188, 1.4070186614990234, 0.0337371826171875) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, -0, 0);
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            Highlight.FillColor = Color3.new(1, 0, 0);
            Highlight.FillTransparency = 0.5;
            Highlight.OutlineColor = Color3.new(1, 1, 1);
            Highlight.OutlineTransparency = 0;
            Highlight.Parent = v5;
            v5.Parent = Debris2;
            VfxManager.Enable(v5, true);
            Essentials:Weld(v5, HumanoidRootPart);
            task.wait(0.4);

            if v5 then
                VfxManager.Enable(v5, false);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end);
        task.delay(0.367 - v3, function() -- Line: 62
            -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref)
            local v6 = script.Dribbling.Dribble:Clone();
            v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.9498748779296875, -2.8731839656829834, -3.636077880859375) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v6.Parent = Debris2;
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);

        return;
    end;

    if p2.Task ~= "Euro" then
        if p2.Task ~= "Dunk" then
            if p2.Task == "Fadeaway" then
                SfxManager:playSound({
                    Sound = "BBZ perfect spin shot base",
                    Parent = HumanoidRootPart
                }).TimePosition = 0.7;
                local u7 = script.Fadeaway.Enable:Clone();
                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                Highlight.FillColor = Color3.new(1, 0, 0);
                Highlight.FillTransparency = 0.5;
                Highlight.OutlineColor = Color3.new(1, 1, 1);
                Highlight.OutlineTransparency = 0;
                Highlight.Parent = u7;
                u7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6990280151367188, 1.4070186614990234, 0.0337371826171875) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, -0, 0);
                u7.Parent = Debris2;
                VfxManager.DestroyEffect(u7, 3);
                VfxManager.Enable(u7, true);
                Essentials:Weld(u7, HumanoidRootPart);

                if HumanoidRootPart.Parent == nil then
                    return;
                end;

                local v8 = script.Fadeaway.Jump:Clone();
                v8:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
                v8.Parent = Debris2;
                VfxManager.Emit(v8);
                VfxManager.DestroyEffect(v8, 2);
                task.delay(0.383 - v3, function() -- Line: 181
                    -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref), u7 (copy), Debris (ref)
                    if HumanoidRootPart.Parent == nil then
                        return;
                    end;

                    local v9 = script.Fadeaway.Release:Clone();
                    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.28606414794921875, 4.669114589691162, 0.8605880737304688) * CFrame.fromEulerAnglesYXZ(0.5759586691856384, 0, 0);
                    v9.Parent = Debris2;
                    VfxManager.Emit(v9);
                    VfxManager.DestroyEffect(v9, 2);
                    task.wait(0.1);

                    if u7 then
                        VfxManager.Enable(u7, false);
                        Debris:AddItem(u7, 2);
                    end;
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ perfect dunk base move",
            Parent = HumanoidRootPart
        });
        local v10 = script.Dunk.Jump:Clone();
        v10:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
        v10.Parent = Debris2;
        VfxManager.Emit(v10);
        VfxManager.DestroyEffect(v10, 2);
        task.delay(0.717 - v3, function() -- Line: 121
            -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v11 = HumanoidRootPart.CFrame * CFrame.new(-0.8473701477050781, 3.402688503265381, -1.4903182983398438) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            local Hoops = workspace:FindFirstChild("Hoops");

            if Hoops then
                local Hoop = Hoops.Away.Hoop;
                local Hoop2 = Hoops.Home.Hoop;

                if Hoop and Hoop2 then
                    local Magnitude = (HumanoidRootPart.Position - Hoop.Position).Magnitude;
                    local Magnitude2 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude;

                    if Magnitude2 < Magnitude then
                        v11 = Hoop2.CFrame;
                    elseif Magnitude < Magnitude2 then
                        v11 = Hoop.CFrame;
                    end;
                end;
            end;

            local v12 = script.Dunk.shoot:Clone();
            v12.CFrame = v11;
            v12.Parent = Debris2;
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 2);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ perfect layup",
        Parent = HumanoidRootPart
    });
    local v13 = script.Euro.FirstDribble:Clone();
    v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.1801605224609375, -2.8731839656829834, -0.02066802978515625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
    v13.Parent = Debris2;
    VfxManager.Emit(v13);
    VfxManager.DestroyEffect(v13, 2);
    task.delay(0.317, function() -- Line: 80
        -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref)
        if HumanoidRootPart.Parent == nil then
            return;
        end;

        local v14 = script.Euro.Second:Clone();
        v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.2406959533691406, -2.8731839656829834, -1.2530975341796875) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v14.Parent = Debris2;
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 2);
    end);
    task.delay(0.483, function() -- Line: 89
        -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref)
        if HumanoidRootPart.Parent == nil then
            return;
        end;

        local v15 = script.Euro.Jump:Clone();
        v15:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
        v15.Parent = Debris2;
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 2);
    end);
    task.delay(0.983, function() -- Line: 98
        -- upvalues: HumanoidRootPart (copy), Debris2 (ref), VfxManager (ref)
        if HumanoidRootPart.Parent == nil then
            return;
        end;

        local v16 = script.Euro.shoot:Clone();
        v16:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.8473777770996094, 5.991437911987305, -2.818359375) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
        v16.Parent = Debris2;
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 2);
    end);
end;