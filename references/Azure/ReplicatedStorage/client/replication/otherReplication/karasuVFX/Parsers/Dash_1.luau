 
 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");

({}).Trash = function(u2, p3) -- Line: 5, Name: Trash
    task.delay(p3 or 1, function() -- Line: 6
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

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

function v1.Dash(p8: table) -- Line: 30
    -- upvalues: emit (copy), MeshEmitModule (copy)
    local HumanoidRootPart = p8.Character:FindFirstChild("HumanoidRootPart");
    local u9 = script.Dash.Start:Clone();
    u9.Parent = HumanoidRootPart;
    emit(u9);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: u9 (copy)
        pcall(game.Destroy, u9);
    end);
    local u10 = script.Dash.Impact:Clone();
    u10.Parent = HumanoidRootPart;
    emit(u10);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: u10 (copy)
        pcall(game.Destroy, u10);
    end);

    for _, v in {
        aaa = script.Dash.First.Mesh1,
        aaa2 = script.Dash.First.Mesh2,
        aaa3 = script.Dash.First.Mesh3,
        aaa4 = script.Dash.First.Mesh4,
        aaa5 = script.Dash.First.Mesh5,
        aaa6 = script.Dash.First.Mesh6,
        aaa7 = script.Dash.First.Mesh7,
        aaa8 = script.Dash.First.Mesh8
    } do
        MeshEmitModule(v.Start);
    end;
end;

function v1.Catch(p11: table) -- Line: 60
    -- upvalues: emit (copy), MeshEmitModule (copy)
    local HumanoidRootPart = p11.Character:FindFirstChild("HumanoidRootPart");
    local u12 = script.Dash.Catch:Clone();
    u12.Parent = HumanoidRootPart;
    emit(u12);
    task.delay(1.5, function() -- Line: 6
        -- upvalues: u12 (copy)
        pcall(game.Destroy, u12);
    end);

    for _, v in {
        aaa = script.Dash.Second.Mesh1,
        aaa2 = script.Dash.Second.Mesh2,
        aaa3 = script.Dash.Second.Mesh3,
        aaa4 = script.Dash.Second.Mesh4,
        aaa5 = script.Dash.Second.Mesh5
    } do
        MeshEmitModule(v.Start);
    end;
end;

return v1;