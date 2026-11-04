 

 

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

local function emit(p4) -- Line: 14
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 19
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 22
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.template(p7: table) -- Line: 27
    p7.Character:FindFirstChild("HumanoidRootPart");
end;

function v1.Clash(p8: table) -- Line: 31
    -- upvalues: enable (copy)
    local HumanoidRootPart = p8.Character:FindFirstChild("HumanoidRootPart");
    local u9 = script.OneGuy.Clash:Clone();
    u9.Parent = HumanoidRootPart;
    u9:PivotTo(HumanoidRootPart.CFrame);
    enable(u9, 0.5);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: u9 (copy)
        pcall(game.Destroy, u9);
    end);
end;

function v1.Impact(p10: table) -- Line: 40
    -- upvalues: emit (copy)
    local HumanoidRootPart = p10.Character:FindFirstChild("HumanoidRootPart");
    local u11 = script.OneGuy.Impact:Clone();
    u11.Parent = HumanoidRootPart;
    u11:PivotTo(HumanoidRootPart.CFrame);
    emit(u11);
    task.delay(1.3, function() -- Line: 6
        -- upvalues: u11 (copy)
        pcall(game.Destroy, u11);
    end);
end;

function v1.Wings(p12: table) -- Line: 49
    -- upvalues: enable (copy)
    local HumanoidRootPart = p12.Character:FindFirstChild("HumanoidRootPart");
    local u13 = script.OneGuy.KarasuWings:Clone();
    u13.Parent = HumanoidRootPart;
    u13:PivotTo(HumanoidRootPart.CFrame);
    local RunService = game:GetService("RunService");
    local u14 = nil;
    u14 = RunService.RenderStepped:Connect(function(p15) -- Line: 58
        -- upvalues: HumanoidRootPart (copy), u13 (copy), u14 (ref)
        if HumanoidRootPart and u13 then
            u13:PivotTo(HumanoidRootPart.CFrame);

            return;
        end;

        u14:Disconnect();
    end);
    task.delay(2, function() -- Line: 66
        -- upvalues: u14 (ref)
        if u14 then
            u14:Disconnect();
        end;
    end);
    enable(u13, 0.7);
    task.delay(2, function() -- Line: 6
        -- upvalues: u13 (copy)
        pcall(game.Destroy, u13);
    end);
end;

function v1.SpeedLines(p16: table) -- Line: 76
    -- upvalues: enable (copy)
    local HumanoidRootPart = p16.Character:FindFirstChild("HumanoidRootPart");
    local u17 = script.OneGuy.Speed:Clone();
    u17.Parent = HumanoidRootPart;
    u17:PivotTo(HumanoidRootPart.CFrame);
    local RunService = game:GetService("RunService");
    local u18 = nil;
    u18 = RunService.RenderStepped:Connect(function(p19) -- Line: 85
        -- upvalues: HumanoidRootPart (copy), u17 (copy), u18 (ref)
        if HumanoidRootPart and u17 then
            u17:PivotTo(HumanoidRootPart.CFrame);

            return;
        end;

        u18:Disconnect();
    end);
    task.delay(1.6, function() -- Line: 93
        -- upvalues: u18 (ref)
        if u18 then
            u18:Disconnect();
        end;
    end);
    enable(u17, 0.7);
    task.delay(1.6, function() -- Line: 6
        -- upvalues: u17 (copy)
        pcall(game.Destroy, u17);
    end);
end;

function v1.RushMeshes(p20: table) -- Line: 104
    -- upvalues: MeshEmitModule (copy)
    local HumanoidRootPart = p20.Character:FindFirstChild("HumanoidRootPart");
    local v21 = {};

    for i = 1, 2 do
        local u22 = script.OneGuy["Mesh" .. i]:Clone();
        u22:PivotTo(HumanoidRootPart.CFrame);
        v21["aaa" .. i] = u22;
        task.delay(8, function() -- Line: 6
            -- upvalues: u22 (copy)
            pcall(game.Destroy, u22);
        end);
        local _ = i;
    end;

    for _, v in v21 do
        MeshEmitModule(v.Start);
    end;
end;

return v1;