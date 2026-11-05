  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local StatsFolder = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("StatsFolder");
local Abilities = require(game.ReplicatedStorage.ReplicatedRoot.Libraries.Abilities);
local AbilityService = require(game.ReplicatedStorage.ReplicatedRoot.Services.Gameplay.AbilityService);
local u1 = {
    Stats = {},
    BaseStats = require(script.BaseStats)
};
local u2 = {};

for i, v in u1.BaseStats.Stats do
    v.MoveName = i;
end;

function u1.GetBaseStats() -- Line: 49
    -- upvalues: u1 (copy)
    return u1.BaseStats;
end;

function u1.AddDefaultValues(p3, p4, p5) -- Line: 54
    -- upvalues: u1 (copy), TableUtil (copy)
    local Stats = p3.Stats;
    local Moveset = p3.Moveset;
    local v6 = Moveset and (Moveset.MovesInfo or {}) or {};
    local v7 = Moveset and (Moveset.Groups or {}) or {};
    local v8 = Moveset and Moveset.DefaultMoveState or "Universal";

    for i, v in Stats do
        v.MoveName = i;

        if p4 then
            v.AbilityName = p4;
        end;

        if p5 then
            v.SkinName = p5;
        end;

        local function FindMoveStats(p9, p10) -- Line: 67
            -- upvalues: Stats (copy), u1 (ref)
            if p9 == "self" then
                return Stats[p10];
            end;

            local v11 = u1.GetStats(p9) or u1.GetStats("Combat");

            return v11 and v11.Stats and v11.Stats[p10];
        end;

        if type(v.From) == "string" then
            local v12 = string.split(v.From, ".");
            local v13 = v12[1];
            local v14 = v12[2];

            if not (v13 and v14) then
                return;
            end;

            local v15;

            if v13 == "self" then
                v15 = Stats[v14];
            else
                local v16 = u1.GetStats(v13) or u1.GetStats("Combat");
                v15 = v16 and v16.Stats and v16.Stats[v14];
            end;

            if v15 then
                Stats[i] = TableUtil.Reconcile(v, v15);
            end;
        elseif type(v.From) == "table" then
            for i2, v2 in pairs(v.From) do
                local v17 = string.split(i2, ".");
                local v18 = v17[1];
                local v19 = v17[2];

                if v18 and v19 then
                    local v20;

                    if v18 == "self" then
                        v20 = Stats[v19];
                    else
                        local v21 = u1.GetStats(v18) or u1.GetStats("Combat");
                        v20 = v21 and v21.Stats and v21.Stats[v19];
                    end;

                    if v20 then
                        local v22 = TableUtil.Reconcile(Stats[v2] or v[v2], v20);

                        if Stats[v2] then
                            Stats[v2] = v22;
                        end;

                        if v[v2] then
                            v[v2] = v22;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if p3.BaseStats == false then
        return;
    end;

    for i, v in u1.BaseStats.Stats do
        if not Stats[i] then
            Stats[i] = v;
            v6[i] = TableUtil.Copy(u1.BaseStats.MovesInfo[i], true);
            local State = v6[i].State;

            if State then
                if State and not v7[State] then
                    v7[State] = u1.BaseStats.MoveGroups[State];
                end;
            else
                v6[i].State = v8;
            end;
        end;
    end;

    if u1.BaseStats.MoveGroups then
        for i, v in u1.BaseStats.MoveGroups do
            v7[i] = v;
        end;
    end;
end;

function u1.ReconcileAnimations(p23, p24) -- Line: 127
    local v25 = {};

    for _, v in pairs(p23) do
        for i, _ in pairs(v) do
            v25[i] = true;
        end;
    end;

    for i, v in pairs(p24) do
        for i2, v2 in pairs(v) do
            if not v25[i2] then
                if not p23[i] then
                    p23[i] = {};
                end;

                p23[i][i2] = v2;
                v25[i2] = true;
            end;
        end;
    end;
end;

function u1.LoadStats(p26, p27, p28) -- Line: 147
    -- upvalues: StatsFolder (copy), Abilities (copy), u1 (copy), TableUtil (copy), AbilityService (copy)
    local v29 = StatsFolder:FindFirstChild((p28 or {}).FolderName or p26);
    local v30 = Abilities.GetAbilityInfo(p26);

    if not v29 and (v30 and v30.IsLegacy ~= true) then
        v29 = StatsFolder.Unknown_Ability;
    end;

    if not v29 then
        return;
    end;

    local v31 = p27 or p26;

    if not v31 then
        warn("No Name");

        return;
    end;

    local v32 = v29:FindFirstChild(v31) or (v29:FindFirstChild(p26) or nil);

    if not v32 and (v30 and v30.IsLegacy ~= true) then
        v32 = StatsFolder.Unknown_Ability.Unknown_Ability;
    end;

    if not v32 then
        return;
    end;

    if not u1.Stats[p26] then
        u1.Stats[p26] = {};
    end;

    if u1.Stats[p26][v31] then
        return;
    end;

    local v33 = TableUtil.Copy(require(v32), true);

    if v30 and v30.IsLegacy ~= true then
        local v34 = AbilityService.GetAbilityData({
            Ability = p26,
            Skin = p27
        });

        if v34 and v34.MasteryData then
            v33.MasteryData = TableUtil.Copy(v34.MasteryData, true);
        end;
    end;

    if v33.Inherit then
        local AbilityName = v33.Inherit.AbilityName;
        local SkinName = v33.Inherit.SkinName;
        local v35 = u1.GetStats(AbilityName, SkinName);

        if not v35 then
            local v36;

            if SkinName then
                v36 = string.format("Cannot find stats\nAbilityName: %s\nSkinName: %s", AbilityName, SkinName);
            else
                v36 = string.format("Cannot find stats\nAbilityName: %s", AbilityName);
            end;

            warn(v36, debug.traceback());

            return;
        end;

        if v33.Metadata then
            if v33.Metadata.ReconcileMetadata ~= false and v35.Metadata then
                v33.Metadata = TableUtil.Reconcile(v33.Metadata, v35.Metadata);
            end;
        else
            v33.Metadata = v35.Metadata;
        end;

        local v37 = v33.Metadata or {};
        v33.Moveset = v35.Moveset;

        if v33.Stats then
            v33.Stats = TableUtil.Reconcile(v33.Stats, v35.Stats);
        else
            v33.Stats = TableUtil.Copy(v35.Stats, true);
        end;

        if not v33.QuoteInfo and (type(v35.QuoteInfo) == "table" and v37.CopyQuotes ~= false) then
            v33.QuoteInfo = TableUtil.Copy(v35.QuoteInfo, true);
        end;

        if v33.Sounds and v37.ReconcileSounds ~= false then
            v33.Sounds = TableUtil.Reconcile(v33.Sounds, v35.Sounds);
        elseif not v33.Sounds then
            v33.Sounds = v35.Sounds;
        end;

        if v33.Animations then
            u1.ReconcileAnimations(v33.Animations, v35.Animations);
        else
            v33.Animations = TableUtil.Copy(v35.Animations, true);
        end;

        v33.ComboLock = v35.ComboLock;
    end;

    if v33.Moveset then
        if type(v33.Moveset.Moves) == "table" then
            if not v33.Moveset.Moves.Run then
                v33.Moveset.Moves.Run = "RUN";
            end;

            if not v33.Moveset.Moves.Lock then
                v33.Moveset.Moves.Lock = "LOCK";
            end;
        end;

        if v33.Moveset.MovesInfo then
            if not v33.Moveset.DefaultMoveState then
                v33.Moveset.DefaultMoveState = "Universal";
            end;

            local DefaultMoveState = v33.Moveset.DefaultMoveState;

            for _, v in v33.Moveset.MovesInfo do
                if not v.State then
                    v.State = DefaultMoveState;
                end;
            end;

            if type(v33.Moveset.Groups) == "table" and not v33.Moveset.Groups[DefaultMoveState] then
                v33.Moveset.Groups[DefaultMoveState] = {
                    Visible = true,
                    Priority = 100
                };
            end;
        end;
    end;

    u1.AddDefaultValues(v33, p26, p27);
    u1.Stats[p26][v31] = v33;
end;

function u1.GetStats(p38, p39) -- Line: 280
    -- upvalues: u2 (copy), u1 (copy)
    if p38 then
        local v40 = {};
        local v41 = p39 or p38;

        if u2[p38] then
            v40.FolderName = u2[p38];
        end;

        if not u1.Stats[p38] then
            u1.Stats[p38] = {};
        end;

        if v41 and not u1.Stats[p38][v41] then
            u1.LoadStats(p38, v41, v40);
        end;

        return u1.Stats[p38][v41];
    end;

    warn(p38);
end;

function u1.PrintSounds(p42, p43) -- Line: 296
    -- upvalues: u1 (copy)
    local v44 = u1.GetStats(p42, p43);
    local u45 = {};

    local function AddSound(p46) -- Line: 299
        -- upvalues: u45 (copy), AddSound (copy)
        for i, v in pairs(p46) do
            if i == "SoundId" then
                local v47 = table.concat(tostring(v):split("rbxassetid://"));

                if not table.find(u45, v47) then
                    table.insert(u45, v47);
                end;
            elseif type(v) == "table" then
                AddSound(v);
            end;
        end;
    end;

    AddSound(v44.Stats);
    AddSound(v44.QuoteInfo or {});

    for _, v in pairs(v44.Sounds) do
        if v.SoundId then
            local v48 = table.concat(tostring(v.SoundId):split("rbxassetid://"));

            if not table.find(u45, v48) then
                table.insert(u45, v48);
            end;
        end;
    end;

    warn(table.concat(u45, ","));
end;

local function test() -- Line: 325
    -- upvalues: Knit (copy), u1 (copy)
    Knit.OnStart():await();
    u1.PrintSounds("Kuro Claws", "Wolverine");
    print("----------------------");
    u1.PrintSounds("Kuro Claws", "Freddy Krueger");
    print("----------------------");
    u1.PrintSounds("Suna");
    print("----------------------");
    u1.PrintSounds("Suna", "Yami");
    print("----------------------");
    u1.PrintSounds("Suna", "Frozen Hook");
    print("----------------------");
end;

return u1;