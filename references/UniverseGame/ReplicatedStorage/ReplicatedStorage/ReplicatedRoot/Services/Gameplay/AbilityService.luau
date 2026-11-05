  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local u1;

if game:GetService("RunService"):IsServer() then
    u1 = game.ServerStorage.ServerRoot;
else
    u1 = nil;
end;

local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
require(ReplicatedRoot.Libraries.Utility.InputUtil);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
local Ability = require(ReplicatedRoot.Libraries.Gameplay.Classes.Ability);
local Entry = require(script.Entry);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Abilities = require(ReplicatedRoot.Libraries.Abilities);
local WhitelistHandler = require(game.ReplicatedStorage.ReplicatedModules.Handlers.WhitelistHandler);
local u2;

if u1 then
    u2 = require(u1.Libraries.Permissions);
else
    u2 = nil;
end;

local Replica = require(ReplicatedRoot.Libraries.Networking.Replica);
local u3;

if Core.Context == "Server" then
    u3 = Replica.Token("Ability") or nil;
else
    u3 = nil;
end;

local _ = Core.Context == "Server" and Replica.Token("AbilityData");
local WorldService = require(ReplicatedRoot.Services.Gameplay.WorldService);
local LogService = require(ReplicatedRoot.Services.LogService);
require(ReplicatedRoot.Services.AudioService);
require(ReplicatedRoot.Services.Gameplay.SkinService);
local u4 = {
    Name = "AbilityService",
    Entries = {},
    Cache = {},
    DataReplicas = {},
    AbilityCached = Signal.new()
};
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);

function u4.GetAbilityInfo(p5) -- Line: 53
    -- upvalues: Abilities (copy)
    return Abilities.GetAbilityInfo(p5);
end;

function u4.IsLegacyAbility(p6) -- Line: 57
    -- upvalues: u4 (copy)
    local v7 = u4.GetAbilityInfo(p6);

    if v7 then
        return v7.IsLegacy;
    end;

    return false;
end;

function u4.GetAbilityName(p8) -- Line: 62
    -- upvalues: Abilities (copy)
    return Abilities.GetAbilityName(p8);
end;

function u4.GetAbilityId(p9) -- Line: 66
    -- upvalues: Abilities (copy)
    return Abilities.GetAbilityId(p9);
end;

function u4.IsAbilityUsable(p10, p11) -- Line: 70
    -- upvalues: u4 (copy), Core (copy), u2 (copy), WhitelistHandler (copy)
    local v12 = u4.GetAbilityInfo(p11);

    if v12 then
        if v12.IsPublic then
            return true;
        end;

        if v12.UseFlags then
            local v13 = true;

            for i, v in pairs(v12.UseFlags) do
                if Core.Flags[i] ~= v then
                    v13 = false;
                    break;
                end;
            end;

            if v13 then
                return true;
            end;
        end;

        if Core.Context == "Server" and table.find(u2.Developer, p10.UserId) then
            return true;
        end;

        if Core.Environment == "Studio" then
            return true;
        end;

        if WhitelistHandler.IsUserWhitelistedForAbilityId(p10.UserId, v12.Id) then
            return true;
        end;
    end;

    return false;
end;

function u4.GetAbilityEntry(p14) -- Line: 103
    -- upvalues: u4 (copy), Entry (copy), ReplicatedRoot (copy), u1 (copy)
    local v15 = u4.Entries[p14];

    if v15 == nil then
        v15 = Entry.new((`Abilities/{p14}`));
        v15.Metadata.Skins = {};
        v15.Metadata.Variants = {};
        u4.Entries[p14] = v15;
    end;

    local v16 = v15.Objects.ReplicatedFolder == nil and ReplicatedRoot.Assets.Abilities:FindFirstChild(p14);

    if v16 then
        v15:SetReplicatedFolder(v16);
    end;

    local v17 = u1 ~= nil and v15.Objects.ServerFolder == nil and u1.Assets.Abilities:FindFirstChild(p14);

    if v17 then
        v15:SetServerFolder(v17);
    end;

    if v15.Changed then
        v15:GenerateData();
    end;

    return v15;
end;

function u4.GetSkinEntry(p18, p19) -- Line: 133
    -- upvalues: u4 (copy), Entry (copy), u1 (copy)
    local v20 = u4.GetAbilityEntry(p18);
    local v21 = v20.Metadata.Skins[p19];

    if v21 == nil then
        v21 = Entry.new((`Abilities/{p18}/Skins{p19}`));
        v20.Metadata.Skins[p19] = v21;
    end;

    if v20.Objects.ReplicatedFolder and v21.Objects.ReplicatedFolder == nil then
        local Skins = v20.Objects.ReplicatedFolder:FindFirstChild("Skins");
        local v22;

        if Skins then
            v22 = Skins:FindFirstChild(p19);
        else
            v22 = nil;
        end;

        if v22 then
            v21:SetReplicatedFolder(v22);
        end;
    end;

    if u1 ~= nil and (v20.Objects.ServerFolder and v21.Objects.ServerFolder == nil) then
        local Skins = v20.Objects.ServerFolder:FindFirstChild("Skins");
        local v23;

        if Skins then
            v23 = Skins:FindFirstChild(p19);
        else
            v23 = nil;
        end;

        if v23 then
            v21:SetServerFolder(v23);
        end;
    end;

    if v21.Changed then
        v21:GenerateData();
    end;

    return v21;
end;

local function DataTransformer(p24, p25, p26) -- Line: 164
    -- upvalues: u4 (copy)
    local v27 = string.split(p26, "/");

    if v27[2] == "Skins" then
        return u4.GetSkinEntry(v27[1], v27[3]).Data;
    end;

    return u4.GetAbilityEntry(p26).Data;
end;

function u4.GetAbilityData(p28) -- Line: 173
    -- upvalues: u4 (copy), TableUtil (copy), CommonUtil (copy), DataTransformer (copy)
    local v29 = p28 or {};
    local v30 = u4.GetAbilityName(v29.Ability);
    local Skin = v29.Skin;
    local v31 = u4.GetAbilityEntry(v30);
    local v32 = nil;
    local v33 = false;
    local v34 = false;
    local v35 = `{v30}`;
    local v36 = u4.Cache[v35];

    if Skin and Skin ~= "" then
        v35 = v35 .. `::{Skin}`;
    end;

    if v36 and v29.Cache ~= false then
        v33 = true;

        if v31.Version == v36.Version then
            v32 = v36.Data;
        else
            v34 = true;
        end;
    end;

    if v33 == false or v34 == true then
        v32 = TableUtil.Reconcile(v31.Data, {
            Name = v30
        });

        local function Reconcile(p37) -- Line: 204
            -- upvalues: u4 (ref), Reconcile (copy), TableUtil (ref)
            if p37.From ~= nil then
                for i, v in pairs(p37.From) do
                    local v38 = v["@All"];
                    local v39 = u4.GetAbilityEntry(i);
                    local v40 = Reconcile(table.clone(v39.Data));

                    for i2, v2 in pairs(v40) do
                        if i2 ~= "From" and (v38 == true and v[i2] ~= false) then
                            if typeof(p37[i2]) == "table" and typeof(v2) == "table" then
                                p37[i2] = TableUtil.Reconcile(p37[i2], v2);
                            elseif p37[i2] == nil then
                                if typeof(v2) == "table" then
                                    p37[i2] = TableUtil.Copy(v2, true);
                                else
                                    p37[i2] = v2;
                                end;
                            end;
                        end;
                    end;

                    for i2, v2 in pairs(v) do
                        if i2 ~= "From" then
                            local v41 = v40[i2];

                            if v41 ~= nil and (v38 ~= true and v2 == true) then
                                if typeof(p37[i2]) == "table" and typeof(v41) == "table" then
                                    p37[i2] = TableUtil.Reconcile(p37[i2], v41);
                                elseif p37[i2] == nil then
                                    if typeof(v41) == "table" then
                                        p37[i2] = TableUtil.Copy(v41, true);
                                    else
                                        p37[i2] = v41;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            return p37;
        end;

        if v32.From then
            CommonUtil.ReconcileData(v32, {
                Transformer = DataTransformer
            });
        end;

        local v42;

        if Skin == nil or Skin == "" then
            v42 = nil;
        else
            v42 = u4.GetSkinEntry(v30, Skin);
            local v43 = TableUtil.Reconcile(v42.Data, {
                Skin = Skin
            });

            if v43.From then
                CommonUtil.ReconcileData(v43, {
                    Transformer = DataTransformer
                });
            end;

            v32 = TableUtil.Reconcile(v43, v32);
        end;

        v32.Directory = {
            Roots = {
                { "@AbilityEntry", v31 },
                { "@AbilityData", v32 },
                { "@Animations", v32.Animations },
                { "@Sounds", v32.Sounds },
                { "@RigInfo", v32.RigInfo }
            }
        };

        if v42 then
            for _, v in pairs(v42.Directory.Roots) do
                table.insert(v32.Directory.Roots, v);
            end;
        end;

        for _, v in pairs(v31.Directory.Roots) do
            table.insert(v32.Directory.Roots, v);
        end;

        if not v36 and v29.Cache ~= false or v34 then
            u4.Cache[v35] = {
                Version = v31.Version,
                Data = v32
            };
            u4.AbilityCached:Fire(v30, v32);
            v33 = true;
        end;
    end;

    if v29.Transformer then
        if v33 then
            v32 = TableUtil.Copy(v32, true);
        end;

        v32 = v29.Transformer(v32, v29) or v32;
    end;

    return v32;
end;

function u4.GetAbilities(p44) -- Line: 317
    -- upvalues: WorldService (copy)
    local v45 = WorldService.GetCharacterEntity(p44);

    return not v45 and {} or v45.Abilities;
end;

function u4.GetAbility(p46, p47) -- Line: 325
    -- upvalues: u4 (copy)
    for _, v in pairs(u4.GetAbilities(p46)) do
        if v.Name == p47 or p47 == nil then
            return v;
        end;
    end;

    return nil;
end;

function u4.CreateAbility(p48, p49) -- Line: 334
    -- upvalues: WorldService (copy), u4 (copy), Ability (copy), Core (copy), Replica (copy), u3 (copy), u1 (copy), ReplicatedRoot (copy), LogService (copy)
    local u50 = WorldService.GetCharacterEntity(p48);
    local v51 = u4.GetAbilityName(p49.Ability);
    local v52 = u4.GetAbility(p48, v51);

    if v52 ~= nil then
        return v52;
    end;

    local v53 = u4.GetAbilityData({
        Cache = false,
        Ability = v51,
        Skin = p49.Skin
    });
    local u54 = u50.Collector:Construct(Ability, p48, v53);

    if u50.Replica ~= nil and Core.Context == "Server" then
        local u55 = Replica.New({
            Token = u3,
            Data = {
                Character = p48,
                Name = u54.Name,
                Id = u54.Id,
                Skin = u54.Skin,
                Active = u54.Active
            }
        });
        u54.Collector:Connect(u54.Activated, function() -- Line: 360
            -- upvalues: u55 (copy)
            u55:Set({ "Active" }, true);
        end);
        u54.Collector:Connect(u54.Deactivated, function() -- Line: 363
            -- upvalues: u55 (copy)
            u55:Set({ "Active" }, false);
        end);
        u54.Replica = u55;
        u55:SetParent(u50.Replica);
    end;

    if Core.Context == "Server" then
        require(u1.Libraries.Gameplay.Classes.AbilityServer).new(u54);
    elseif Core.Context == "Client" then
        require(ReplicatedRoot.Libraries.Gameplay.Classes.AbilityClient).new(u54);
    end;

    u54.Collector:Add(function() -- Line: 379
        -- upvalues: u50 (copy), u54 (copy)
        if not (u50 and u50.Abilities) then
            return;
        end;

        local v56 = table.find(u50.Abilities, u54);

        if v56 then
            table.remove(u50.Abilities, v56);
        end;
    end);
    table.insert(u50.Abilities, u54);
    LogService.Log({
        Message = `Generated ability {u54.Name} for {p48.Name}`,
        Source = script
    });
    u54:Init();

    return u54;
end;

function u4._Init() -- Line: 401
    -- upvalues: Core (copy), Replica (copy), WorldService (copy), u4 (copy)
    if Core.Context == "Client" then
        Replica.OnNew("Ability", function(p57) -- Line: 403
            -- upvalues: WorldService (ref), u4 (ref)
            local _ = p57.Parent.Entity;
            local Character = p57.Data.Character;
            WorldService.AwaitCharacterEntity(Character);
            local v58 = u4.CreateAbility(Character, {
                Ability = p57.Data.Name,
                Skin = p57.Data.Skin
            });
            v58.Replica = p57;
            p57.Ability = v58;
            p57.Maid:Add(v58);
        end);

        return;
    end;

    local _ = Core.Context == "Server";
end;

return u4;