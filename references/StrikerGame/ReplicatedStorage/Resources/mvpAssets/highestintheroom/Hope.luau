 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local v1 = {};

local function getUI() -- Line: 7
    -- upvalues: Players (copy), StarterGui (copy), RunService (copy)
    local v2 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v3 = v2 and v2:FindFirstChild("HOPE") or StarterGui:FindFirstChild("HOPE");

    if not v3 then
        v3 = script:FindFirstChild("HOPE"):Clone();
        v3.Parent = RunService:IsClient() and v2 and v2 or StarterGui;
    end;

    return v3;
end;

function v1.New(p4) -- Line: 21
    -- upvalues: getUI (copy)
    return getUI();
end;

function v1.Next(p5) -- Line: 25
    -- upvalues: getUI (copy)
    local v6 = getUI();
    local v7 = (v6:GetAttribute("count") or 0) + 1;
    v6:SetAttribute("count", v7);
    local v8 = v6:FindFirstChild((tostring(v7)));

    if v8 then
        v8.Visible = true;
    end;

    return v6;
end;

function v1.Okay(p9) -- Line: 40
    -- upvalues: getUI (copy)
    getUI():Destroy();

    return true;
end;

return v1;