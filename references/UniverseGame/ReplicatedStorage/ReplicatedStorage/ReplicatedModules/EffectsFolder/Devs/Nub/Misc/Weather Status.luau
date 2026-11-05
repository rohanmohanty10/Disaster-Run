  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local RunService = game:GetService("RunService");
local insert = table.insert;
local cos = math.cos;
local sin = math.sin;
local _ = math.rad;
local _ = math.random;

local function getang(p1, p2) -- Line: 9
    -- upvalues: cos (copy), sin (copy)
    return { cos(p1) * p2, sin(p1) * p2 };
end;

local function createradians(p3, p4, p5) -- Line: 13
    -- upvalues: cos (copy), sin (copy), insert (copy)
    local v6 = p5 or 0;
    local v7 = {};

    for i = 1, p3 do
        local v8 = 6.283185307179586 / p3 * i + v6;
        insert(v7, { cos(v8) * p4, sin(v8) * p4 });
    end;

    return v7;
end;

return function(u9, p10) -- Line: 22
    -- upvalues: Trove (copy), RunService (copy), createradians (copy)
    local v11 = workspace.Effects:WaitForChild(p10, 1);

    if not (v11 and v11:IsDescendantOf(workspace)) then
        return;
    end;

    local v12 = Trove.new();
    v12:AttachToInstance(u9);
    v12:AttachToInstance(v11);
    local u13 = { v11 };

    for _ = 1, 2 do
        local v14 = v11:Clone();
        table.insert(u13, v14);
        v12:Add(v14).Parent = workspace.Effects;
    end;

    local u15 = 0;
    v12:Connect(RunService.RenderStepped, function(p16) -- Line: 38
        -- upvalues: createradians (ref), u13 (copy), u15 (ref), u9 (copy)
        local v17 = createradians(#u13, 5, u15 * 5);
        u15 = u15 + p16;

        for i, v in ipairs(v17) do
            u13[i].CFrame = u9.HumanoidRootPart.CFrame * CFrame.new(v[1], 0, v[2]);
        end;
    end);
end;