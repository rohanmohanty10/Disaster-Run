 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local v1 = {
    Attribute = "Smoked"
};
local u2 = {
    Runner = "Catcher",
    Catcher = "Runner"
};
local u3 = {};
local BindableEvent = Instance.new("BindableEvent");
v1.Changed = BindableEvent.Event;
local u4 = nil;
local u5 = 0;

local function prune(p6) -- Line: 29
    -- upvalues: u3 (copy)
    for i = #u3, 1, -1 do
        local v7;

        if u3[i].ends <= p6 then
            table.remove(u3, i);
            v7 = i;
        else
            v7 = i;
        end;
    end;
end;

local function tick() -- Line: 36
    -- upvalues: u5 (ref), prune (copy), u3 (copy), u4 (ref), BindableEvent (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret < u5 then
        return;
    end;

    u5 = os_clock_ret + 0.1;
    prune(os_clock_ret);

    if #u3 == 0 and u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    BindableEvent:Fire();
end;

function v1.add(p8, p9, p10, p11, p12) -- Line: 50
    -- upvalues: u2 (copy), u3 (copy), u4 (ref), RunService (copy), tick (copy), u5 (ref)
    if u2[p11] == nil then
        return;
    end;

    local v13 = {
        position = p8,
        reach = p9 * 1.2,
        height = p10,
        team = p11,
        ends = os.clock() + p12
    };
    table.insert(u3, v13);

    if not u4 and RunService:IsClient() then
        u4 = RunService.Heartbeat:Connect(tick);
    end;

    u5 = 0;
end;

function v1.active() -- Line: 60
    -- upvalues: u3 (copy)
    return #u3 > 0;
end;

local function covers(p14, p15, p16) -- Line: 65
    local position = p14.position;
    local v17 = p16.X - p15.X;
    local v18 = p16.Z - p15.Z;
    local v19 = v17 * v17 + v18 * v18;
    local v20 = v19 <= 1e-6 and 1 or math.clamp(((position.X - p15.X) * v17 + (position.Z - p15.Z) * v18) / v19, 0, 1);
    local v21 = p15.X + v17 * v20 - position.X;
    local v22 = p15.Z + v18 * v20 - position.Z;

    if v21 * v21 + v22 * v22 > p14.reach * p14.reach then
        return false;
    end;

    local v23 = p15.Y + (p16.Y - p15.Y) * v20;
    local v24;

    if position.Y - 2 <= v23 then
        v24 = v23 <= position.Y + p14.height;
    else
        v24 = false;
    end;

    return v24;
end;

function v1.hidden(p25, p26) -- Line: 82
    -- upvalues: Players (copy), u2 (copy), u3 (copy), covers (copy)
    local LocalPlayer = Players.LocalPlayer;

    if not (p25 and (LocalPlayer and (p25 ~= LocalPlayer.Character and LocalPlayer:GetAttribute("InMatch") == true))) then
        return false;
    end;

    local Attribute = LocalPlayer:GetAttribute("GameRole");
    local Attribute2 = p25:GetAttribute("Smoked");

    if Attribute2 ~= nil and u2[Attribute2] == Attribute then
        return true;
    end;

    if #u3 == 0 then
        return false;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v27 = p25:FindFirstChild("HumanoidRootPart") or p25.PrimaryPart;

    if not (workspace_CurrentCamera and v27) then
        return false;
    end;

    local os_clock_ret = os.clock();

    for _, v in u3 do
        if u2[v.team] == Attribute and (os_clock_ret < v.ends and covers(v, workspace_CurrentCamera.CFrame.Position, v27.Position)) then
            return true;
        end;
    end;

    return false;
end;

return table.freeze(v1);