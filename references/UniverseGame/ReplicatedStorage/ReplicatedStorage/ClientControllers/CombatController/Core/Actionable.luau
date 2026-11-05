  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(Knit.Util.Signal);
local u1 = nil;

return {
    Init = function(u2) -- Line: 20, Name: Init
        -- upvalues: Signal (copy), Trove (copy), u1 (ref), Knit (copy)
        u2.ActiveUpdated = Signal.new();
        u2.ActiveTable = {};

        function u2.GetActiveTable(u3) -- Line: 24
            -- upvalues: u2 (copy), Trove (ref)
            local v4 = u2.ActiveTable[u3];

            if u3:IsDescendantOf(workspace) then
                if not v4 then
                    v4 = {};
                    u2.ActiveTable[u3] = v4;
                    local u5 = Trove.new();
                    u5:AttachToInstance(u3);
                    u5:Connect(u3.AncestryChanged, function() -- Line: 33
                        -- upvalues: u3 (copy), u5 (copy)
                        if not u3:IsDescendantOf(game) then
                            u5:Destroy();
                        end;
                    end);
                    u5:Add(function() -- Line: 39
                        -- upvalues: u2 (ref), u3 (copy)
                        u2.ActiveTable[u3] = nil;
                    end);
                end;

                return v4;
            end;
        end;

        function u2.SetActive(p6, p7, p8) -- Line: 46
            -- upvalues: u2 (copy)
            if p6:GetAttribute("TrueURF") then
                return;
            end;

            local v9 = u2.GetActiveTable(p6);

            if not v9 then
                return;
            end;

            if p8 then
                v9[p7] = {
                    Priority = p8.Priority or u2.Enums.Active.Main
                };
            else
                v9[p7] = nil;
            end;

            u2.ActiveUpdated:Fire(p6, p7, p8);
        end;

        function u2.IsActive(p10, p11) -- Line: 64
            -- upvalues: u2 (copy)
            local v12 = typeof(p11) == "number" and {
                Priority = p11
            } or p11 or {};
            local MinPriority = v12.MinPriority;
            local v13 = v12.MaxPriority or v12.Priority;
            local Ignore = v12.Ignore;

            for i, v in pairs(u2.GetActiveTable(p10)) do
                if not (Ignore and table.find(Ignore, i)) and (v.Priority and (not MinPriority or MinPriority <= v.Priority) and (not v13 or v.Priority <= v13)) then
                    return true;
                end;
            end;

            return false;
        end;

        function u2.GetActive(p14, p15) -- Line: 87
            -- upvalues: u2 (copy)
            for i, v in pairs(u2.GetActiveTable(p14)) do
                if i == p15 then
                    return v;
                end;
            end;

            return nil;
        end;

        function u2.IsActionable(p16, p17) -- Line: 96
            -- upvalues: u1 (ref), u2 (copy), Knit (ref)
            local v18 = p17 or {};
            local v19 = u1:GetContainer(p16);
            local Active = v18.Active;

            if Active == true then
                Active = u2.Enums.Active.Main;
            end;

            if Active and u2.IsActive(p16, Active) then
                return false;
            end;

            local v20 = v18.Stunned == nil and true or v18.Stunned;
            local v21 = nil;
            local v22 = nil;

            if v20 == true then
                v21 = u2.Enums.Stun.Light;
            elseif typeof(v20) == "table" then
                v21 = v20.MinPriority;
                v22 = v20.MaxPriority;
            end;

            if not p16:GetAttribute("IgnoreStunState") then
                if v20 and u2.IsStunned(p16, {
                    MinPriority = v21,
                    MaxPriority = v22
                }) then
                    return false;
                end;

                if (v18.Ragdolled == nil and true or v18.Ragdolled) and u2.IsRagdolled(p16) then
                    return false;
                end;
            end;

            if p16:GetAttribute("TrueTrueURF") then
                return true;
            end;

            if v18.Summoned and not Knit.CollectionService:HasTag(p16, "Summoned") then
                return false;
            end;

            if v18.StandOff and Knit.CollectionService:HasTag(p16, "Summoned") then
                return false;
            end;

            if v18.Tags and typeof(v18.Tags) == "table" then
                for _, v in pairs(v18.Tags) do
                    if not u1:Get(v19, v) then
                        return false;
                    end;
                end;
            end;

            local v23 = p16:FindFirstChildOfClass("Humanoid");

            if v23 and (v23.Health <= 0 and v18.Dead ~= true) then
                return false;
            end;

            if v18.Disabled ~= false and (v19 and (u1:Get(v19, "Disabled") or u1:Get(v19, "DisableInputs"))) then
                return false;
            end;

            if v18.Timestopped ~= false and p16:GetAttribute("Timestopped") then
                return false;
            end;

            if v18.Mounting ~= false and p16:GetAttribute("Mount") then
                return false;
            end;

            if v18.MasteryRank and ((p16:GetAttribute("MasteryRank") or 0) < v18.MasteryRank and not p16:GetAttribute("NPC")) then
                return false;
            end;

            if v18.Ground ~= nil then
                local RaycastMap = u2.RaycastMap;
                local Position = p16.HumanoidRootPart.Position;
                local v24;

                if typeof(v18.Ground) == "number" then
                    v24 = v18.Ground;
                else
                    v24 = p16:GetExtentsSize().Y;
                end;

                if not RaycastMap(Position, Vector3.new(0, 1, 0) * -v24) then
                    return false;
                end;
            end;

            return (not v18.Check or v18.Check(p16, v18)) and true or false;
        end;
    end,

    Start = function(u25) -- Line: 204, Name: Start
        -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy)
        u1 = require(Knit.ReplicatedModules.Independent.TagService);
        require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService"):GetRemote("ActiveChanged").OnClientEvent:Connect(function(...) -- Line: 210
            -- upvalues: u25 (copy)
            u25.SetActive(...);
        end);
    end
};