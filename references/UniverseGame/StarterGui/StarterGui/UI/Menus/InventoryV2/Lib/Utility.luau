  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
require(ReplicatedStorage.ReplicatedModules.StatsHandler);
require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local TraitHandler = require(ReplicatedStorage.ReplicatedModules.PVEPackage.TraitHandler);
local CharmsHandler = require(ReplicatedStorage.ReplicatedModules.PVEPackage.CharmsHandler);
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local Mounts = require(ReplicatedStorage.ReplicatedModules.Mounts);
local Knit = require(Core.LegacyPath.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require("./Types");
local u1 = Core.GetLegacyService("TraitService");
local u2 = {};
local u3 = {
    Common = 1,
    Rare = 3,
    Epic = 4,
    Legendary = 5,
    Mythic = 7,
    Developer = 8
};
local u4 = {
    [25] = Color3.fromRGB(255, 90, 90),
    [50] = Color3.fromRGB(255, 194, 12),
    [75] = Color3.fromRGB(88, 255, 144),
    [100] = Color3.fromRGB(255, 51, 218)
};
local u5 = {
    Attack = Color3.fromRGB(255, 97, 97),
    Defense = Color3.fromRGB(255, 180, 115),
    Health = Color3.fromRGB(100, 220, 100),
    Special = Color3.fromRGB(116, 211, 255)
};

local function RgbToHex(p6) -- Line: 81
    return string.format("#%02X%02X%02X", math.floor(p6.R * 255 + 0.5), math.floor(p6.G * 255 + 0.5), (math.floor(p6.B * 255 + 0.5)));
end;

local function ColorBySign(p7) -- Line: 88
    return p7 < 0 and "#FF4444" or (p7 > 0 and "#44FF44" or "#FFFFFF");
end;

local function InheritMount(p8) -- Line: 98
    -- upvalues: Mounts (copy), InheritMount (copy), TableUtil (copy)
    local v9 = Mounts[p8.Inherit];

    if v9.Inherit then
        v9 = InheritMount(v9);
    end;

    return TableUtil.Reconcile(p8, v9);
end;

local v10 = {};
local u11 = {};

local function GetUUIDData(p12) -- Line: 22
    -- upvalues: u2 (copy)
    if type(p12) == "string" then
        local v13 = p12:split("/");
        local v14 = v13[1];
        local v15 = v13[2];
        local u16 = "";

        for i = 1, #v14 do
            u16 = u16 .. string.byte(v14:sub(i, i)) - 65;
        end;

        local u17 = u2[u16];
        pcall(function() -- Line: 37
            -- upvalues: u17 (ref), u16 (ref)
            if u17 then
                return;
            end;

            u17 = game.Players:GetNameFromUserIdAsync((tonumber(u16)));
        end);

        if not u2[u16] and u17 then
            u2[u16] = u17;
        end;

        return {
            UserId = u16,
            Time = v15,
            Creator = u17
        };
    end;
end;

local function GetTraitRarityIndex(p18) -- Line: 62
    -- upvalues: TraitHandler (copy), u3 (copy)
    return u3[TraitHandler.GetTraitData(p18).Rarity] or 1;
end;

local u19 = nil;

for _, v in Mounts do
    if v.ItemId then
        v10[v.ItemId] = v;
        local v20;

        if v.Inherit then
            local v21 = Mounts[v.Inherit];

            if v21.Inherit then
                v21 = InheritMount(v21);
            end;

            v20 = TableUtil.Reconcile(v, v21);
        else
            v20 = v;
        end;

        u11[v.ItemId] = v20.MovementProperties or {};
    end;
end;

local function GetMountStat(p22, p23, p24) -- Line: 119
    -- upvalues: u11 (copy)
    local v25 = u11[p22];

    if v25 then
        return v25[p23] or p24;
    end;

    return p24;
end;

local function UpdateTooltip(p26, p27) -- Line: 127
    -- upvalues: ItemData (copy), TraitHandler (copy), u19 (ref), u5 (copy), CharmsHandler (copy), u4 (copy), u11 (copy)
    local v28 = ItemData.GetItemInfo(p27.ItemId);
    local v29 = "";

    if p27.Serial then
        local Serial = p27.Serial;

        if type(Serial) == "number" then
            v29 = v29 .. `#{Serial}`;
        end;
    end;

    if p27.Trait then
        if #v29 > 0 then
            v29 = v29 .. "\n";
        end;

        local Trait = p27.Trait;
        local v30 = TraitHandler.GetTraitData(Trait.Name);
        local Rarity = v30.Rarity;
        local v31 = "";

        if Trait.Hex and v30.HexPrefix then
            v31 = v31 .. `{v30.HexPrefix} `;
        end;

        local v32 = v31 .. Trait.Name;
        v29 = v29 .. `Trait: <font color="#{ItemData.GetRarityByName(Rarity).Color:ToHex()}">{v32}</font>`;

        if Trait.Stats then
            local v33 = u19[Trait.Hex and "Hexed" or Rarity];
            local v34 = "";
            local v35 = 0;

            for i, v in Trait.Stats do
                local v36 = v33.Max <= v;
                local v37 = v <= v33.Min;
                v35 = v35 + (v36 and 1 or (v37 and -1 or 0));
                v34 = v34 .. `\n\t<font color="#{u5[i]:ToHex()}">{(v36 and "<font color=\"#FFB000\">★</font> " or (v37 and "<font color=\"#FF0000\">💔</font> " or "")) .. i}: {v .. (v36 and " <font color=\"#FFB000\">★</font>" or (v37 and " <font color=\"#FF0000\">💔</font>" or ""))}</font>`;
            end;

            v29 = (v29 .. "\nStat Bonuses:") .. (v35 >= 4 and "\n<font color=\"#FFB000\">Perfect</font> " or (v35 <= -4 and "\n<font color=\"#FF0000\">Depressing</font> " or "")) .. v34;
        end;
    end;

    if p27.UnusualInfo then
        if #v29 > 0 then
            v29 = v29 .. "\n";
        end;

        local UnusualHueId = p27.UnusualInfo.UnusualHueId;
        local UnusualCharmId = p27.UnusualInfo.UnusualCharmId;
        local Chroma = p27.UnusualInfo.Chroma;
        local v38;

        if tostring(UnusualCharmId) == "nan" then
            v38 = false;
        else
            v38 = CharmsHandler.GetCharmInfo(UnusualCharmId);
        end;

        local v39;

        if v38 then
            v39 = v38.DisplayName or v38.Charm;
        else
            v39 = UnusualCharmId;
        end;

        local v40 = nil;
        local v41 = nil;
        local v42 = tostring(UnusualCharmId) == "nan" and "" or (`\n<font color="#4B96FF">Charm: {v39}</font>` or "");

        if UnusualHueId == 0 then
            v41 = "#FFFFFF";
        elseif UnusualHueId >= 9000000000 then
            v40 = "<font color=\"#fff\"><stroke color=\"#fff\" tr=\"0.5\">White</stroke> Pattern</font> (<font color=\"#fff\">■■■</font>)" .. v42;
        elseif UnusualHueId == UnusualHueId then
            local v43 = Color3.fromHSV(UnusualHueId * 5 / 360, 1, 1);
            v41 = string.format("#%02X%02X%02X", math.floor(v43.R * 255 + 0.5), math.floor(v43.G * 255 + 0.5), (math.floor(v43.B * 255 + 0.5)));
        else
            v40 = "<stroke color=\"#888\" tr=\"0.5\"><font color=\"#000\">Black Pattern</font></stroke> (<font color=\"#000\">■■■</font>)" .. v42;
        end;

        if v40 then
            v29 = v29 .. v40;
        else
            v29 = v29 .. (Chroma and "<font color=\"#FF0000\">C</font><font color=\"#CCFF00\">H</font><font color=\"#00FF66\">R</font><font color=\"#0066FF\">O</font><font color=\"#CC00FF\">M</font><font color=\"#FF0000\">A</font>" or `<font color="#AA55FF">Pattern {UnusualHueId}</font> ({string.format("<font color=\"%s\">■■■</font>", v41, UnusualHueId)})`) .. v42;
        end;
    end;

    if p27.Purity then
        local Purity = p27.Purity;
        local v44 = Color3.new(1, 1, 1);

        if Purity > 0 and Purity <= 25 then
            v44 = u4[25];
        elseif Purity > 25 and Purity <= 50 then
            v44 = u4[50];
        elseif Purity > 50 and Purity <= 75 then
            v44 = u4[75];
        elseif Purity > 75 then
            v44 = u4[100];
        end;

        v29 = v29 .. `<font color="#{v44:ToHex()}">Purity: {Purity}%</font>`;
    end;

    if p27.Premium then
        v29 = v29 .. `<br /><font color="#{Color3.fromRGB(255, 255, 0):ToHex()}">Premium</font>`;
    end;

    if p27.Type == "Mount" then
        local v45 = u11[p27.ItemId];
        local v46 = v45 and (v45.MAX_SPEED or 90) or 90;
        local v47 = u11[p27.ItemId];
        local v48 = v47 and (v47.BACKWARD_MAX_SPEED or 0) or 0;
        local v49 = u11[p27.ItemId];
        local v50 = v49 and (v49.MOTIONAL_ACCELERATION or 0.5) or 0.5;
        local v51 = u11[p27.ItemId];
        local v52 = v51 and (v51.MOTIONAL_DECELERATION or 0.25) or 0.25;

        if #v29 > 0 then
            v29 = v29 .. "\n";
        end;

        v29 = (((v29 .. `Max Speed: <font color="#{v46 < 0 and "#FF4444" or (v46 > 0 and "#44FF44" or "#FFFFFF")}">{v46}</font>`) .. `\nBackward Speed: <font color="#{v48 < 0 and "#FF4444" or (v48 > 0 and "#44FF44" or "#FFFFFF")}">{v48}</font>`) .. `\nAcceleration: <font color="#{v50 < 0 and "#FF4444" or (v50 > 0 and "#44FF44" or "#FFFFFF")}">{v50}</font>`) .. `\nDeceleration: <font color="#{v52 < 0 and "#FF4444" or (v52 > 0 and "#44FF44" or "#FFFFFF")}">{v52}</font>`;
    end;

    if p27.LinkedAbilityId then
        local v53 = `ABILITY_{p27.LinkedAbilityId}`;

        if #v29 > 0 then
            v29 = v29 .. "\n";
        end;

        local v54 = ItemData.GetItemInfo(v53) or {};
        v29 = v29 .. `Ability: {v54.DisplayName or v54.Name}`;
    end;

    p26:SetTitle((`<font color="#{ItemData.GetRarity(v28).Color:ToHex()}">{v28.Name}</font>`));
    p26:SetText(v29);
end;

task.spawn(function() -- Line: 281
    -- upvalues: u19 (ref), u1 (copy)
    u19 = u1:GetTraitsMetadata():expect().StatRanges;
    print(u19);
end);

return {
    DecodeUUID = GetUUIDData,
    GetTraitRarityIndex = GetTraitRarityIndex,
    UpdateTooltip = UpdateTooltip,

    CanTooltipInventorySlot = function(p55) -- Line: 276, Name: CanTooltipInventorySlot
        return p55.Trait or (p55.UnusualInfo or p55.Serial) or (p55.Purity or p55.Premium or p55.Type == "Mount");
    end
};