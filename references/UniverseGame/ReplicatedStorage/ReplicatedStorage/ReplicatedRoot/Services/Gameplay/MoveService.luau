  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local u1;

if game:GetService("RunService"):IsServer() then
    u1 = game.ServerStorage.ServerRoot;
else
    u1 = nil;
end;

local Core = require(ReplicatedRoot.Core);
local WorldService = require(ReplicatedRoot.Services.Gameplay.WorldService);
local AbilityService = require(ReplicatedRoot.Services.Gameplay.AbilityService);
local MoveAction = require(ReplicatedRoot.Libraries.Gameplay.Classes.MoveAction);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
local Replica = require(ReplicatedRoot.Libraries.Networking.Replica);
local u2;

if Core.Context == "Server" then
    u2 = Replica.Token("Move") or nil;
else
    u2 = nil;
end;

local u3 = {
    Name = "MoveService"
};
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);

function u3.GetMoveFlags(p4) -- Line: 37
    -- upvalues: WorldService (copy)
    return WorldService.GetCharacterEntity(p4).MoveFlags or {};
end;

function u3.GetMoveFlag(p5, p6) -- Line: 42
    -- upvalues: u3 (copy)
    return u3.GetMoveFlags(p5)[p6];
end;

function u3.SetMoveFlag(p7, p8, p9, p10) -- Line: 47
    -- upvalues: WorldService (copy), Core (copy)
    local v11 = WorldService.GetCharacterEntity(p7);

    if v11 then
        if v11.Replica and (Core.Context == "Server" and p10 ~= false) then
            v11.Replica:Set({ "MoveFlags", p8 }, p9);
        end;

        v11.MoveFlags[p8] = p9;
        v11.MoveFlagChanged:Fire(p8, p9);
    end;
end;

function u3.GetMoves(p12) -- Line: 58
    -- upvalues: WorldService (copy)
    local v13 = WorldService.GetCharacterEntity(p12);

    return v13 and v13.Moves or {};
end;

function u3.FindMoves(p14, p15) -- Line: 63
    -- upvalues: u3 (copy)
    local v16 = u3.GetMoves(p14);
    local v17 = p15 or {};
    local v18 = v17.Name or nil;
    local IncludeFlags = v17.IncludeFlags;
    local ExcludeFlags = v17.ExcludeFlags;
    local v19 = v17.IncludeMode or "All";
    local Enabled = v17.Enabled;
    local Check = v17.Check;
    local Bound = v17.Bound;
    local v20 = {};

    for _, v in pairs(v16) do
        if (v18 == nil or v.Name == v18) and (Enabled ~= true or v:IsEnabled() ~= false) then
            local _ = Check == true;

            if Bound ~= true or #v.Binds > 0 then
                local v21;

                if IncludeFlags == nil then
                    if ExcludeFlags == nil then
                        table.insert(v20, v);
                    else
                        v21 = true;

                        for i in pairs(ExcludeFlags) do
                            if v.Flags[i] then
                                v21 = false;
                            end;
                        end;

                        if v21 ~= false then
                            table.insert(v20, v);
                        end;
                    end;
                else
                    local v22 = v19 == "All";

                    for i, v2 in pairs(v.Flags) do
                        if IncludeFlags[i] == v2 or u3.GetMoveFlag(p14, i) == v2 then
                            if v19 == "Single" then
                                v22 = false;
                                break;
                            end;
                        elseif v19 == "All" then
                            v22 = false;
                            break;
                        end;
                    end;

                    if v22 ~= false then
                        if ExcludeFlags == nil then
                            table.insert(v20, v);
                        else
                            v21 = true;

                            for i in pairs(ExcludeFlags) do
                                if v.Flags[i] then
                                    v21 = false;
                                end;
                            end;

                            if v21 ~= false then
                                table.insert(v20, v);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    table.sort(v20, function(p23, p24) -- Line: 130
        return (p23.Priority or 0) > (p24.Priority or 0);
    end);

    return v20;
end;

function u3.FindFirstMove(p25, p26) -- Line: 137
    -- upvalues: u3 (copy)
    return u3.FindMoves(p25, p26)[1];
end;

function u3.CreateMoveReplica(p27) -- Line: 141
    -- upvalues: Core (copy), Replica (copy), u2 (copy)
    if Core.Context == "Server" then
        return Replica.New({
            Token = u2,
            Tags = {
                Character = p27.Character
            },
            Data = {
                Name = p27.Name,
                Enabled = p27.Enabled,
                Priority = p27.Priority,
                Binds = p27.Binds,
                Flags = p27.Flags,
                Replication = {}
            }
        });
    end;
end;

function u3.GetMoveData(p28) -- Line: 164
    -- upvalues: AbilityService (copy), TableUtil (copy), CommonUtil (copy)
    local v29 = p28 or {};
    local Ability = v29.Ability;
    local Name = v29.Name;
    local v30 = v29.Data or nil;
    local v31 = v29.ExtraData or nil;
    local u32 = nil;

    if typeof(Ability) == "string" then
        u32 = AbilityService.GetAbilityData({
            Ability = Ability
        });
    elseif typeof(Ability) == "table" then
        u32 = Ability.Data;
    end;

    if u32 ~= nil and u32.Moves then
        local v33 = u32.Moves[Name];

        if v33 ~= nil then
            v30 = TableUtil.Reconcile(v30 or {}, v33);
        end;
    end;

    local v34 = TableUtil.Reconcile(v31 or {}, v30 or {});

    if v34.From then
        CommonUtil.ReconcileData(v34, {
            Directory = {
                Roots = { function(p35) -- Line: 193
                        -- upvalues: u32 (ref)
                        local Path = p35.Path;

                        if Path[1] == "@Ability" then
                            local v36 = "";

                            for i = 3, #Path do
                                v36 = v36 .. Path[i] .. (i < #Path and "/" or "");
                            end;

                            return u32.Moves and u32.Moves[v36] or nil;
                        end;
                    end, function(p37) -- Line: 203
                        -- upvalues: AbilityService (ref)
                        local Path = p37.Path;

                        if Path[1] == "@Abilities" then
                            local v38 = AbilityService.GetAbilityData({
                                Ability = Path[2]
                            });
                            local v39 = "";

                            for i = 3, #Path do
                                v39 = v39 .. Path[i] .. (i < #Path and "/" or "");
                            end;

                            return v38.Moves and v38.Moves[v39] or nil;
                        end;
                    end }
            }
        });
    end;

    v34.Name = v34.Name or Name;

    return v34;
end;

function u3.CreateMove(p40, p41) -- Line: 225
    -- upvalues: WorldService (copy), u3 (copy), MoveAction (copy), Core (copy), u1 (copy), ReplicatedRoot (copy)
    local u42 = WorldService.GetCharacterEntity(p40);
    local v43 = p41 or {};
    local Ability = v43.Ability;
    local Name = v43.Name;
    local _ = v43.ExtraData or nil;

    if Ability ~= nil and ((v43.Data or nil) == nil and Name ~= nil) then
        local _ = Ability.Data.Moves and Ability.Data.Moves[Name];
    end;

    local v44 = u3.GetMoveData(v43);
    local u45 = u42.Collector:Construct(MoveAction, p40, v44);
    local v46 = Ability ~= nil and Ability.Replica;

    if not v46 then
        if u42 then
            v46 = u42.Replica or nil;
        else
            v46 = nil;
        end;
    end;

    if v46 and Core.Context == "Server" then
        local v47 = u45.Collector:Construct(u3.CreateMoveReplica, u45);
        u45.Replica = v47;
        v47.Move = u45;
        v47.TargetParent = v46;
    end;

    if Core.Context == "Server" then
        require(u1.Libraries.Gameplay.Classes.MoveActionServer).new(u45);
    elseif Core.Context == "Client" then
        require(ReplicatedRoot.Libraries.Gameplay.Classes.MoveActionClient).new(u45);
    end;

    u45.Collector:Add(function() -- Line: 261
        -- upvalues: u42 (copy), u45 (copy)
        if not (u42 and u42.Moves) then
            return;
        end;

        local v48 = table.find(u42.Moves, u45);

        if v48 then
            table.remove(u42.Moves, v48);
        end;

        u42.MoveRemoved:Fire(u45);
    end);
    table.insert(u42.Moves, u45);
    u42.MoveAdded:Fire(u45);

    return u45;
end;

function u3.SpawnMove(p49) -- Line: 278
end;

function u3._Init() -- Line: 282
    -- upvalues: Core (copy), Replica (copy), WorldService (copy), u3 (copy)
    if Core.Context == "Client" then
        Replica.OnNew("Move", function(p50) -- Line: 284
            -- upvalues: WorldService (ref), u3 (ref)
            local Character = p50.Tags.Character;
            WorldService.AwaitCharacterEntity(p50.Tags.Character);
            local v51;

            if p50.Parent then
                v51 = p50.Parent.Ability or nil;
            else
                v51 = nil;
            end;

            local _ = v51 == nil or (v51.Data.Moves == nil or not v51.Data.Moves[p50.Data.Name]);
            local u52 = u3.CreateMove(Character, {
                Name = p50.Data.Name,
                Ability = v51,
                ExtraData = p50.Data.Replication or {}
            });
            p50.Maid:Add(u52);

            if u52.Data.Activate == nil then
                function u52.Data.Activate(p53, p54) -- Line: 299
                    return p53:ActivateServer(p54):expect();
                end;
            end;

            if u52.Data.Deactivate == nil then
                function u52.Data.Deactivate(p55, p56) -- Line: 305
                    return p55:DeactivateServer(p56):expect();
                end;
            end;

            if p50.Data.Enabled then
                u52:Enable();
            else
                u52:Disable();
            end;

            p50:OnSet({ "Enabled" }, function(p57) -- Line: 316
                -- upvalues: u52 (copy)
                if p57 == true then
                    u52:Enable();

                    return;
                end;

                u52:Disable();
            end);

            if p50.Data.Priority then
                u52:SetPriority(p50.Data.Priority);
            end;

            p50:OnSet({ "Priority" }, function(p58) -- Line: 327
                -- upvalues: u52 (copy)
                if p58 == true then
                    u52:Enable();

                    return;
                end;

                u52:Disable();
            end);

            if p50.Data.Flags then
                for i, v in pairs(p50.Data.Flags) do
                    u52.Flags[i] = v;
                end;
            end;

            if p50.Data.Binds then
                for i, v in pairs(p50.Data.Binds) do
                    u52:SetBind(i, v);
                end;
            end;

            if p50.Data.Metadata then
                for i, v in pairs(p50.Data.Metadata) do
                    u52.Metadata[i] = v;
                end;
            end;

            p50:OnChange(function(p59, p60, p61) -- Line: 350
                -- upvalues: u52 (copy)
                if p59 == "Set" then
                    if p60[1] == "Flags" then
                        if p60[2] then
                            u52.Flags[p60[2]] = p61;

                            return;
                        end;

                        u52.Flags = p61;

                        return;
                    end;

                    if p60[1] == "Binds" then
                        if not p60[2] then
                            local Binds = u52.Binds;

                            for _, v in pairs(Binds) do
                                u52.OnUnbind:Fire(v);
                            end;

                            u52.Binds = p61;

                            for i, v in pairs(p61) do
                                u52.OnBind:Fire(v, Binds[i]);
                            end;

                            return;
                        end;

                        local v62 = u52.Binds[p60[2]];
                        u52.Binds[p60[2]] = p61;

                        if v62 then
                            u52.OnUnbind:Fire(v62);
                        end;

                        if p61 then
                            u52.OnBind:Fire(p61);
                        end;
                    elseif p60[1] == "Metadata" then
                        if p60[2] then
                            u52.Metadata[p60[2]] = p61;

                            return;
                        end;

                        u52.Metadata = p61;
                    end;
                end;
            end);
            u52.Replica = p50;
            p50.Move = u52;

            if v51 then
                v51:AddMove(u52);
            end;
        end);
    end;
end;

return u3;