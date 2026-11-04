 
 

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

local function AttachMotor(p1, p2, p3, p4) -- Line: 14
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Part0 = p1;
    Motor6D.Part1 = p2;
    Motor6D.C1 = p4;
    Motor6D.C0 = p3;
    Motor6D.Parent = p2;
end;

return function(p5, p6) -- Line: 23
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy), Essentials (copy)
    local TimeSent = p6.TimeSent;
    local v7 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p6.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Torso = Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    local v8 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task == "Start" then
        SfxManager:playSound({
            Sound = "BBZ UncSam DecOfIndependence",
            Parent = HumanoidRootPart
        });
        local Folder = Instance.new("Folder");
        Folder.Name = v8;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        VfxManager.DestroyEffect(Folder, 10);
        local u9 = nil;
        local u10 = nil;
        VfxManager.DestroyEffect(u9, 10);
        VfxManager.DestroyEffect(u10, 10);
        task.delay(0.467 - v7, function() -- Line: 51
            -- upvalues: Folder (copy), HumanoidRootPart (copy), VfxManager (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            if HumanoidRootPart then
                local v11 = script.Hit:Clone();
                v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.2996322512626648, -2.0259315967559814, -3.77933931350708) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v11.Parent = Folder;
                VfxManager.Emit(v11);
                VfxManager.DestroyEffect(v11, 3);
            end;
        end);
        task.delay(0.817 - v7, function() -- Line: 64
            -- upvalues: Folder (copy), HumanoidRootPart (copy), u9 (ref), VfxManager (ref), u10 (ref), TweenService (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            if HumanoidRootPart then
                u9 = script.Enable:Clone();
                u9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.07852427661418915, -0.3627922534942627, -0.14179852604866028) * CFrame.fromEulerAnglesYXZ(-0.7368003129959106, 2.3885433673858643, 1.9832717180252075);
                u9.Parent = Folder;
                VfxManager.Enable(u9, true);
                u10 = script.RootPart:Clone();
                u10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.2529999017715454, 0.09943485260009766, -0.12799978256225586) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                u10.Parent = Folder;
                VfxManager.Enable(u10, true);
                TweenService:Create(u10, TweenInfo.new(0.333, Enum.EasingStyle.Linear), {
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.2529996335506439, 0.09943485260009766, -0.1280207633972168) * CFrame.fromEulerAnglesYXZ(-0, 3.130316972732544, 0)
                }):Play();
                task.delay(0.333, function() -- Line: 82
                    -- upvalues: u10 (ref), TweenService (ref), HumanoidRootPart (ref)
                    if u10 then
                        TweenService:Create(u10, TweenInfo.new(0.333, Enum.EasingStyle.Linear), {
                            CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.2529996633529663, 0.09943485260009766, -0.1280207633972168) * CFrame.fromEulerAnglesYXZ(-0, -0.023127617314457893, 0)
                        }):Play();
                    end;
                end);
            end;
        end);
        task.delay(1.15 - v7, function() -- Line: 91
            -- upvalues: Folder (copy), HumanoidRootPart (copy), VfxManager (ref), u9 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            if HumanoidRootPart then
                VfxManager.Enable(u9, false);
            end;
        end);
        task.delay(1.383 - v7, function() -- Line: 100
            -- upvalues: Folder (copy), HumanoidRootPart (copy), VfxManager (ref), u9 (ref), u10 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            if HumanoidRootPart then
                local v12 = script.BOOM:Clone();
                v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.694796085357666, -2.878868818283081, 0.9738736152648926) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v12.Parent = Folder;
                VfxManager.Emit(v12);
                VfxManager.DestroyEffect(v12, 3);
                VfxManager.Enable(u9, false);
                VfxManager.DestroyEffect(u9, 3);
                VfxManager.Enable(u10, false);
                VfxManager.DestroyEffect(u10, 3);
            end;
        end);

        return;
    end;

    if p6.Task ~= "Eagle Drive" then
        if p6.Task ~= "Dunk" then
            if p6.Task == "Star Shot" then
                SfxManager:playSound({
                    Sound = "BBZ UncSam CannonShot",
                    Parent = HumanoidRootPart
                }).PlaybackSpeed = 1.35;
                local v13 = Debris:FindFirstChild(v8);

                if v13 then
                    v13.Name = " ";
                    v13:SetAttribute("Active", nil);
                    VfxManager.Enable(v13, false);
                    VfxManager.DestroyEffect(v13, 3);
                end;

                task.delay(0.04962962962962963 - v7, function() -- Line: 253
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                    if HumanoidRootPart then
                        local v14 = script["Star Shot"].Emit:Clone();
                        v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6877961158752441, -2.878868818283081, -3.7561264038085938) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                        v14.Parent = Debris;
                        VfxManager.Emit(v14);
                        VfxManager.DestroyEffect(v14, 3);
                        local v15 = script["Star Shot"].Jump:Clone();
                        v15.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3833678066730499, -3.015932559967041, 1.533660650253296) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                        v15.Parent = Debris;
                        VfxManager.Emit(v15);
                        VfxManager.DestroyEffect(v15, 3);
                    end;
                end);
                task.delay(0.6296296296296295 - v7, function() -- Line: 270
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                    if HumanoidRootPart then
                        local v16 = script["Star Shot"].Dunk:Clone();
                        v16.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.27536776661872864, 5.967068672180176, -2.6303396224975586) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                        v16.Parent = Debris;
                        VfxManager.Emit(v16);
                        VfxManager.DestroyEffect(v16, 3);
                    end;
                end);
                task.delay(1.4318518518518517 - v7, function() -- Line: 282
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                    if HumanoidRootPart then
                        local v17 = script["Star Shot"].Recoil:Clone();
                        v17.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6877961158752441, -2.878868818283081, 3.4878742694854736) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                        v17.Parent = Debris;
                        VfxManager.Emit(v17);
                        VfxManager.DestroyEffect(v17, 3);
                        local v18 = script["Star Shot"].Hit:Clone();
                        v18.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.34703144431114197, 6.133684158325195, -6.741860866546631) * CFrame.fromEulerAnglesYXZ(0.9597609043121338, 3.0608389377593994, 3.1392133235931396);
                        v18.Parent = Debris;
                        VfxManager.Emit(v18);
                        VfxManager.DestroyEffect(v18, 3);
                    end;
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ UncSam EagleDrive P2",
            Parent = HumanoidRootPart
        });
        local v19 = Debris:FindFirstChild(v8);

        if v19 then
            v19.Name = " ";
            v19:SetAttribute("Active", nil);
            VfxManager.Enable(v19, false);
            VfxManager.DestroyEffect(v19, 3);
        end;

        local v20 = script.Eagle.Jump:Clone();
        v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.1273677945137024, -0.5999321937561035, 0.39166057109832764) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v20.Parent = Debris;
        VfxManager.Emit(v20);
        VfxManager.DestroyEffect(v20, 3);
        task.delay(0.52 - v7, function() -- Line: 222
            -- upvalues: HumanoidRootPart (copy), Char (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local Name = game.Players:GetPlayerFromCharacter(Char).Team.Name;
                local Hoop = workspace.Hoops.Home.Hoop;

                if Name == "Away" then
                    Hoop = workspace.Hoops.Away.Hoop;
                end;

                local v21 = script.Eagle.Blast:Clone();
                v21.CFrame = Hoop.CFrame;
                v21.Parent = Debris;
                VfxManager.Emit(v21);
                VfxManager.DestroyEffect(v21, 3);
            end;
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Sam Drive",
        Parent = HumanoidRootPart
    });
    local v22 = Debris:FindFirstChild(v8);

    if v22 then
        v22.Name = " ";
        v22:SetAttribute("Active", nil);
        VfxManager.Enable(v22, false);
        VfxManager.DestroyEffect(v22, 3);
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    VfxManager.DestroyEffect(Folder, 10);
    local u23 = nil;
    local u24 = nil;
    VfxManager.DestroyEffect(u23, 10);
    VfxManager.DestroyEffect(u24, 10);
    task.delay(0.05 - v7, function() -- Line: 142
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v25 = script.Eagle.Emit:Clone();
            v25.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6877961158752441, -2.878868818283081, 31.85587501525879) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v25.Parent = Debris;
            VfxManager.Emit(v25);
            VfxManager.DestroyEffect(v25, 3);
        end;
    end);
    task.delay(0.217 - v7, function() -- Line: 152
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v26 = script.Eagle.Throw:Clone();
            v26.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.24536752700805664, 3.255068778991699, -1.0923395156860352) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v26.Parent = Debris;
            VfxManager.Emit(v26);
            VfxManager.DestroyEffect(v26, 3);
        end;
    end);
    task.delay(0.717 - v7, function() -- Line: 162
        -- upvalues: HumanoidRootPart (copy), u23 (ref), Folder (copy), VfxManager (ref), Essentials (ref), Torso (copy), u24 (ref)
        if HumanoidRootPart then
            u23 = script.Eagle.Enable:Clone();
            u23.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.1084766834974289, 0.33478403091430664, 0.2964567542076111) * CFrame.fromEulerAnglesYXZ(-1.260619878768921, -1.2217295169830322, 3.118516206741333);
            u23.Parent = Folder;
            VfxManager.Enable(u23, true);
            Essentials:Weld(u23, Torso);
            u24 = script.Eagle.RootPart:Clone();
            u24.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.2529999017715454, 0.09943485260009766, -0.12799978256225586) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            u24.Parent = Folder;
            VfxManager.Enable(u24, true);
            Essentials:Weld(u24, Torso);
        end;
    end);
    task.delay(1.183 - v7, function() -- Line: 181
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), Folder (copy), Essentials (ref), u23 (ref), u24 (ref)
        if HumanoidRootPart then
            local v27 = script.Eagle.Jump:Clone();
            v27.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.1273677945137024, -0.5999321937561035, 0.39166057109832764) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v27.Parent = Debris;
            VfxManager.Emit(v27);
            VfxManager.DestroyEffect(v27, 3);
            local v28 = script.Eagle.Flight:Clone();
            v28:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.12478125095367432, -1.8049761056900024, 0.7034180164337158) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
            v28.Parent = Folder;
            VfxManager.Enable(v28, true);
            Essentials:Weld(v28.Root, HumanoidRootPart);
            VfxManager.Enable(u23, false);
            VfxManager.DestroyEffect(u23, 3);
            VfxManager.Enable(u24, false);
            VfxManager.DestroyEffect(u24, 3);
        end;
    end);
end;