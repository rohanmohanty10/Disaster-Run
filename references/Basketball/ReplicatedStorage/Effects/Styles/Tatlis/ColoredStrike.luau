 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Network = require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), RunService (copy), Network (copy)
    local BallController = p1.BallController;
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local v4 = Char:FindFirstChild("Left Arm");
    local Head = Char:FindFirstChild("Head");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Striking" then
        if p2.Task == "Dash" then
            local u5 = script.Strike.EnableonRootPart:Clone();
            u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.32151031494140625, -2.991934299468994, 0.3302154541015625) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            u5.Parent = Debris;
            Essentials:Weld(u5, HumanoidRootPart);
            local u6 = script.HeadFX:Clone();
            u6.CFrame = Head.CFrame;
            u6.Parent = Debris;
            VfxManager.Enable(u6, true);
            task.delay(0.267 - v3, function() -- Line: 186
                -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u5 (copy), Debris (ref)
                if HumanoidRootPart then
                    VfxManager.Enable(u5, true);
                    local v7 = script.Strike.StartupImpact:Clone();
                    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.39920711517333984, -0.6410658359527588, 0.23626708984375) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                    v7.Parent = Debris;
                    VfxManager.Emit(v7);
                    VfxManager.DestroyEffect(v7, 3);
                end;
            end);
            task.delay(1.25 - v3, function() -- Line: 198
                -- upvalues: VfxManager (ref), u6 (copy), u5 (copy)
                VfxManager.Enable(u6, false);
                VfxManager.Enable(u5, false);
                VfxManager.DestroyEffect(u6, 3);
                VfxManager.DestroyEffect(u5, 3);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Tatlis paintbrush",
        Parent = HumanoidRootPart
    });
    local u8 = nil;
    local Folder = Instance.new("Folder");
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3.846153846153846, function() -- Line: 38
        -- upvalues: Folder (copy), VfxManager (ref)
        if Folder then
            if not Folder:GetAttribute("Active") then
                return;
            end;

            Folder:SetAttribute("Active", nil);
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 5);
        end;
    end);
    local v9 = script.Strike.PaintBrush:Clone();
    v9.CFrame = v4.CFrame * CFrame.new(0.04989278316497803, -1, -0.8757171630859375) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, -0, 0);
    v9.Parent = Folder;
    VfxManager.Enable(v9, true);
    Essentials:Weld(v9, v4);
    local u10 = script.Strike.Trail:Clone();
    u10.CFrame = v9.CFrame * CFrame.new(0.006587624549865723, 2.0133819580078125, -0.10509562492370605) * CFrame.fromEulerAnglesYXZ(1.5707963705062866, 0, 0);
    u10.Parent = Folder;
    Essentials:Weld(u10, v9);
    local u11 = script.Strike.EnableonRootPart:Clone();
    u11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.32151031494140625, -2.991934299468994, 0.3302154541015625) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    u11.Parent = Folder;
    Essentials:Weld(u11, HumanoidRootPart);
    task.delay(0.3459259259259259 - v3, function() -- Line: 64
        -- upvalues: Folder (copy), HumanoidRootPart (copy), VfxManager (ref), u10 (copy), u11 (copy), Debris (ref)
        if Folder:GetAttribute("Active") and HumanoidRootPart ~= nil then
            VfxManager.Enable(u10, true);
            VfxManager.Enable(u11, true);
            local v12 = script.Strike.StartupImpact:Clone();
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.39920711517333984, -0.6410658359527588, 0.23626708984375) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v12.Parent = Debris;
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 3);
        end;
    end);
    task.delay(1.0866666666666667 - v3, function() -- Line: 78
        -- upvalues: Folder (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if Folder:GetAttribute("Active") and HumanoidRootPart ~= nil then
            local v13 = script.Strike.Hit:Clone();
            v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4622396230697632, 0.3850212097167969, -3.819580078125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v13.Parent = Debris;
            VfxManager.Emit(v13);
            VfxManager.DestroyEffect(v13, 3);
        end;
    end);
    task.delay(1.3459259259259257 - v3, function() -- Line: 88
        -- upvalues: Folder (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if Folder:GetAttribute("Active") and HumanoidRootPart ~= nil then
            local v14 = script.Strike.Hit:Clone();
            v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4622396230697632, 0.3850212097167969, -3.819580078125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v14.Parent = Debris;
            VfxManager.Emit(v14);
            VfxManager.DestroyEffect(v14, 3);
        end;
    end);
    task.delay(1.6666666666666665 - v3, function() -- Line: 99
        -- upvalues: Folder (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if Folder:GetAttribute("Active") and HumanoidRootPart ~= nil then
            local v15 = script.Strike.Hit:Clone();
            v15.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4622396230697632, 0.3850212097167969, -3.819580078125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v15.Parent = Debris;
            VfxManager.Emit(v15);
            VfxManager.DestroyEffect(v15, 3);
        end;
    end);
    task.delay(2.172592592592592 - v3, function() -- Line: 111
        -- upvalues: Folder (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if Folder:GetAttribute("Active") and HumanoidRootPart ~= nil then
            local v16 = script.Strike.BigHit:Clone();
            v16.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4622396230697632, 0.3850212097167969, -6.1746368408203125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v16.Parent = Debris;
            VfxManager.Emit(v16);
            VfxManager.DestroyEffect(v16, 3);
        end;
    end);
    task.delay(3.32074074074074 - v3, function() -- Line: 123
        -- upvalues: Folder (copy), HumanoidRootPart (copy), VfxManager (ref), Debris (ref), u8 (ref)
        if Folder:GetAttribute("Active") and HumanoidRootPart ~= nil then
            Folder:SetAttribute("Active", nil);
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 5);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;

            local v17 = script.Strike.BigHit2:Clone();
            v17.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4622400999069214, 0.3850212097167969, -6.1746368408203125) * CFrame.fromEulerAnglesYXZ(-0, 0, -0.33271852135658264);
            v17.Parent = Debris;
            VfxManager.Emit(v17);
            VfxManager.DestroyEffect(v17, 3);
        end;

        if u8 then
            u8:Disconnect();
        end;
    end);
    u8 = RunService.RenderStepped:Connect(function() -- Line: 149
        -- upvalues: BallController (copy), Char (copy), Network (ref), u8 (ref), Folder (copy), VfxManager (ref)
        if BallController:GetCharacterPossessingBall() ~= Char and not Network.CharValues.Stunned then
            return;
        end;

        if u8 then
            u8:Disconnect();
        end;

        Folder:SetAttribute("Active", nil);
        VfxManager.Enable(Folder, false);
        VfxManager.DestroyEffect(Folder, 5);

        for _, descendant in Folder:GetDescendants() do
            if descendant:IsA("Part") or descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
            end;
        end;
    end);
end;