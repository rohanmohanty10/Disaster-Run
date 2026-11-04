 

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");

({}).Trash = function(u2, p3) -- Line: 5, Name: Trash
    task.delay(p3 or 1, function() -- Line: 6
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

require(ReplicatedStorage.util.MeshFlipbook);
local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

local function emit(p4) -- Line: 15
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 20
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 23
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.Wings(p7: table) -- Line: 27
    -- upvalues: enable (copy)
    local HumanoidRootPart = p7.Character:FindFirstChild("HumanoidRootPart");
    local u8 = script.TwoGuys.KarasuWings:Clone();
    u8.Parent = HumanoidRootPart;
    u8:PivotTo(HumanoidRootPart.CFrame);
    enable(u8, 0.7);
    task.delay(2, function() -- Line: 6
        -- upvalues: u8 (copy)
        pcall(game.Destroy, u8);
    end);
end;

function v1.Impact(p9: table) -- Line: 36
    -- upvalues: emit (copy)
    local HumanoidRootPart = p9.Character:FindFirstChild("HumanoidRootPart");
    local u10 = script.TwoGuys.Impact:Clone();
    u10.Parent = HumanoidRootPart;
    u10:PivotTo(HumanoidRootPart.CFrame);
    emit(u10);
    task.delay(2, function() -- Line: 6
        -- upvalues: u10 (copy)
        pcall(game.Destroy, u10);
    end);
end;

function v1.ImpactEnemy(p11: table) -- Line: 45
    -- upvalues: emit (copy)
    local HumanoidRootPart = p11.Character:FindFirstChild("HumanoidRootPart");
    local u12 = script.TwoGuys.Impact:Clone();
    u12.Parent = HumanoidRootPart;
    u12:PivotTo(HumanoidRootPart.CFrame);
    emit(u12);
    task.delay(2, function() -- Line: 6
        -- upvalues: u12 (copy)
        pcall(game.Destroy, u12);
    end);
end;

function v1.Clash(p13: table) -- Line: 54
    -- upvalues: enable (copy)
    local HumanoidRootPart = p13.Character:FindFirstChild("HumanoidRootPart");
    local u14 = script.TwoGuys.Clash:Clone();
    u14.Parent = HumanoidRootPart;
    u14:PivotTo(HumanoidRootPart.CFrame);
    enable(u14, 0.5);
    task.delay(2, function() -- Line: 6
        -- upvalues: u14 (copy)
        pcall(game.Destroy, u14);
    end);
end;

function v1.RushMeshes(p15: table) -- Line: 63
    -- upvalues: MeshEmitModule (copy)
    local HumanoidRootPart = p15.Character:FindFirstChild("HumanoidRootPart");
    local v16 = {};

    for i = 1, 4 do
        local u17 = script.TwoGuys["Mesh" .. i]:Clone();
        u17:PivotTo(HumanoidRootPart.CFrame);
        v16["aaa" .. i] = u17;
        task.delay(8, function() -- Line: 6
            -- upvalues: u17 (copy)
            pcall(game.Destroy, u17);
        end);
        local _ = i;
    end;

    for _, v in v16 do
        MeshEmitModule(v.Start);
    end;
end;

function v1.WindMesh(p18: table) -- Line: 81
    -- upvalues: MeshEmitModule (copy)
    local HumanoidRootPart = p18.Character:FindFirstChild("HumanoidRootPart");
    local v19 = {};

    for i = 1, 3 do
        local u20 = script.TwoGuys["Wind" .. i]:Clone();
        u20:PivotTo(HumanoidRootPart.CFrame);
        v19["aaa" .. i] = u20;
        task.delay(8, function() -- Line: 6
            -- upvalues: u20 (copy)
            pcall(game.Destroy, u20);
        end);
        local _ = i;
    end;

    for _, v in v19 do
        MeshEmitModule(v.Start);
    end;
end;

function v1.SpeedLines(p21: table) -- Line: 100
    -- upvalues: enable (copy)
    local HumanoidRootPart = p21.Character:FindFirstChild("HumanoidRootPart");
    local u22 = script.TwoGuys.Speed:Clone();
    u22.Parent = HumanoidRootPart;
    u22:PivotTo(HumanoidRootPart.CFrame);
    local RunService = game:GetService("RunService");
    local u23 = nil;
    u23 = RunService.RenderStepped:Connect(function(p24) -- Line: 109
        -- upvalues: HumanoidRootPart (copy), u22 (copy), u23 (ref)
        if HumanoidRootPart and u22 then
            u22:PivotTo(HumanoidRootPart.CFrame);

            return;
        end;

        u23:Disconnect();
    end);
    task.delay(1.6, function() -- Line: 117
        -- upvalues: u23 (ref)
        if u23 then
            u23:Disconnect();
        end;
    end);
    enable(u22, 0.7);
    task.delay(1.6, function() -- Line: 6
        -- upvalues: u22 (copy)
        pcall(game.Destroy, u22);
    end);
end;

return v1;