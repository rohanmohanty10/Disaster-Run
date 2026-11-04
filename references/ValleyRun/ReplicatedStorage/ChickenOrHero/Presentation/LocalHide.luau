 

 

local Players = game:GetService("Players");
local Parent = script.Parent.Parent;
local LocalLooks = require(script.Parent.LocalLooks);
local u1 = {
    ParticleEmitter = true,
    Trail = true,
    Beam = true,
    Fire = true,
    Smoke = true,
    Sparkles = true
};
local u2 = 0;
local u3 = {};
local u4 = {};
u4.__index = u4;

function u4.new(p5) -- Line: 27
    -- upvalues: u4 (copy)
    return setmetatable({
        holding = false,
        saved = {},
        keep = p5 or {}
    }, u4);
end;

local function kept(p6, p7) -- Line: 31
    local keep = p6.keep;

    if type(keep) ~= "function" then
        return keep[p7] == true;
    end;

    local success, result = pcall(keep, p7);

    if success then
        success = result == true;
    end;

    return success;
end;

local function hideable(p8) -- Line: 40
    -- upvalues: u1 (copy)
    return p8:IsA("BasePart") or p8:IsA("Decal") or u1[p8.ClassName] == true;
end;

local function leftover(p9) -- Line: 44
    return p9 >= 1 and 0 or p9;
end;

function u4.model(p10, p11) -- Line: 48
    -- upvalues: u1 (copy), LocalLooks (copy), leftover (copy)
    local saved = p10.saved;

    for _, descendant in p11:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or u1[descendant.ClassName] == true) then
            if saved[descendant] == nil then
                saved[descendant] = LocalLooks.hold(descendant, "LocalTransparencyModifier", p10, leftover);
            end;

            if descendant.LocalTransparencyModifier ~= 1 then
                descendant.LocalTransparencyModifier = 1;
            end;
        end;
    end;
end;

function u4.sweep(p12) -- Line: 63
    -- upvalues: Players (copy), u2 (ref), Parent (copy), u3 (copy)
    local LocalPlayer = Players.LocalPlayer;

    for _, v in Players:GetPlayers() do
        local v13;

        if v == LocalPlayer then
            v13 = false;
        else
            v13 = v.Character;
        end;

        if v13 then
            local keep = p12.keep;
            local v14;

            if type(keep) == "function" then
                local v15;
                v14, v15 = pcall(keep, v13);

                if v14 then
                    v14 = v15 == true;
                end;
            else
                v14 = keep[v13] == true;
            end;

            if not v14 then
                p12:model(v13);
            end;
        end;
    end;

    for _, child in workspace:GetChildren() do
        if child:IsA("Model") and child:GetAttribute("IsBot") == true then
            local keep = p12.keep;
            local v16;

            if type(keep) == "function" then
                local v17;
                v16, v17 = pcall(keep, child);

                if v16 then
                    v16 = v17 == true;
                end;
            else
                v16 = keep[child] == true;
            end;

            if not v16 then
                p12:model(child);
            end;
        end;
    end;

    if not p12.holding then
        p12.holding = true;
        u2 = u2 + 1;
    end;

    local Bots = Parent:FindFirstChild("Bots");

    if Bots then
        Bots = Bots:FindFirstChild("Actors");
    end;

    if Bots then
        for _, child in Bots:GetChildren() do
            local keep = p12.keep;
            local v18;

            if type(keep) == "function" then
                local v19;
                v18, v19 = pcall(keep, child);

                if v18 then
                    v18 = v19 == true;
                end;
            else
                v18 = keep[child] == true;
            end;

            if not v18 then
                u3[child] = true;

                if child:GetAttribute("LocalHidden") ~= true then
                    child:SetAttribute("LocalHidden", true);
                end;
            end;
        end;
    end;
end;

function u4.restore(p20) -- Line: 96
    -- upvalues: LocalLooks (copy), u2 (ref), u3 (copy)
    for i in p20.saved do
        local v21, u22 = LocalLooks.release(i, "LocalTransparencyModifier", p20);

        if v21 then
            pcall(function() -- Line: 102
                -- upvalues: i (copy), u22 (copy)
                i.LocalTransparencyModifier = u22;
            end);
        end;
    end;

    table.clear(p20.saved);

    if p20.holding then
        p20.holding = false;
        u2 = math.max(0, u2 - 1);

        if u2 == 0 then
            for i in u3 do
                pcall(i.SetAttribute, i, "LocalHidden", nil);
            end;

            table.clear(u3);
        end;
    end;
end;

return table.freeze(u4);