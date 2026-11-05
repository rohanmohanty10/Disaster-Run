  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Trove = require(Knit.Util.Trove);
local Signal = require(Knit.Util.Signal);
local u1 = nil;
local v2 = {};

if Core.Context ~= "Client" then
    return v2;
end;

if Core.Flags.UseNewActionable == true then
    return v2;
end;

function v2.Init(u3) -- Line: 29
    -- upvalues: Signal (copy), Trove (copy), u1 (ref), Knit (copy)
    u3.ActiveUpdated = Signal.new();
    u3.ActiveTable = {};

    function u3.GetActiveTable(u4) -- Line: 33
        -- upvalues: u3 (copy), Trove (ref)
        local v5 = u3.ActiveTable[u4];

        if u4:IsDescendantOf(workspace) then
            if not v5 then
                v5 = {};
                u3.ActiveTable[u4] = v5;
                local u6 = Trove.new();
                u6:AttachToInstance(u4);
                u6:Connect(u4.AncestryChanged, function() -- Line: 42
                    -- upvalues: u4 (copy), u6 (copy)
                    if not u4:IsDescendantOf(game) then
                        u6:Destroy();
                    end;
                end);
                u6:Add(function() -- Line: 48
                    -- upvalues: u3 (ref), u4 (copy)
                    u3.ActiveTable[u4] = nil;
                end);
            end;

            return v5;
        end;
    end;

    function u3.SetActive(p7, p8, p9) -- Line: 55
        -- upvalues: u3 (copy)
        if p7:GetAttribute("TrueURF") then
            return;
        end;

        local v10 = u3.GetActiveTable(p7);

        if not v10 then
            return;
        end;

        if p9 then
            v10[p8] = {
                Priority = p9.Priority or u3.Enums.Active.Main
            };
        else
            v10[p8] = nil;
        end;

        u3.ActiveUpdated:Fire(p7, p8, p9);
    end;

    function u3.IsActive(p11, p12) -- Line: 73
        -- upvalues: u3 (copy)
        local v13 = typeof(p12) == "number" and {
            Priority = p12
        } or p12 or {};
        local MinPriority = v13.MinPriority;
        local v14 = v13.MaxPriority or v13.Priority;
        local Ignore = v13.Ignore;

        for i, v in pairs(u3.GetActiveTable(p11)) do
            if not (Ignore and table.find(Ignore, i)) and (v.Priority and (not MinPriority or MinPriority <= v.Priority) and (not v14 or v.Priority <= v14)) then
                return true;
            end;
        end;

        return false;
    end;

    function u3.GetActive(p15, p16) -- Line: 96
        -- upvalues: u3 (copy)
        for i, v in pairs(u3.GetActiveTable(p15)) do
            if i == p16 then
                return v;
            end;
        end;

        return nil;
    end;

    function u3.IsActionable(p17, p18) -- Line: 105
        -- upvalues: u1 (ref), u3 (copy), Knit (ref)
        local v19 = p18 or {};
        local v20 = u1:GetContainer(p17);
        local Active = v19.Active;

        if Active == true then
            Active = u3.Enums.Active.Main;
        end;

        if Active and u3.IsActive(p17, Active) then
            return false;
        end;

        local v21 = v19.Stunned == nil and true or v19.Stunned;
        local v22 = nil;
        local v23 = nil;

        if v21 == true then
            v22 = u3.Enums.Stun.Light;
        elseif typeof(v21) == "table" then
            v22 = v21.MinPriority;
            v23 = v21.MaxPriority;
        end;

        if not p17:GetAttribute("IgnoreStunState") then
            if v21 and u3.IsStunned(p17, {
                MinPriority = v22,
                MaxPriority = v23
            }) then
                return false;
            end;

            if (v19.Ragdolled == nil and true or v19.Ragdolled) and u3.IsRagdolled(p17) then
                return false;
            end;
        end;

        if p17:GetAttribute("TrueTrueURF") then
            return true;
        end;

        if v19.Summoned and not Knit.CollectionService:HasTag(p17, "Summoned") then
            return false;
        end;

        if v19.StandOff and Knit.CollectionService:HasTag(p17, "Summoned") then
            return false;
        end;

        if v19.Tags and typeof(v19.Tags) == "table" then
            for _, v in pairs(v19.Tags) do
                if not u1:Get(v20, v) then
                    return false;
                end;
            end;
        end;

        local v24 = p17:FindFirstChildOfClass("Humanoid");

        if v24 and (v24.Health <= 0 and v19.Dead ~= true) then
            return false;
        end;

        if v19.Disabled ~= false and (v20 and (u1:Get(v20, "Disabled") or u1:Get(v20, "DisableInputs"))) then
            return false;
        end;

        if v19.Timestopped ~= false and p17:GetAttribute("Timestopped") then
            return false;
        end;

        if v19.Mounting ~= false and p17:GetAttribute("Mount") then
            return false;
        end;

        if v19.MasteryRank and ((p17:GetAttribute("MasteryRank") or 0) < v19.MasteryRank and not p17:GetAttribute("NPC")) then
            return false;
        end;

        if v19.Ground ~= nil then
            local RaycastMap = u3.RaycastMap;
            local Position = p17.HumanoidRootPart.Position;
            local v25;

            if typeof(v19.Ground) == "number" then
                v25 = v19.Ground;
            else
                v25 = p17:GetExtentsSize().Y;
            end;

            if not RaycastMap(Position, Vector3.new(0, 1, 0) * -v25) then
                return false;
            end;
        end;

        return (not v19.Check or v19.Check(p17, v19)) and true or false;
    end;
end;

function v2.Start(u26) -- Line: 213
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
    u26.Remotes.ActiveChanged:Connect(function(p27) -- Line: 219
        -- upvalues: u26 (copy)
        u26.SetActive(unpack(p27));
    end);
end;

return v2;