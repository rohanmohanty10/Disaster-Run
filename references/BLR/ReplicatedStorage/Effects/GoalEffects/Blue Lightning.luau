  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1;

if RunService:IsRunning() then
    u1 = workspace:FindFirstChild("Debris");
else
    u1 = workspace.CurrentCamera;
end;

return function(p2: table) -- Line: 8
    -- upvalues: u1 (copy), EmitModule (copy)
    local GE = script:FindFirstChild("GE");
    local v3;

    if GE then
        v3 = GE:IsA("Model");
    else
        v3 = GE;
    end;

    assert(v3, "Blue Lightning goal effect model is missing");
    local u4 = GE:Clone();
    u4.Parent = u1;
    u4:PivotTo(p2.Pos);

    for _, child in u4:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.CanCollide = false;
            child.Transparency = 1;
        end;
    end;

    EmitModule.emit(u4);
    task.delay(8, function() -- Line: 21
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;