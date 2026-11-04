 
 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");

({}).Trash = function(u2, p3) -- Line: 5, Name: Trash
    task.delay(p3 or 1, function() -- Line: 6
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

require(ReplicatedStorage.util.MeshEmitModule);

local function emit(p4) -- Line: 13
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 18
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 21
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.template(p7: table) -- Line: 26
    p7.Character:FindFirstChild("HumanoidRootPart");
end;

function v1.Jump(p8: table) -- Line: 30
    -- upvalues: emit (copy)
    local HumanoidRootPart = p8.Character:FindFirstChild("HumanoidRootPart");
    local u9 = script.Jump.Jump:Clone();
    u9.Parent = workspace.Effects;
    emit(u9);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: u9 (copy)
        pcall(game.Destroy, u9);
    end);
    local u10 = script.Jump.KarasuWings:Clone();
    u10.Parent = workspace.Effects;
    u10:PivotTo(HumanoidRootPart.CFrame);
    u9:PivotTo(HumanoidRootPart.CFrame);
    local Weld = Instance.new("Weld");
    Weld.Parent = HumanoidRootPart;
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = u9.PrimaryPart;
    Weld.Parent = HumanoidRootPart;
    local Weld2 = Instance.new("Weld");
    Weld2.Parent = HumanoidRootPart;
    Weld2.Part0 = HumanoidRootPart;
    Weld2.Part1 = u10.PrimaryPart;
    Weld2.Parent = HumanoidRootPart;
    task.delay(2, function() -- Line: 6
        -- upvalues: u10 (copy)
        pcall(game.Destroy, u10);
    end);
    task.delay(2, function() -- Line: 6
        -- upvalues: Weld (copy)
        pcall(game.Destroy, Weld);
    end);
    task.delay(2, function() -- Line: 6
        -- upvalues: Weld2 (copy)
        pcall(game.Destroy, Weld2);
    end);
    local v11 = {};

    for i = 1, 3 do
        local u12 = script.Jump["Jump" .. i]:Clone();
        u12:PivotTo(HumanoidRootPart.CFrame);
        v11["aaa" .. i] = u12;
        task.delay(8, function() -- Line: 6
            -- upvalues: u12 (copy)
            pcall(game.Destroy, u12);
        end);
        local _ = i;
    end;

    for _, _ in v11 do

    end;
end;

function v1.Impact(p13: table) -- Line: 74
    -- upvalues: emit (copy)
    local HumanoidRootPart = p13.Character:FindFirstChild("HumanoidRootPart");
    local u14 = script.Jump.Impact:Clone();
    u14.Parent = workspace.Effects;
    u14:PivotTo(HumanoidRootPart.CFrame);
    emit(u14);
    task.delay(1.3, function() -- Line: 6
        -- upvalues: u14 (copy)
        pcall(game.Destroy, u14);
    end);
end;

function v1.Land(p15: table) -- Line: 83
    -- upvalues: emit (copy)
    local HumanoidRootPart = p15.Character:FindFirstChild("HumanoidRootPart");
    local u16 = script.Jump.Land:Clone();
    u16.Parent = workspace.Effects;
    u16:PivotTo(HumanoidRootPart.CFrame);
    local Weld = Instance.new("Weld");
    Weld.Parent = HumanoidRootPart;
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = u16.PrimaryPart;
    Weld.Parent = HumanoidRootPart;
    emit(u16);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: u16 (copy)
        pcall(game.Destroy, u16);
    end);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: Weld (copy)
        pcall(game.Destroy, Weld);
    end);
end;

return v1;