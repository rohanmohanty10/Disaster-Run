  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

function Emit_All_With_Duration(p1)
    local function emit(u2) -- Line: 14
        if u2:IsA("ParticleEmitter") or (u2:IsA("Beam") or u2:IsA("Trail")) then
            local Attribute = u2:GetAttribute("EmitDuration");
            local Attribute2 = u2:GetAttribute("EmitDelay");
            local Attribute3 = u2:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 22
                        -- upvalues: u2 (copy), Attribute (copy)
                        u2.Enabled = true;
                        task.delay(Attribute, function() -- Line: 25
                            -- upvalues: u2 (ref)
                            u2.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u2.Enabled = true;
                task.delay(Attribute, function() -- Line: 32
                    -- upvalues: u2 (copy)
                    u2.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 39
                        -- upvalues: u2 (copy), Attribute3 (copy)
                        u2:Emit(Attribute3);
                    end);

                    return;
                end;

                u2:Emit(Attribute3);
            end;
        end;
    end;

    if typeof(p1) == "table" then
        for _, v in p1 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p1:IsA("ParticleEmitter") or (p1:IsA("Beam") or p1:IsA("Trail")) then
        emit(p1);

        return;
    end;

    for _, descendant in p1:GetDescendants() do
        emit(descendant);
    end;
end;

local function Weld(p3, p4) -- Line: 71
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p3;
    WeldConstraint.Part1 = p4;
    WeldConstraint.Parent = p3;

    return WeldConstraint;
end;

return function(p5) -- Line: 78
    -- upvalues: Essentials (copy), VfxManager (copy), Debris (copy), TweenService (copy)
    if p5.Task == "Dribble" then
        local u6 = script.Aura:Clone();
        u6.CFrame = p5.Char.Torso.CFrame;
        u6.Parent = workspace.Debris;
        Essentials:Weld(u6, p5.Char.Torso);
        task.delay(0.7, function() -- Line: 87
            -- upvalues: VfxManager (ref), u6 (copy)
            VfxManager.Enable(u6, false);

            for _, descendant in u6:GetDescendants() do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        local u7 = script.Charge:Clone();
        u7.CFrame = p5.Char.HumanoidRootPart.CFrame;
        u7.Parent = workspace.Debris;
        Essentials:Weld(u7, p5.Char.HumanoidRootPart);
        Emit_All_With_Duration(u7);
        local u8 = script.DashEffect:Clone();
        u8.Parent = workspace;
        u8.CFrame = p5.Char.HumanoidRootPart.CFrame * CFrame.new(1.1409072875976562, -0.3678882122039795, -1.9618148803710938) * CFrame.fromEulerAnglesYXZ(-2.980232594040899e-8, 3.1415927410125732, -2.220445519854721e-16);
        Emit_All_With_Duration(u8);
        local u9 = script.Shockwave1:Clone();
        u9.CFrame = u8.CFrame * CFrame.new(0, 0, 30) * CFrame.Angles(1.5707963267948966, 0, 0);
        u9.Parent = workspace.Debris;
        Debris:AddItem(u9, 2);
        local u10 = script.Shockwave2:Clone();
        u10.CFrame = u8.CFrame * CFrame.new(0, 0, 25) * CFrame.Angles(1.5707963267948966, 0, 0);
        u10.Parent = workspace.Debris;
        Debris:AddItem(u10, 2);
        local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

        for _, child in u9.Attachment:GetChildren() do
            if child:IsA("Beam") then
                child.Width0 = 0;
                child.Width1 = 0;
                TweenService:Create(child, TweenInfo_new_ret, {
                    Width0 = 3,
                    Width1 = 3
                }):Play();
            end;
        end;

        for _, child in u10.Attachment:GetChildren() do
            if child:IsA("Beam") then
                child.Width0 = 0;
                child.Width1 = 0;
                TweenService:Create(child, TweenInfo_new_ret, {
                    Width0 = 3,
                    Width1 = 3
                }):Play();
            end;
        end;

        task.delay(0.2, function() -- Line: 136
            -- upvalues: u9 (copy), TweenService (ref), TweenInfo_new_ret (copy), u10 (copy)
            for _, child in u9.Attachment:GetChildren() do
                if child:IsA("Beam") then
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;

            for _, child in u10.Attachment:GetChildren() do
                if child:IsA("Beam") then
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;
        end);
        task.delay(1.5, function() -- Line: 148
            -- upvalues: u6 (copy), u7 (copy), u8 (copy)
            u6:Destroy();
            u7:Destroy();
            task.wait(1);
            u8:Destroy();
        end);
    end;
end;