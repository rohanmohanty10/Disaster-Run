 
 

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
    Char:FindFirstChild("Head");
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Gold Handles",
            Parent = HumanoidRootPart
        });

        if Debris:FindFirstChild(v4) then
            Debris:FindFirstChild(v4):Destroy();
        end;

        local Folder = Instance.new("Folder");
        Folder.Name = v4;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        VfxManager.DestroyEffect(Folder, 10);
        local u5 = script.Dribble["Dribble Enable"]:Clone();
        u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4409942626953125, -0.5199217796325684, -1.4090652465820312) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        u5.Parent = Folder;
        VfxManager.Enable(u5, true);
        local u6 = script.Dribble["Dribble Startup"]:Clone();
        u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.19899749755859375, -2.461911201477051, -1.4090652465820312) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        u6.Parent = Folder;
        u6.Object3.Enabled = true;
        u6.Object4.Enabled = true;
        task.delay(0.083 - v3, function() -- Line: 52
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(0.667 - v3, function() -- Line: 58
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(1.15 - v3, function() -- Line: 64
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(1.567 - v3, function() -- Line: 70
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(2.367 - v3, function() -- Line: 76
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(2.85 - v3, function() -- Line: 82
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(3.383 - v3, function() -- Line: 88
            -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u6);
        end);
        task.delay(3.733 - v3, function() -- Line: 94
            -- upvalues: Folder (copy), VfxManager (ref), u5 (copy), u6 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u5, false);
            u6.Object3.Enabled = false;
            u6.Object4.Enabled = false;
            Folder:SetAttribute("Active", nil);
            Folder.Name = "_";
            VfxManager.DestroyEffect(Folder, 3);
        end);

        repeat
            task.wait(0.1);
            local v7 = Essentials:CreateClone(Char);
            VfxManager.DestroyEffect(v7, 1);
        until not (Char and (Char.Parent and (Folder ~= nil and (Folder.Parent ~= nil and Folder:GetAttribute("Active") ~= nil))));
    else
        if p2.Task == "Stepback" then
            SfxManager:playSound({
                Sound = "BBZ Gold Stepback",
                Parent = HumanoidRootPart
            });
            task.delay(0.25 - v3, function() -- Line: 113
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v8 = script.Stepback["Stepback Dirt"]:Clone();
                    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.8240013122558594, -2.5839126110076904, -3.349855422973633) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v8.Parent = Debris;
                    VfxManager.Emit(v8);
                    VfxManager.DestroyEffect(v8, 3);
                end;
            end);
            task.delay(0.35 - v3, function() -- Line: 123
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v9 = script.Stepback["Skip Back"]:Clone();
                    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.339996337890625, -2.4589123725891113, 1.7590065002441406) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, 1.5707963705062866, 0);
                    v9.Parent = Debris;
                    VfxManager.Emit(v9);
                    VfxManager.DestroyEffect(v9, 3);
                end;
            end);
            task.delay(0.933 - v3, function() -- Line: 133
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v10 = script.Stepback.Jump:Clone();
                    v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.1060028076171875, -2.796245574951172, 0.9502296447753906) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v10.Parent = Debris;
                    VfxManager.Emit(v10);
                    VfxManager.DestroyEffect(v10, 3);
                end;
            end);
            task.delay(1.217 - v3, function() -- Line: 143
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v11 = script.Stepback["Stepback Shoot"]:Clone();
                    v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.7666816711425781, 4.82650089263916, -1.1987895965576172) * CFrame.fromEulerAnglesYXZ(-0.785393238067627, 0, 3.1415927410125732);
                    v11.Parent = Debris;
                    VfxManager.Emit(v11);
                    VfxManager.DestroyEffect(v11, 3);
                end;
            end);

            return;
        end;

        if p2.Task == "Cleanup" then
            local v12 = HumanoidRootPart:FindFirstChild("BBZ Gold Handles");

            if v12 then
                v12.Name = "_";
                TweenService:Create(v12, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
                VfxManager.DestroyEffect(v12, 0.25);
            end;

            local v13 = Debris:FindFirstChild(v4);

            if v13 then
                v13:SetAttribute("Active", nil);
                v13.Name = "_";
                VfxManager.Enable(v13, false);
                VfxManager.DestroyEffect(v13, 3);
            end;
        end;
    end;
end;