  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local v1 = game:GetService("RunService"):IsServer() and game.ServerStorage.ServerRoot or nil;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Classes.Trove);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Hook = require(ReplicatedRoot.Libraries.Classes.Hook);
local Entity = require(ReplicatedRoot.Libraries.Classes.Entity);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local Replica = require(ReplicatedRoot.Libraries.Networking.Replica);
local Abilities = require(ReplicatedRoot.Libraries.Abilities);
local Skins = require(ReplicatedRoot.Libraries.Skins);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
local Character = require(ReplicatedRoot.Assets.Classes.Character);
local CombatService = require(ReplicatedRoot.Services.CombatService);
local u2;

if v1 == nil then
    u2 = false;
else
    u2 = require(v1.Assets.Classes.CharacterServer);
end;

local u3 = {
    Name = "WorldService",
    EntityAdded = Signal.new(),
    Entities = {},
    Bindings = {},
    Characters = {},
    GenerateHook = Hook.new()
};
u3.GenerateHook:CreateStack("Inbound");
u3.GenerateHook:CreateStack("Outbound");

function u3.CreateEntity(p4) -- Line: 125
    -- upvalues: Entity (copy), u3 (copy)
    local u5 = Entity.new(p4);
    u5.Collector:Add(function() -- Line: 127
        -- upvalues: u3 (ref), u5 (copy)
        local v6 = table.find(u3.Entities, u5);

        if v6 ~= nil then
            table.remove(u3.Entities, v6);
        end;

        local Object = u5.Object;

        if Object ~= nil then
            local v7 = u3.Bindings[Object];

            if v7 ~= nil then
                local v8 = table.find(v7, u5);

                if v8 then
                    table.remove(v7, v8);
                end;

                if #v7 <= 0 then
                    u3.Bindings[Object] = nil;
                end;
            end;
        end;
    end);
    table.insert(u3.Entities, u5);

    if p4 ~= nil then
        local Object = p4.Object;

        if Object ~= nil then
            if u3.Bindings[Object] == nil then
                u3.Bindings[Object] = {};
            end;

            table.insert(u3.Bindings[Object], u5);
            u5.Collector:AttachToInstance(Object);
        end;
    end;

    u3.EntityAdded:Fire(u5);

    return u5;
end;

function u3.GetEntities() -- Line: 172
    -- upvalues: u3 (copy)
    return u3.Entities;
end;

function u3.GetEntityById(p9) -- Line: 179
    -- upvalues: u3 (copy)
    for _, v in pairs(u3.GetEntities()) do
        if v.Id == p9 then
            return v;
        end;
    end;

    return nil;
end;

function u3.GetObjectEntities(p10) -- Line: 191
    -- upvalues: u3 (copy)
    return u3.Bindings[p10] or {};
end;

function u3.FindObjectEntity(p11, p12) -- Line: 198
    -- upvalues: u3 (copy)
    local v13 = u3.GetObjectEntities(p11);

    for _, v in pairs(v13) do
        if v.Name == p12 then
            return v;
        end;
    end;

    return nil;
end;

function u3.GetCharacterEntities() -- Line: 211
    -- upvalues: u3 (copy)
    local v14 = {};

    for _, v in pairs(u3.GetEntities()) do
        if v:IsClass("Character") then
            table.insert(v14, v);
        end;
    end;

    return v14;
end;

function u3.GetCharacterEntity(p15) -- Line: 224
    -- upvalues: u3 (copy)
    return u3.FindObjectEntity(p15, "Character");
end;

function u3.AwaitCharacterEntity(p16, p17) -- Line: 231
    -- upvalues: u3 (copy)
    local v18 = os.clock();
    local v19 = u3.GetCharacterEntity(p16);

    while not v19 and (p17 == nil or p17 > os.clock() - v18) do
        v19 = u3.GetCharacterEntity(p16);
        task.wait();
    end;

    return v19;
end;

function u3.CreateCharacterEntity(p20) -- Line: 248
    -- upvalues: u3 (copy), Character (copy), u2 (copy)
    local v21 = u3.GetCharacterEntity(p20);

    if v21 ~= nil then
        return v21;
    end;

    local v22 = { Character };

    if u2 ~= nil then
        table.insert(v22, u2);
    end;

    return u3.CreateEntity({
        Name = "Character",
        Object = p20,
        Classes = v22
    });
end;

function u3.GetInfo(p23) -- Line: 268
    -- upvalues: Abilities (copy), Skins (copy)
    local v24 = nil;
    local v25 = nil;

    if p23:IsA("Player") then
        v24 = p23;
        p23 = p23.Character;
    elseif p23:IsA("Model") then
        v24 = game.Players:GetPlayerFromCharacter(p23);
    else
        p23 = v25;
    end;

    local v26 = nil;

    if v24 then
        v26 = v24:FindFirstChild("Data");
    elseif not v24 and p23 then
        v26 = p23:FindFirstChild("Data");
    end;

    if not v26 then
        return {};
    end;

    local v27;

    if v26 then
        v27 = v26:FindFirstChild("Ability");
    else
        v27 = nil;
    end;

    local v28;

    if v26 then
        v28 = v26:FindFirstChild("Skin");
    else
        v28 = nil;
    end;

    local v29;

    if v27 then
        v29 = Abilities.GetAbilityInfo(v27.Value);
    else
        v29 = nil;
    end;

    local v30;

    if v28 then
        v30 = tonumber(v28.Value);
    else
        v30 = nil;
    end;

    local v31;

    if v29 and (v28 and v30) then
        v31 = Skins.GetSkinInfo(v29.Name, v30);
    else
        v31 = nil;
    end;

    local v32 = {
        Player = v24,
        Character = p23,
        Humanoid = p23:FindFirstChildWhichIsA("Humanoid"),
        RootPart = p23:FindFirstChild("HumanoidRootPart"),
        Data = v26
    };

    if v27 then
        if v29 then
            v32.Ability = {
                Id = v29.Id,
                Name = v29.Name
            };
        end;

        local v33 = v27:GetAttribute("Trait");
        local v34 = v27:GetAttribute("HexedTrait");

        if v33 then
            v32.Trait = {
                Name = v33,
                Hexed = v34 or false
            };
        end;

        local v35 = v27:GetAttribute("AbilityLevel");

        if v35 then
            v32.Level = v35;
        end;
    end;

    if v28 and v31 then
        v32.Skin = {
            Id = v31.Id,
            Name = v31.Name
        };
        local v36 = v28:GetAttribute("UnusualHueId");
        local v37 = v28:GetAttribute("UnusualCharmId");
        local v38 = v28:GetAttribute("ChromaUnusual");

        if v36 then
            v32.Skin.Unusual = {
                HueId = v36,
                CharmId = v37,
                Chroma = v38 or false
            };
        end;
    end;

    return v32;
end;

function u3.GenerateCharacter(p39, p40) -- Line: 355
    -- upvalues: TableUtil (copy), Abilities (copy), Skins (copy), u3 (copy), CombatService (copy)
    local v41 = TableUtil.Reconcile(p40 or {}, p39 or {});
    local Player = v41.Player;
    local Character2 = v41.Character;
    local CharacterModel = v41.CharacterModel;
    local Parent = v41.Parent;

    if Character2 == nil and CharacterModel then
        Character2 = CharacterModel:Clone();

        if Character2 and Parent then
            Character2.Parent = Parent;
        end;
    elseif Character2 == nil and Player then
        Character2 = Player.Character;
    end;

    if Character2 == nil then
        error("Invalid character");
    end;

    if Player == nil then
        Player = game.Players:GetPlayerFromCharacter(Character2);
    end;

    local v42 = v41.Name or (Character2.Name or "Character");
    local v43 = nil;

    if typeof(v41.Ability) == "string" or typeof(v41.Ability) == "number" then
        v43 = Abilities.GetAbilityInfo(v41.Ability);
    elseif typeof(v41.Ability) == "table" then
        if v41.Ability.Name then
            v43 = Abilities.GetAbilityInfo(v41.Ability.Name);
        elseif v41.Ability.Id then
            v43 = Abilities.GetAbilityInfo(v41.Ability.Id);
        end;
    end;

    local v44 = v43 and {
        Name = v43.Name,
        Id = v43.Id
    } or nil;
    local v45 = nil;
    local v46;

    if typeof(v41.Trait) == "string" then
        v46 = {
            Hexed = false,
            Name = v41.Trait
        };
    else
        v46 = typeof(v41.Trait) == "table" and {
            Hexed = false,
            Name = v41.Trait.Name
        } or v45;
    end;

    local v47 = nil;
    local v48 = nil;

    if v43 then
        if typeof(v41.Skin) == "string" or typeof(v41.Skin) == "number" then
            v47 = Skins.GetSkinInfo(v43.Name, v41.Skin);
        elseif typeof(v41.Skin) == "table" then
            if v41.Skin.Name then
                v47 = Skins.GetSkinInfo(v43.Name, v41.Skin.Name);
            elseif v41.Skin.Id then
                v47 = Skins.GetSkinInfo(v43.Name, v41.Skin.Id);
            end;
        end;

        if v47 then
            v48 = {
                Name = v47.Name,
                Id = v47.Id
            };

            if typeof(v41.Skin) == "table" and v41.Skin.Unusual then
                v48.Unusual = v41.Skin.Unusual;
            end;
        end;
    end;

    local v49;

    if v41.IsLiving then
        v49 = u3.CreateCharacterEntity(Character2);
    else
        v49 = u3.GetCharacterEntity(Character2);
    end;

    local v50 = CombatService.GetHook("Setup");

    if v50 then
        v50:RunHook({
            Player = Player,
            Character = Character2
        });
    end;

    local v51 = {
        Player = Player,
        Character = Character2,
        Entity = v49,
        Humanoid = Character2:FindFirstChildWhichIsA("Humanoid"),
        RootPart = Character2:FindFirstChild("HumanoidRootPart"),
        Collector = v49.Collector,
        Name = v42,
        IsLiving = v41.IsLiving or false,
        IsNPC = v41.IsNPC or false,
        Level = v41.Level,
        Ability = v44,
        Trait = v46,
        Skin = v48,
        Result = {},
        Parameters = v41
    };

    return u3.GenerateHook:RunHook(v51);
end;

function u3._Init() -- Line: 484
    -- upvalues: Core (copy), Replica (copy), u3 (copy)
    if Core.Context == "Server" then
        return;
    end;

    if Core.Context == "Client" then
        Replica.OnNew("Entity", function(p52) -- Line: 488
            -- upvalues: u3 (ref)
            local Id = p52.Tags.Id;
            local Name = p52.Tags.Name;
            local Object = p52.Tags.Object;
            local Classes = p52.Tags.Classes;
            local v53 = u3.GetEntityById(Id);

            if v53 == nil then
                v53 = u3.CreateEntity({
                    Id = Id,
                    Name = Name,
                    Object = Object,
                    Classes = Classes,
                    Replica = p52
                });
            end;

            p52.Entity = v53;
        end);
    end;
end;

function u3._Start() -- Line: 512
end;

return u3;