  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local StoreHandler = require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);

return function(u1, u2, p3) -- Line: 5
    -- upvalues: StoreHandler (copy), Trove (copy)
    if not (u2 and u2:IsDescendantOf(workspace)) then
        return;
    end;

    local u4 = StoreHandler.GetStore("PropCache");

    if not u4[u1] then
        u4[u1] = {};
    end;

    if u4[u1][u2] then
        u4[u1][u2]:Destroy();

        return;
    end;

    local v5 = require(script[u1]);
    local v6 = Trove.new();
    u4[u1][u2] = v6;
    v6:Add(function() -- Line: 19
        -- upvalues: u4 (copy), u1 (copy), u2 (copy)
        u4[u1][u2] = nil;
    end);
    local Weld = Instance.new("Weld");
    local v7 = v6:Clone(v5.Object);
    local Offset = v5.Offset;
    local v8 = nil;

    if v7:IsA("Model") then
        if not v7.PrimaryPart then
            warn(u1, " has no primarypart");
        end;

        v8 = v7.PrimaryPart;
    elseif v7:IsA("BasePart") then
        v8 = v7;
    end;

    Weld.Parent = v8;
    Weld.Part0 = v8;
    Weld.Part1 = u2;
    Weld.C0 = Offset;
    v7.Parent = workspace.Effects;

    if p3 then
        task.delay(p3, v6.Destroy, v6);
    end;
end;