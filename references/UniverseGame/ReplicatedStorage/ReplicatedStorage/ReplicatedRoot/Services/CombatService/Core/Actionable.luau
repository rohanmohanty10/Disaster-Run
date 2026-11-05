  

 

local v1 = {};
local _ = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
local Signal = require(Core.ReplicatedLibraries.Classes.Signal);
local TagService = require(Core.ReplicatedServices.TagService);
local CollectionService = game:GetService("CollectionService");

if Core.Flags.UseNewActionable ~= true then
    return v1;
end;

function v1.Init(u2) -- Line: 16
    -- upvalues: Signal (copy), TagService (copy), Core (copy), CollectionService (copy), Trove (copy)
    u2.Interrupted = Signal.new();
    local u3 = { "Quickstep", "Blink", "Breakneck Dash", "Shadowstep", "Superhuman Agility", "Soru", "Umbral Dash", "Speed Of Lightning", "Phantom Step" };

    function u2.IsActionable(p4, p5, p6) -- Line: 21
        -- upvalues: TagService (ref), u2 (copy), Core (ref), u3 (copy), CollectionService (ref)
        local v7 = p5 or {};
        local v8 = TagService:GetContainer(p4);
        local Active = v7.Active;

        if Active == true then
            Active = u2.Enums.Active.Main;
        end;

        if Active and u2.IsActive(p4, Active) then
            if not p4:GetAttribute("Quickstepping") or Core.Context ~= "Server" then
                return false;
            end;

            for i, _ in u2.GetActiveTable(p4) do
                if not table.find(u3, i) then
                    return false;
                end;
            end;
        end;

        local v9 = v7.Stunned == nil and true or v7.Stunned;
        local v10 = nil;
        local v11 = nil;

        if v9 == true then
            v10 = u2.Enums.Stun.Light;
        elseif typeof(v9) == "table" then
            v10 = v9.MinPriority;
            v11 = v9.MaxPriority;
        end;

        if not p4:GetAttribute("IgnoreStunState") then
            if v9 and u2.IsStunned(p4, {
                MinPriority = v10,
                MaxPriority = v11
            }) then
                return false;
            end;

            if (v7.Ragdolled == nil and true or v7.Ragdolled) and u2.IsRagdolled(p4) then
                return false;
            end;
        end;

        if p4:GetAttribute("TrueTrueURF") then
            return true;
        end;

        if v7.Summoned and not game:GetService("CollectionService"):HasTag(p4, "Summoned") then
            return false;
        end;

        if v7.StandOff and CollectionService:HasTag(p4, "Summoned") then
            return false;
        end;

        if v7.NoPilot and CollectionService:HasTag(p4, "Piloting") then
            return false;
        end;

        if v7.Tags and typeof(v7.Tags) == "table" then
            for _, v in pairs(v7.Tags) do
                if not TagService:Get(v8, v) then
                    return false;
                end;
            end;
        end;

        if v7.CanTimestop and Core.Context == "Server" then
            local Timestop = require(u2.Moves.Timestop);
            local HumanoidRootPart = p6.Character:FindFirstChild("HumanoidRootPart");
            local v12;

            if HumanoidRootPart then
                v12 = HumanoidRootPart.CFrame;
            else
                v12 = CFrame.identity;
            end;

            local Timestop2 = p6.Stats.Timestop;

            if not Timestop.CanTimestop({
                Origin = v12,
                Size = Timestop2 and Timestop2.Size or 151
            }) then
                return false;
            end;
        end;

        local v13 = p4:FindFirstChildOfClass("Humanoid");

        if v13 and (v13.Health <= 0 and v7.Dead ~= true) then
            return false;
        end;

        if v7.Disabled ~= false and (v8 and (TagService:Get(v8, "Disabled") or TagService:Get(v8, "DisableInputs"))) then
            return false;
        end;

        if v7.Timestopped ~= false and p4:GetAttribute("Timestopped") then
            return false;
        end;

        if v7.Mounting == false or not p4:GetAttribute("Mount") then
            if v7.MasteryRank and ((p4:GetAttribute("MasteryRank") or 0) < v7.MasteryRank and not p4:GetAttribute("NPC")) then
                return false;
            end;

            if Core.Context == "Client" and v7.Ground ~= nil then
                local RaycastMap = u2.RaycastMap;
                local Position = p4.HumanoidRootPart.Position;
                local v14;

                if typeof(v7.Ground) == "number" then
                    v14 = v7.Ground;
                else
                    v14 = p4:GetExtentsSize().Y;
                end;

                if not RaycastMap(Position, Vector3.new(0, 1, 0) * -v14) then
                    return false;
                end;
            end;

            return (not v7.Check or v7.Check(p4, v7)) and true or false;
        end;
    end;

    function u2.CanInterrupt(p15) -- Line: 165
        return true;
    end;

    function u2.Interrupt(p16, p17) -- Line: 169
        -- upvalues: u2 (copy)
        u2.Interrupted:Fire(p16, p17);
    end;

    function u2.GetInterruptSignal(u18, p19) -- Line: 173
        -- upvalues: Trove (ref), Signal (ref), u2 (copy)
        local u20 = p19 or {};
        local u21 = Trove.new();
        local u22 = Signal.new();

        local function Callback(p23, p24) -- Line: 179
            -- upvalues: u22 (copy)
            u22:Fire(p23, p24);
        end;

        u21:Add(u2.Interrupted:Connect(function(p25, p26) -- Line: 183
            -- upvalues: u18 (copy), u20 (copy), Callback (copy)
            if u18 == p25 then
                local v27 = {
                    Stop = false,
                    Pause = false
                };

                if u20.Stun ~= false and p26.Type == "Stunned" then
                    v27.Stop = "Stun";

                    return Callback(p26, v27);
                end;

                if u20.Ragdoll ~= false and p26.Type == "Ragdolled" then
                    v27.Stop = "Ragdoll";

                    return Callback(p26, v27);
                end;

                if u20.Counter ~= false and p26.Type == "Countered" then
                    v27.Stop = "Counter";

                    return Callback(p26, v27);
                end;

                if u20.PerfectBlocked == false or p26.Type ~= "PerfectBlocked" then
                    return Callback(p26, v27);
                end;

                v27.Stop = "PerfectBlocked";

                return Callback(p26, v27);
            end;
        end));
        local DisconnectAll = u22.DisconnectAll;

        function u22.DisconnectAll(p28) -- Line: 215
            -- upvalues: u21 (copy), DisconnectAll (copy)
            u21:Destroy();
            DisconnectAll(p28);
        end;

        u22.Destroy = u22.DisconnectAll;

        return u22;
    end;

    function u2.OnInterrupt(u29, u30, p31) -- Line: 224
        -- upvalues: Trove (ref), u2 (copy)
        local u32 = type(p31) ~= "table" and {} or p31;
        local u33 = Trove.new();
        u33:Connect(u2.Interrupted, function(p34, p35) -- Line: 227
            -- upvalues: u29 (copy), u32 (ref), u33 (copy), u30 (copy)
            if u29 ~= p34 then
                return;
            end;

            if not u32.Types or table.find(u32.Types, p35.Type) then
                u33:Destroy();

                return u30(p35);
            end;
        end);

        return u33;
    end;

    if Core.Context == "Client" then
        u2.ActiveUpdated = Signal.new();
        u2.ActiveTable = {};

        function u2.GetActiveTable(u36) -- Line: 240
            -- upvalues: u2 (copy), Trove (ref)
            local v37 = u2.ActiveTable[u36];

            if u36:IsDescendantOf(workspace) then
                if not v37 then
                    v37 = {};
                    u2.ActiveTable[u36] = v37;
                    local u38 = Trove.new();
                    u38:AttachToInstance(u36);
                    u38:Connect(u36.AncestryChanged, function() -- Line: 249
                        -- upvalues: u36 (copy), u38 (copy)
                        if not u36:IsDescendantOf(game) then
                            u38:Destroy();
                        end;
                    end);
                    u38:Add(function() -- Line: 255
                        -- upvalues: u2 (ref), u36 (copy)
                        u2.ActiveTable[u36] = nil;
                    end);
                end;

                return v37;
            end;
        end;

        function u2.SetActive(p39, p40, p41) -- Line: 262
            -- upvalues: u2 (copy)
            if p39:GetAttribute("TrueURF") then
                return;
            end;

            local v42 = u2.GetActiveTable(p39);

            if not v42 then
                return;
            end;

            if p41 then
                v42[p40] = {
                    Priority = p41.Priority or u2.Enums.Active.Main
                };
            else
                v42[p40] = nil;
            end;

            u2.ActiveUpdated:Fire(p39, p40, p41);
        end;

        function u2.IsActive(p43, p44) -- Line: 280
            -- upvalues: u2 (copy)
            local v45 = typeof(p44) == "number" and {
                Priority = p44
            } or p44 or {};
            local MinPriority = v45.MinPriority;
            local v46 = v45.MaxPriority or v45.Priority;
            local Ignore = v45.Ignore;

            for i, v in pairs(u2.GetActiveTable(p43)) do
                if not (Ignore and table.find(Ignore, i)) and (v.Priority and (not MinPriority or MinPriority <= v.Priority) and (not v46 or v.Priority <= v46)) then
                    return true;
                end;
            end;

            return false;
        end;

        function u2.GetActive(p47, p48) -- Line: 303
            -- upvalues: u2 (copy)
            for i, v in pairs(u2.GetActiveTable(p47)) do
                if i == p48 then
                    return v;
                end;
            end;

            return nil;
        end;
    end;
end;

function v1.Start(u49) -- Line: 314
    -- upvalues: Core (copy)
    if Core.Context == "Client" then
        u49.Remotes.Interrupted:Connect(function(p50) -- Line: 316
            -- upvalues: u49 (copy)
            u49.Interrupt(unpack(p50));
        end);
        u49.Remotes.ActiveChanged:Connect(function(p51) -- Line: 320
            -- upvalues: u49 (copy)
            if not p51[1] then
                return;
            end;

            u49.SetActive(unpack(p51));
        end);
    end;
end;

return v1;