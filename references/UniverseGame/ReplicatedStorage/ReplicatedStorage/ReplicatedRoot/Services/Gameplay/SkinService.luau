  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
local Abilities = require(ReplicatedRoot.Libraries.Abilities);
local Skins = require(ReplicatedRoot.Libraries.Skins);

return {
    Name = "SkinService",

    GetSkin = function(p1) -- Line: 30, Name: GetSkin
        -- upvalues: Abilities (copy), Skins (copy)
        local v2 = nil;
        local v3 = nil;
        local v4 = nil;

        if typeof(p1) == "Instance" then
            if p1:IsA("Player") then
                v3 = p1.Character;
            elseif p1:IsA("Model") then
                local v5 = game.Players:GetPlayerFromCharacter(p1);
                v3 = p1;
                p1 = v5;
            else
                p1 = v2;
            end;
        else
            p1 = v2;
        end;

        if p1 then
            v4 = p1:FindFirstChild("Data");
        elseif not p1 and v3 then
            v4 = v3:FindFirstChild("Data");
        end;

        if v4 then
            local Ability = v4:FindFirstChild("Ability");
            local Skin = v4:FindFirstChild("Skin");
            local v6 = Ability and Abilities.GetAbilityInfo(Ability.Value) or nil;
            local v7;

            if Skin then
                v7 = tonumber(Skin.Value) or nil;
            else
                v7 = nil;
            end;

            local v8;

            if v6 and v7 then
                v8 = Skins.GetSkinInfo(v6.Id, v7) or nil;
            else
                v8 = nil;
            end;

            local v9;

            if v8 then
                v9 = v8.Name or nil;
            else
                v9 = nil;
            end;

            if v6 and v8 then
                local v10 = Skin:GetAttribute("UnusualHueId");
                local v11 = Skin:GetAttribute("UnusualCharmId");
                local v12 = Skin:GetAttribute("ChromaUnusual");
                local v13 = v10 ~= nil and {
                    HueId = v10,
                    CharmId = v11,
                    Chroma = v12 or false
                } or nil;

                return {
                    AbilityId = v6.Id,
                    AbilityName = v6.Name,
                    Id = v7,
                    Name = Skin:GetAttribute("SkinName") or v9,
                    ItemId = `SKIN_{v6.Id}_{v7}`,
                    UUID = Skin:GetAttribute("UUID"),
                    Unusual = v13
                };
            end;
        end;

        return nil;
    end
};