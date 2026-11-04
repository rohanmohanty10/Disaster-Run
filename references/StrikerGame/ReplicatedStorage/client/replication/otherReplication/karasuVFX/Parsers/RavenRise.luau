 

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;

({}).Trash = function(u2, p3) -- Line: 9, Name: Trash
    task.delay(p3 or 1, function() -- Line: 10
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);
local script_Particle_Module = require(script.Particle_Module);

local function emit(p4) -- Line: 17
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 22
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 25
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.template(p7: table) -- Line: 30
    p7.Character:FindFirstChild("HumanoidRootPart");
end;

function v1.Feint(p8: table) -- Line: 34
    -- upvalues: emit (copy)
    local HumanoidRootPart = p8.Character:FindFirstChild("HumanoidRootPart");
    local u9 = script.RavenRise.Feint:Clone();
    u9.Parent = HumanoidRootPart;
    u9:PivotTo(HumanoidRootPart.CFrame);
    emit(u9);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u9 (copy)
        pcall(game.Destroy, u9);
    end);
    local u10 = script.RavenRise.Ballhit:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = HumanoidRootPart;
    emit(u10);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u10 (copy)
        pcall(game.Destroy, u10);
    end);
end;

function v1.Jump(p11: table) -- Line: 49
    -- upvalues: emit (copy), enable (copy)
    local HumanoidRootPart = p11.Character:FindFirstChild("HumanoidRootPart");
    local u12 = script.RavenRise.Jump:Clone();
    u12.Parent = HumanoidRootPart;
    u12:PivotTo(HumanoidRootPart.CFrame);
    emit(u12);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u12 (copy)
        pcall(game.Destroy, u12);
    end);
    local u13 = script.RavenRise.Miss:Clone();
    u13.Parent = HumanoidRootPart;
    u13:PivotTo(HumanoidRootPart.CFrame);
    emit(u13);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u13 (copy)
        pcall(game.Destroy, u13);
    end);
    local u14 = script.RavenRise.KarasuWings:Clone();
    u14.Parent = HumanoidRootPart;
    u14:PivotTo(HumanoidRootPart.CFrame);
    enable(u14, 0.6);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u14 (copy)
        pcall(game.Destroy, u14);
    end);
end;

function v1.Star(p15: table) -- Line: 71
    -- upvalues: emit (copy)
    local HumanoidRootPart = p15.Character:FindFirstChild("HumanoidRootPart");
    local u16 = script.RavenRise.Star:Clone();
    u16.Parent = HumanoidRootPart;
    u16:PivotTo(HumanoidRootPart.CFrame);
    emit(u16);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u16 (copy)
        pcall(game.Destroy, u16);
    end);
end;

function v1.Bezier(p17: table) -- Line: 82
    -- upvalues: script_Particle_Module (copy)
    local HumanoidRootPart = p17.Character:FindFirstChild("HumanoidRootPart");
    local u18 = script.RavenRise.CFR:Clone();
    u18.Parent = HumanoidRootPart;
    u18:PivotTo(HumanoidRootPart.CFrame);
    task.delay(3, function() -- Line: 10
        -- upvalues: u18 (copy)
        pcall(game.Destroy, u18);
    end);
    script_Particle_Module.CreateBezierTrails(script.RavenRise.BezierTest.BezierTest, 6, u18.CFR.CFrame, 0.1, 6, 0.2, false);
end;

function v1.Grab(p19: table) -- Line: 94
    -- upvalues: emit (copy)
    local HumanoidRootPart = p19.Character:FindFirstChild("HumanoidRootPart");
    local u20 = script.RavenRise.Grab:Clone();
    u20.Parent = HumanoidRootPart;
    u20:PivotTo(HumanoidRootPart.CFrame);
    emit(u20);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u20 (copy)
        pcall(game.Destroy, u20);
    end);
end;

function v1.Impact(p21: table) -- Line: 106
    -- upvalues: emit (copy), MeshEmitModule (copy)
    local HumanoidRootPart = p21.Character:FindFirstChild("HumanoidRootPart");
    local u22 = script.RavenRise.Impact:Clone();
    u22.Parent = HumanoidRootPart;
    u22:PivotTo(HumanoidRootPart.CFrame);
    emit(u22);
    task.delay(1.5, function() -- Line: 10
        -- upvalues: u22 (copy)
        pcall(game.Destroy, u22);
    end);
    local v23 = {};

    for i = 1, 9 do
        local u24 = script.RavenRise["Mesh" .. i]:Clone();
        u24:PivotTo(HumanoidRootPart.CFrame);
        v23["aaa" .. i] = u24;
        task.delay(8, function() -- Line: 10
            -- upvalues: u24 (copy)
            pcall(game.Destroy, u24);
        end);
        local _ = i;
    end;

    for _, v in v23 do
        MeshEmitModule(v.Start);
    end;
end;

return v1;