  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Assets = ReplicatedStorage:WaitForChild("Client Assets"):WaitForChild("Assets");
local Abilities = Assets.Abilities;
local ParticleHandler = require(script.Parent.ParticleHandler);
local u1 = {
    Noob = "The World: Over Heaven",
    DJNoob = "The World: Over Heaven",
    ["Party Starter"] = "The World",
    Galizur = "The World: Over Heaven",
    KCR = "King Crimson"
};
local u6 = {
    _GetAsset = function(p2, p3, p4) -- Line: 23, Name: _GetAsset
        if p2 then
            local v5 = string.split(p3, p4 and "|" or "/");

            for _, v in pairs(v5) do
                p2 = p2:FindFirstChild(v);

                if not p2 then
                    return;
                end;
            end;

            return p2;
        end;
    end
};

function u6.GetAsset(p7, p8) -- Line: 37
    -- upvalues: u6 (copy), Assets (copy), u1 (copy), Abilities (copy)
    if typeof(p8) ~= "table" then
        return u6._GetAsset(Assets, p7);
    end;

    local v9 = p8 or {};

    if v9.RawPath then
        return u6._GetAsset(v9.RootFolder or Assets.Abilities, p7, true);
    end;

    local v10 = u1[v9.AbilityName] or v9.AbilityName;
    local v11 = `{v10}/{v9.SkinName or ""}`;
    local v12 = v9.RootFolder or Abilities;
    local v13 = u6._GetAsset(v12, v10);
    local v14 = u6._GetAsset(v12, v11);

    return v14 and u6._GetAsset(v14, p7) or u6._GetAsset(v13, p7);
end;

function u6.CloneAsset(p15, p16) -- Line: 62
    -- upvalues: u6 (copy)
    local v17 = u6.GetAsset(p15, p16);

    if v17 then
        return v17:Clone();
    end;
end;

function u6.GetAbilityData(p18) -- Line: 70
    local v19 = nil;
    local v20 = nil;

    if p18:IsA("Player") then
        v19 = p18;
        p18 = p18.Character;
    elseif p18:IsA("Model") then
        v19 = game.Players:GetPlayerFromCharacter(p18) or p18;
    else
        p18 = v20;
    end;

    local v21 = v19 and v19:FindFirstChild("Data");

    if v21 then
        p18 = v21;
    elseif p18 then
        p18 = p18:FindFirstChild("Data");
    end;

    if p18 then
        return {
            AbilityName = p18.Ability:GetAttribute("AbilityName"),
            SkinName = p18.Skin:GetAttribute("SkinName")
        };
    end;
end;

u6._ScalesTypes = {
    Part = function(p22, p23) -- Line: 98
        return {
            Size = p22.Size * p23
        };
    end,

    MeshPart = function(p24, p25) -- Line: 102
        return {
            Size = p24.Size * p25
        };
    end,

    Attachment = function(p26, p27) -- Line: 106
        return {
            Position = p26.Position * p27
        };
    end,

    Beam = function(p28, p29) -- Line: 110
        return {
            CurveSize0 = p29 * p28.CurveSize0,
            CurveSize1 = p29 * p28.CurveSize1,
            Width0 = p29 * p28.Width0,
            Width1 = p29 * p28.Width1
        };
    end,

    ParticleEmitter = function(p30, p31, p32) -- Line: 120
        -- upvalues: ParticleHandler (copy)
        ParticleHandler[p32 == nil and "_ScaleParticle" or "TweenScale"](p30, p31, p32);
    end
};

function u6.ScaleAsset(p33, p34) -- Line: 125
    -- upvalues: u6 (copy), TweenService (copy)
    local v35 = p34 or {};

    if not (p33 and p33:IsDescendantOf(game)) then
        return;
    end;

    local u36 = {};
    local v37 = v35.ReturnObject or false;
    local v38 = v35.Scale or 1;
    local v39 = typeof(v35.TweenInfo) == "TweenInfo" and v35.TweenInfo or (typeof(v35.TweenInfo) == "table" and TweenInfo.new(unpack(v35.TweenInfo)) or v35.TweenInfo);
    local v40 = u6._ScalesTypes[p33.ClassName];

    if v40 then
        v40 = v40(p33, v38, v39);
    end;

    if v40 then
        if v39 then
            local v41 = TweenService:Create(p33, v39, v40);

            if v37 then
                table.insert(u36, v41);
            end;

            v41:Play();
        else
            for i, v in v40 do
                p33[i] = v;
            end;
        end;
    end;

    for _, child in ipairs(p33:GetChildren()) do
        u6.ScaleAsset(child, v35);
    end;

    if v37 then
        return {
            Destroy = function() -- Line: 160, Name: Destroy
                -- upvalues: u36 (copy)
                for _, v in u36 do
                    v:Pause();
                    v:Destroy();
                end;

                table.clear(u36);
            end
        };
    end;
end;

return u6;