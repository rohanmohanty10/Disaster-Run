  

 

local u1 = {};
u1.__index = u1;
local Signal = require(game.ReplicatedStorage.ReplicatedModules.Signal);
game:GetService("RunService");
local insert = table.insert;
local _ = table.find;
local remove = table.remove;
local clear = table.clear;
local _ = task.wait;

function u1.new(p2) -- Line: 18
    -- upvalues: Signal (copy), u1 (copy)
    local v3 = RaycastParams.new();
    v3.FilterType = Enum.RaycastFilterType.Whitelist;
    v3.CollisionGroup = "Raycast";
    local v4 = Signal.new();
    local v5 = {
        Offset = type(p2.Offset) == "number" and (p2.Offset or 1) or 1,
        Blacklisted = {},
        Attachments = {},
        RaycastSettings = v3,
        Signal = v4,
        OnHit = v4
    };
    local v6 = false;

    for _, v in ipairs(p2.Blacklisted) do
        v5.Blacklisted[v] = true;
        v6 = true;
    end;

    if not v6 then
        for i, _ in pairs(p2.Blacklisted) do
            v5.Blacklisted[i] = true;
        end;
    end;

    setmetatable(v5, u1);

    return v5;
end;

function u1.BindObject(p7, p8, p9) -- Line: 51
    -- upvalues: insert (copy)
    local v10 = type(p9) == "table" and p9 and p9 or { "DmgPoint" };
    local v11 = {};
    local v12 = false;

    for _, v in ipairs(v10) do
        v11[v] = true;
        v12 = true;
    end;

    if not v12 then
        for i, _ in pairs(v10) do
            v11[i] = true;
        end;
    end;

    for _, descendant in ipairs(p8:GetDescendants()) do
        if v11[descendant.Name] and descendant:IsA("Attachment") then
            insert(p7.Attachments, descendant);
        end;
    end;
end;

function u1.CastHitbox(p13) -- Line: 74
    -- upvalues: remove (copy)
    if p13.Freeze then
        return;
    end;

    local v14 = workspace.Living:GetChildren();

    for i, v in ipairs(v14) do
        if p13.Blacklisted[v.Name] or p13.Blacklisted[v] then
            remove(v14, i);
        end;
    end;

    p13.RaycastSettings.FilterDescendantsInstances = v14;

    for _, v in ipairs(p13.Attachments) do
        if not p13.Offset then
            break;
        end;

        local v15 = workspace:Raycast(v.WorldPosition, v.WorldCFrame.LookVector * p13.Offset, p13.RaycastSettings);

        if v15 then
            local Instance = v15.Instance;

            while Instance.Parent ~= workspace.Living do
                Instance = Instance.Parent;
            end;

            p13.Blacklisted[Instance] = true;
            p13.Signal:Fire(Instance);
        end;
    end;
end;

function u1.Destroy(p16) -- Line: 99
    -- upvalues: clear (copy)
    p16.Signal:Destroy();
    clear(p16);
end;

return u1;