 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local wiki = require(ReplicatedStorage.wiki);
local permissions = require(ReplicatedStorage.permissions);
local CommandWhitelist = require(ReplicatedStorage.wiki.CommandWhitelist);
local Ranked = ReplicatedStorage.Ranked;
local table_freeze_ret = table.freeze({ 121877399209259 });
local table_freeze_ret2 = table.freeze({
    Tier1 = table.freeze({}),
    Tier2 = table.freeze({
        cc = true,
        te = true
    }),
    Tier3 = table.freeze({
        cc = true,
        te = true,
        tae = true,
        die = true,
        vt = true
    })
});
local table_freeze_ret3 = table.freeze({
    rnp = "rinnoplay",
    customclothes = "cc",
    gagapunch = "gagamarupunch",
    anp = "becomeai",
    kk = "ihatekunigami",
    b = "ball",
    yummers = "homelander",
    mc = "control",
    mindcontrol = "control",
    yuri = "yurier",
    conc = "concept",
    reddragon = "slifer",
    yugioh = "slifer",
    tp = "teleport",
    bring = "teleport",
    to = "teleport",
    invis = "invisible",
    remmy = "remmybirthday",
    ifc = "ignoreflowcooldown",
    ignoreflowcd = "ignoreflowcooldown",
    tbal = "teambalancing",
    awkt = "awaketest",
    boot = "kick",
    flip = "isagi"
});
table.freeze({
    rinnoplay = true,
    kuon = true
});
local table_freeze_ret4 = table.freeze({
    cc = {
        userIds = table.freeze({
            [662417482] = true
        }),
        roles = table.freeze({ "contributor", "contentcreator" })
    },
    rinnoplay = {
        userIds = table.freeze({
            [432828236] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "contributor", "moderator" })
    },
    concept = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "contributor", "moderator" })
    },
    slenderman = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        })
    },
    funnyvoicelines = {
        roles = table.freeze({ "tester" })
    },
    remmybirthday = {
        roles = table.freeze({ "tester" })
    },
    fl = {
        roles = table.freeze({ "highrank" })
    },
    ignoreflowcooldown = {
        roles = table.freeze({ "highrank" })
    },
    respawn = {
        roles = table.freeze({ "highrank" })
    },
    teambalancing = {
        roles = table.freeze({ "highrank" })
    },
    awaketest = {
        roles = table.freeze({ "highrank" })
    },
    kick = {
        roles = table.freeze({ "highrank" })
    },
    isagi = {
        roles = table.freeze({ "highrank" })
    },
    legacygk = {
        roles = table.freeze({ "tester" })
    },
    legalhbe = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "moderator" })
    },
    teleport = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "moderator" })
    },
    invisible = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "highrank" })
    },
    breakdance = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "moderator" })
    },
    ihatekunigami = {
        roles = table.freeze({ "highrank" })
    },
    gagamarupunch = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "tester" })
    },
    becomegk = {
        roles = table.freeze({ "tester" })
    },
    becomeai = {
        roles = table.freeze({ "moderator" })
    },
    ncd = {
        roles = table.freeze({ "highrank" })
    },
    f = {
        roles = table.freeze({ "highrank" })
    },
    overtimetest = {
        roles = table.freeze({ "highrank" })
    },
    sillysong = {
        roles = table.freeze({ "highrank" })
    },
    ball = {
        roles = table.freeze({ "highrank" })
    },
    chaos = {
        roles = table.freeze({ "scripter" })
    },
    setfps = {
        roles = table.freeze({ "scripter" })
    },
    showping = {
        roles = table.freeze({ "scripter" })
    },
    kuon = {
        userIds = table.freeze({
            [4166416054] = true
        })
    },
    homelander = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true,
            [1911944568] = true,
            [619213444] = true
        }),
        roles = table.freeze({ "headofstaff" })
    },
    saeawk = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true,
            [2573434151] = true,
            [5639442027] = true,
            [1974243283] = true,
            [568225745] = true,
            [1549164509] = true,
            [1436226044] = true,
            [79447025] = true
        })
    },
    changehitboxsettings = {
        trialTesterTestPlace = true,
        roles = table.freeze({ "moderator" })
    },
    skillbuilder = {},
    announce = {},
    serverban = {
        userIds = table.freeze({
            [4166416054] = true
        })
    },
    slifer = {
        userIds = table.freeze({
            [1911944568] = true,
            [2447122302] = true,
            [4166416054] = true,
            [9823387274] = true
        })
    },
    control = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        }),
        roles = table.freeze({ "headofstaff" })
    },
    yurier = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        })
    },
    tungify = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true,
            [619213444] = true,
            [432828236] = true
        })
    },
    marble = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        })
    },
    marbleball = {
        userIds = table.freeze({
            [2447122302] = true,
            [4166416054] = true
        })
    }
});
local table_freeze_ret5 = table.freeze({
    cc = true,
    skillbuilder = true,
    announce = true,
    serverban = true,
    marble = true,
    marbleball = true
});
local table_freeze_ret6 = table.freeze({
    [4166416054] = true,
    [3730120158] = true
});

local function normalizeCommandKey(p1: string) -- Line: 271
    -- upvalues: table_freeze_ret3 (copy)
    local v2 = p1:lower();

    return table_freeze_ret3[v2] or v2;
end;

local function listContainsUserId(p3: table, p4: number) -- Line: 276
    for _, v in p3 do
        if tonumber(v) == p4 then
            return true;
        end;
    end;

    return false;
end;

local function onTrialTesterTestPlace(p5) -- Line: 285
    -- upvalues: table_freeze_ret (copy)
    local v6 = p5.trialtester and table.find(table_freeze_ret, game.PlaceId) ~= nil;

    return v6;
end;

local function allowedByCommandWhitelist(p7: string, p8: userdata, p9: any) -- Line: 289
    -- upvalues: table_freeze_ret3 (copy), table_freeze_ret4 (copy), CommandWhitelist (copy), table_freeze_ret (copy)
    local v10 = p7:lower();
    local v11 = table_freeze_ret3[v10] or v10;
    local v12 = table_freeze_ret4[v11];

    if not v12 then
        return nil;
    end;

    local v13 = CommandWhitelist[v11];

    if v13 then
        local UserId = p8.UserId;
        local v14 = false;

        for _, v in v13 do
            if tonumber(v) == UserId then
                v14 = true;
                break;
            end;
        end;

        if v14 then
            return true;
        end;
    end;

    if v12.userIds and v12.userIds[p8.UserId] then
        return true;
    end;

    if v12.roles then
        for _, v in v12.roles do
            if p9[v] then
                return true;
            end;
        end;
    end;

    if v12.trialTesterTestPlace then
        local v15 = p9.trialtester and table.find(table_freeze_ret, game.PlaceId) ~= nil;

        if v15 then
            return true;
        end;
    end;

    return false;
end;

local function hasSubscriptionCommandAccess(p16: userdata, p17: string) -- Line: 320
    -- upvalues: table_freeze_ret2 (copy)
    local Attribute = p16:GetAttribute("sub_tier");

    if typeof(Attribute) ~= "string" then
        return false;
    end;

    local v18 = table_freeze_ret2[Attribute];
    local v19;

    if v18 == nil then
        v19 = false;
    else
        v19 = v18[p17] == true;
    end;

    return v19;
end;

local u20 = false;

return function(p21) -- Line: 332
    -- upvalues: permissions (copy), ReplicatedStorage (copy), u20 (ref), Ranked (copy), table_freeze_ret3 (copy), allowedByCommandWhitelist (copy), table_freeze_ret5 (copy), table_freeze_ret2 (copy), table_freeze_ret6 (copy), wiki (copy)
    p21:RegisterHook("BeforeRun", function(p22) -- Line: 333
        -- upvalues: permissions (ref), ReplicatedStorage (ref), u20 (ref), Ranked (ref), table_freeze_ret3 (ref), allowedByCommandWhitelist (ref), table_freeze_ret5 (ref), table_freeze_ret2 (ref), table_freeze_ret6 (ref), wiki (ref)
        local Executor = p22.Executor;
        local v23 = permissions(Executor);

        if ReplicatedStorage:GetAttribute("disablecommands") and (not v23.scripter and Executor:GetAttribute("commandbypass") ~= true) then
            return "Commands are disabled.";
        end;

        if ReplicatedStorage.vipserverownerid.Value ~= 0 and not (v23.moderator or ReplicatedStorage:GetAttribute("PS_USED_CMDS")) then
            if not u20 then
                u20 = true;

                return "If you run another command, you will no longer be able to gain XP for Mastery.";
            end;

            ReplicatedStorage:SetAttribute("PS_USED_CMDS", true);
        end;

        if Ranked.Value and not v23.moderator then
            return "you cant use commands in ranked noob";
        end;

        if not (v23.moderator or (table.find({ "ball", "unfreeze", "cc", "kick", "heat" }, p22.Name:lower()) or (not workspace:GetAttribute("gamemode") or ReplicatedStorage.vipserverownerid.Value ~= 0))) then
            return "You can\'t use this command in a gamemode";
        end;

        local v24 = p22.Name:lower();
        local v25 = table_freeze_ret3[v24] or v24;
        local v26 = allowedByCommandWhitelist(p22.Name, Executor, v23);

        if v26 == false then
            if v25 == "rinnoplay" then
                return "you do not have permission to use this command";
            end;

            if not table_freeze_ret5[v25] then
                return "You don\'t have permission to run this command";
            end;
        end;

        if v26 == true then
            return;
        end;

        local Attribute = Executor:GetAttribute("sub_tier");
        local v27;

        if typeof(Attribute) == "string" then
            local v28 = table_freeze_ret2[Attribute];

            if v28 == nil then
                v27 = false;
            else
                v27 = v28[v25] == true;
            end;
        else
            v27 = false;
        end;

        if v27 then
            return;
        end;

        if table.find({ "skillbuilder", "ballcontrol", "fl", "marble", "marbleball" }, p22.Name:lower()) and ((v23.tester or v23.trialtester) and not (v23.senior_mod or (v23.moderator or v23.admin) or (v23.headofstaff or v23.developer or (v23.owner or v23.scripter)) or (ReplicatedStorage.vipserverownerid.Value ~= 0 or table_freeze_ret6[Executor.UserId]))) then
            return "This command is only available in private servers.";
        end;

        local Group = p22.Group;
        local v29 = wiki.isTestGame() and v23.trialtester;

        if ({
            givegoaleffect = true,
            givepremiumpass = true,
            givestyle = true,
            givecommentator = true
        })[p22.Name:lower()] and (v23.developer and not v23.headofstaff) then
            return "developers are not allowed to use this command anymore";
        end;

        if Group == "ps" and not (v29 or (v23.myvipserver or v23.highrank)) then
            return "you do not have permission to run this command";
        end;

        if Group == "highrank" then
            if p22.Name:lower() == "recolorstyle" and (v23.contributor or v23.contentcreator) then
                return;
            end;

            if table.find({ "tempstyle" }, p22.Name) and v23.contributor then
                return;
            end;

            if not (v29 or v23.highrank) then
                return "You don\'t have permission to run this command";
            end;
        end;

        if Group == "moderator" and not v23.moderator then
            if p22.Name == "money" and wiki.isTestGame() then
                return;
            end;

            if p22.Name ~= "mvp" or not wiki.isTestGame() then
                return "You don\'t have permission to run this command";
            end;

            return;
        end;

        if Group == "admin" and not v23.admin then
            return "You don\'t have permission to run this command";
        end;

        local v30 = {
            tung = true,
            kaboom = true,
            kamui = true,
            homelander = true,
            bankai = true,
            lightsout = true,
            slifer = true
        };

        if Group == "headofstaff" and not v23.headofstaff then
            if not v30[p22.Name:lower()] then
                return "You don\'t have permission to run this command";
            end;

            return;
        end;

        if Group == "developer" and not v23.developer then
            return "You don\'t have permission to run this command";
        end;

        if Group == "owner" and not v23.owner then
            return "You don\'t have permission to run this command";
        end;
    end);
end;