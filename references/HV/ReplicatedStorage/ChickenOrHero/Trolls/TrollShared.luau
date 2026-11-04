 

 

local EmoteCatalog = require(script.Parent.Parent:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local u1 = {
    DebugAffectsOwners = false,
    StateName = "State",
    RemoteName = "TrollEvent",
    JumpPower = 42,
    DanceOrder = table.freeze({ "EDanceSupreme", "Floss", "SixtySeven", "DaBabyDance", "RatDance", "YaYaYing", "CaliforniaGirls", "Marat", "Jumpstyle", "ElectroShuffle", "Shuffle", "BTSDance", "CatDance", "SkeletonGrooves", "Caffeinated", "FastDancer", "BoogieDown", "Dougie", "LoseIt", "WibblyWobbly", "Skeleton", "WavyGrooves", "Marisa", "IdleDance" })
};
local u2 = nil;

function u1.dances() -- Line: 32
    -- upvalues: u2 (ref), u1 (copy), EmoteCatalog (copy)
    if u2 then
        return u2;
    end;

    local v3 = {};

    for _, v in u1.DanceOrder do
        local v4 = EmoteCatalog.get(v);

        if v4 and not (v4.Prop or (v4.Knife or (v4.Kind or (v4.Ultimate or (v4.Test or not EmoteCatalog.assetId(v)))))) then
            table.insert(v3, table.freeze({
                id = v,
                name = v4.Name or v
            }));
        end;
    end;

    u2 = table.freeze(v3);

    return u2;
end;

function u1.dance(p5) -- Line: 47
    -- upvalues: u1 (copy)
    for _, v in u1.dances() do
        if v.id == p5 then
            return v;
        end;
    end;

    return nil;
end;

function u1.debug() -- Line: 57
    -- upvalues: u1 (copy)
    local v6;

    if u1.DebugAffectsOwners == true then
        v6 = game:GetService("RunService"):IsStudio() or game.PlaceId == 130574217370467;
    else
        v6 = false;
    end;

    return v6;
end;

function u1.exempt(p7) -- Line: 62
    local v8;

    if p7 == nil then
        v8 = false;
    else
        v8 = p7:GetAttribute("TrollExempt") == true;
    end;

    return v8;
end;

function u1.ownerClone(p9, p10) -- Line: 67
    -- upvalues: u1 (copy)
    local Attribute = p9:GetAttribute("CloneOwnerUserId");
    local v11;

    if type(Attribute) == "number" then
        v11 = p10:GetPlayerByUserId(Attribute);
    else
        v11 = false;
    end;

    local v12;

    if v11 == nil or v11 == false then
        v12 = false;
    else
        v12 = u1.exempt(v11);
    end;

    return v12;
end;

function u1.loopTime(p13, p14) -- Line: 74
    return p14 <= 0 and 0 or (workspace:GetServerTimeNow() - p13) % p14;
end;

return table.freeze(u1);