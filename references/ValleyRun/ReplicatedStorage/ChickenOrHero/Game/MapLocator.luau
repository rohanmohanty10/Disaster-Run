 

 

local script_Parent = script.Parent;
local u1 = {
    current = function() -- Line: 4, Name: current
        -- upvalues: script_Parent (copy)
        local ActiveMap = script_Parent:FindFirstChild("ActiveMap");

        if ActiveMap then
            ActiveMap = ActiveMap.Value;
        end;

        if not (ActiveMap and (ActiveMap:IsDescendantOf(workspace) and ActiveMap)) then
            ActiveMap = nil;
        end;

        return ActiveMap;
    end
};

function u1.lobby() -- Line: 10
    -- upvalues: u1 (copy)
    local Lobby = workspace:FindFirstChild("Lobby");

    if Lobby then
        return Lobby;
    end;

    local v2 = u1.current();

    return v2 and v2:FindFirstChild("Lobby") or nil;
end;

function u1.interactables(p3) -- Line: 18
    local Lobby = workspace:FindFirstChild("Lobby");

    if not Lobby then
        if p3 then
            Lobby = workspace:WaitForChild("Lobby", p3);
        else
            Lobby = p3;
        end;
    end;

    if Lobby then
        local Interactables = Lobby:FindFirstChild("Interactables");

        if Interactables then
            p3 = Interactables;
        elseif p3 then
            p3 = Lobby:WaitForChild("Interactables", p3);
        end;
    else
        p3 = Lobby;
    end;

    return p3 or workspace;
end;

function u1.interactable(p4) -- Line: 23
    -- upvalues: u1 (copy)
    return u1.interactables():FindFirstChild(p4);
end;

return u1;