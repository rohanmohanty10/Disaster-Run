  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Controllers.SpectatorController);
local Vfx = ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function Emit_All_With_Duration(p3)
    local function emit(u4) -- Line: 28
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDuration");
            local Attribute2 = u4:GetAttribute("EmitDelay");
            local Attribute3 = u4:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 36
                        -- upvalues: u4 (copy), Attribute (copy)
                        u4.Enabled = true;
                        task.delay(Attribute, function() -- Line: 39
                            -- upvalues: u4 (ref)
                            u4.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u4.Enabled = true;
                task.delay(Attribute, function() -- Line: 46
                    -- upvalues: u4 (copy)
                    u4.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 53
                        -- upvalues: u4 (copy), Attribute3 (copy)
                        u4:Emit(Attribute3);
                    end);

                    return;
                end;

                u4:Emit(Attribute3);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
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

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 85
    task.delay(p6, function() -- Line: 87
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

local function Weld(p7, p8) -- Line: 103
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p7;
    WeldConstraint.Part1 = p8;
    WeldConstraint.Parent = p7;

    return WeldConstraint;
end;

return function(p9) -- Line: 110
    -- upvalues: Debris (copy), Vfx (copy)
    local Character = p9.Character;
    local _ = p9.Victim;
    local Data = p9.Data;
    local Ball = p9.Ball;

    if p9.Task ~= "Pass" then
        if p9.Task == "Receive" then
            local v10 = unpack(Data);
            local u11 = Vfx.OneTwo.Recieve:Clone();
            u11.CFrame = v10;
            u11.Parent = Debris;
            Emit_All_With_Duration(u11);
            task.delay(2, function() -- Line: 87
                -- upvalues: u11 (copy)
                if typeof(u11) == "table" then
                    for _, v in u11 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u11 then
                    u11:Destroy();
                end;
            end);
            local u12 = Debris:FindFirstChild("OneTwo" .. Character.Name);

            if u12 then
                u12.Name = "_";
                EnableVFX(u12, false);
                task.delay(2, function() -- Line: 87
                    -- upvalues: u12 (copy)
                    if typeof(u12) == "table" then
                        for _, v in u12 do
                            if v then
                                v:Destroy();
                            end;
                        end;

                        return;
                    end;

                    if u12 then
                        u12:Destroy();
                    end;
                end);
            end;

            local Trail = Ball:FindFirstChild("Trail");

            if Trail and Trail.Enabled == false then
                Trail.Enabled = true;
            end;
        end;

        return;
    end;

    local v13 = unpack(Data);
    local u14 = script.GroundFX:Clone();
    u14.CFrame = v13;
    u14.Parent = Debris;
    Emit_All_With_Duration(u14);
    task.delay(2, function() -- Line: 87
        -- upvalues: u14 (copy)
        if typeof(u14) == "table" then
            for _, v in u14 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u14 then
            u14:Destroy();
        end;
    end);
    local u15 = Vfx.OneTwo.Part:Clone();
    u15.Name = "OneTwo" .. Character.Name;
    u15.CFrame = Ball.CFrame;
    u15.Parent = Debris;
    EnableVFX(u15, true);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u15;
    WeldConstraint.Part1 = Ball;
    WeldConstraint.Parent = u15;
    local Trail = Ball:FindFirstChild("Trail");

    if Trail and Trail.Enabled == true then
        print("HI");
        Trail.Enabled = false;
    end;

    task.delay(5, function() -- Line: 87
        -- upvalues: u15 (copy)
        if typeof(u15) == "table" then
            for _, v in u15 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u15 then
            u15:Destroy();
        end;
    end);
end;