  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 11
    -- upvalues: RunService (copy), VfxManager (copy), Debris (copy), TweenService (copy)
    local Char = p1.Char;
    local u2 = script.SidetoSide:Clone();
    u2:PivotTo(Char.HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    local u3 = RunService.Heartbeat:Connect(function() -- Line: 18
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame);
    end);
    task.delay(2, function() -- Line: 21
        -- upvalues: u2 (copy), u3 (ref)
        u2:Destroy();
        u3:Disconnect();
    end);
    task.spawn(function() -- Line: 26
        -- upvalues: VfxManager (ref), u2 (copy)
        for i = 1, 3 do
            VfxManager.Emit(u2);
            task.wait(0.35);
            local _ = i;
        end;
    end);
    local u4 = script.RinSimpleDomain:Clone();
    u4.Parent = workspace.Debris;
    VfxManager.Emit(u4);
    VfxManager.Enable(u4, true);
    local u5 = script.Cast:Clone();
    u5.CFrame = Char.HumanoidRootPart.CFrame;
    u5.Parent = workspace.Debris;
    VfxManager.Emit(u5);
    local u6 = script.Domain:Clone();
    u6.CFrame = Char.HumanoidRootPart.CFrame;
    u6.Anchored = true;
    u6.Parent = workspace.Debris;
    local u7 = script.amalgamationAura:Clone();
    u7.Parent = workspace.Debris;
    local u8 = game["Run Service"].Heartbeat:Connect(function() -- Line: 54
        -- upvalues: u4 (copy), Char (copy), u6 (copy), u7 (copy)
        u4.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        u6.Position = Char.HumanoidRootPart.Position;
        u7:PivotTo(u6.CFrame * CFrame.new(0, -2, 0));
    end);
    local os_clock_ret = os.clock();
    task.delay(6, function() -- Line: 62
        -- upvalues: Debris (ref), u6 (copy), u8 (ref), u4 (copy), u5 (copy)
        Debris:AddItem(u6);

        if u8 then
            u8:Disconnect();
        end;

        Debris:AddItem(u4);
        Debris:AddItem(u5);
    end);

    repeat
        task.wait();
    until Char:GetAttribute("DomainEnd") or os.clock() - os_clock_ret > 5;

    VfxManager.Enable(u4, false);
    TweenService:Create(u6, TweenInfo.new(0.5), {
        Transparency = 1
    }):Play();
    local TweenService2 = game:GetService("TweenService");
    (function(p9, p10) -- Line: 78, Name: TweenBeamsToZero
        -- upvalues: TweenService2 (copy)
        p9:GetDescendants();
        local TweenInfo_new_ret = TweenInfo.new(p10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);

        for _, descendant in p9:GetDescendants() do
            if descendant:IsA("Beam") then
                TweenService2:Create(descendant, TweenInfo_new_ret, {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end)(u7, 1);
    task.wait(1);
    u6:Destroy();
    u8:Disconnect();
    u4:Destroy();
    u5:Destroy();
end;