  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

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

return function(p3) -- Line: 71
    -- upvalues: SoundManager (copy), TweenService (copy), Essentials (copy), VfxManager (copy)
    if p3.Task ~= "Start" then
        if p3.Task == "End" then
            local u4 = script.End:Clone();
            u4.Parent = workspace;
            u4.CFrame = p3.Char.HumanoidRootPart.CFrame;
            Emit_All_With_Duration(u4);
            task.delay(3, function() -- Line: 93
                -- upvalues: u4 (copy)
                u4:Destroy();
            end);
            local u5 = script.Shockwave1:Clone();
            u5.CFrame = p3.Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -15) * CFrame.Angles(1.5707963267948966, 0, 0);
            u5.Parent = workspace.Debris;
            local u6 = script.Shockwave2:Clone();
            u6.CFrame = p3.Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0);
            u6.Parent = workspace.Debris;
            local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

            for _, child in u5.Attachment:GetChildren() do
                if child:IsA("Beam") then
                    child.Width0 = 0;
                    child.Width1 = 0;
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Width0 = 3,
                        Width1 = 3
                    }):Play();
                end;
            end;

            for _, child in u6.Attachment:GetChildren() do
                if child:IsA("Beam") then
                    child.Width0 = 0;
                    child.Width1 = 0;
                    TweenService:Create(child, TweenInfo_new_ret, {
                        Width0 = 3,
                        Width1 = 3
                    }):Play();
                end;
            end;

            task.delay(0.4, function() -- Line: 123
                -- upvalues: u5 (copy), TweenService (ref), TweenInfo_new_ret (copy), u6 (copy)
                for _, child in u5.Attachment:GetChildren() do
                    if child:IsA("Beam") then
                        TweenService:Create(child, TweenInfo_new_ret, {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    end;
                end;

                for _, child in u6.Attachment:GetChildren() do
                    if child:IsA("Beam") then
                        TweenService:Create(child, TweenInfo_new_ret, {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    end;
                end;
            end);
            local Ball = p3.Ball;
            local Hitbox = Ball.Hitbox;
            local v7 = script.BallAura:Clone();
            v7.CFrame = Hitbox.CFrame;
            v7.Parent = Ball;
            Essentials:Weld(v7, Hitbox);

            repeat
                task.wait();
            until Ball.AssemblyLinearVelocity.Magnitude <= 130;

            VfxManager.Enable(v7, false);

            for _, descendant in v7:GetDescendants() do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.wait(2);
            v7:Destroy();
        end;

        return;
    end;

    SoundManager.SpawnSound("KaiserImpactEaster", 1, p3.Char.Torso, 100);
    local u8 = script.Start:Clone();
    u8.Parent = workspace;
    u8.CFrame = p3.Char.HumanoidRootPart.CFrame * CFrame.new(1.1409072875976562, -1.701096534729004, -1.9618148803710938) * CFrame.fromEulerAnglesYXZ(-2.980232594040899e-8, 3.1415927410125732, -2.220445519854721e-16);
    Emit_All_With_Duration(u8);
    task.delay(3, function() -- Line: 81
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;