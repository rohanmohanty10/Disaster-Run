 

 

local Players = game:GetService("Players");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local SkinCatalog = require(Parent.Weapons.SkinCatalog);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local u1 = {
    COIN_IMAGE = "rbxassetid://78008558948307",
    GEM_IMAGE = "rbxassetid://137046122108742",
    EMOTE_IMAGE = "rbxassetid://125247002833803",
    GEM_TEXT = Color3.fromRGB(87, 235, 159),
    GOLD = Color3.fromRGB(255, 202, 58)
};
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);

function u1.titleCase(p2) -- Line: 22
    local string_gsub_ret = string.gsub(string.lower((tostring(p2))), "\195([\128-\150\152-\158])", function(p3) -- Line: 23
        local v4 = string.byte(p3) + 32;

        return "\195" .. string.char(v4);
    end);

    return string.gsub(string_gsub_ret, "(%a)([%w\'\128-\255]*)", function(p5, p6) -- Line: 26
        return string.upper(p5) .. p6;
    end);
end;

function u1.asset(p7) -- Line: 31
    local v8 = tonumber(p7);

    if v8 then
        return "rbxassetid://" .. string.format("%.0f", v8);
    end;

    if type(p7) == "string" and p7 ~= "" then
        return p7;
    end;

    return nil;
end;

function u1.wheel() -- Line: 39
    -- upvalues: script_Parent (copy)
    return script_Parent:FindFirstChild("WheelIcon");
end;

function u1.spins(p9) -- Line: 44
    -- upvalues: u1 (copy)
    return {
        image = "",
        icon = u1.wheel(),
        count = p9,
        name = p9 == 1 and "Wheel Spin" or "Wheel Spins",
        color = u1.GOLD
    };
end;

function u1.counter(p10) -- Line: 50
    -- upvalues: Players (copy)
    local v11 = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v12;

    if v11 then
        v12 = v11:FindFirstChild("ValleyHUD");
    else
        v12 = v11;
    end;

    local v13 = v12 and v12.Enabled and v12:FindFirstChild("Wallet");

    if v13 then
        v13 = v13:FindFirstChild(p10);
    end;

    if v13 then
        return v13:FindFirstChild("Icon") or v13;
    end;

    if v11 then
        v11 = v11:FindFirstChild("HUD");
    end;

    if v11 then
        v11 = v11:FindFirstChild("Currencies", true);
    end;

    if v11 then
        v11 = v11:FindFirstChild(p10);
    end;

    if v11 then
        v11 = v11:FindFirstChild("Icon") or v11;
    end;

    return v11;
end;

function u1.knife(p14, p15) -- Line: 63
    -- upvalues: SkinCatalog (copy), u1 (copy)
    local v16 = SkinCatalog.get(p14);
    local v17;

    if v16 then
        v17 = {
            knife = v16,
            name = u1.titleCase(v16.SourceName or v16.Name) .. (p15 and " (Owned)" or "")
        };
        local v18;

        if typeof(v16.Accent) == "Color3" then
            v18 = v16.Accent;
        else
            v18 = nil;
        end;

        v17.color = v18;
    else
        v17 = v16;
    end;

    return v17;
end;

function u1.emote(p19, p20) -- Line: 72
    -- upvalues: EmoteCatalog (copy), u1 (copy)
    local v21 = EmoteCatalog.get(p19);

    return v21 and {
        emote = p19,
        image = u1.EMOTE_IMAGE,
        name = tostring(v21.Name) .. (p20 and " (Owned)" or " Emote")
    };
end;

function u1.crate(p22, p23) -- Line: 79
    -- upvalues: Parent (copy)
    local CrateCatalog = require(Parent.Crates.CrateCatalog);
    local v24 = CrateCatalog.get(p22);

    if not v24 then
        return nil;
    end;

    local v25 = tonumber(p23) or 1;
    local math_floor_ret = math.floor(v25);
    local math_max_ret = math.max(1, math_floor_ret);
    local v26 = {
        still = true,
        emote = CrateCatalog.poseEmote(p22)
    };
    local v27;

    if type(v24.Icon) == "string" then
        v27 = v24.Icon;
    else
        v27 = nil;
    end;

    v26.image = v27;
    local v28;

    if math_max_ret > 1 then
        v28 = "×" .. math_max_ret;
    else
        v28 = nil;
    end;

    v26.amount = v28;
    v26.name = "Free " .. tostring(v24.Name);
    local v29;

    if typeof(v24.Accent) == "Color3" then
        v29 = v24.Accent;
    else
        v29 = nil;
    end;

    v26.color = v29;

    return v26;
end;

function u1.show(p30, p31, p32, u33, p34) -- Line: 99
    -- upvalues: script_Parent (copy), u1 (copy), Font_new_ret (copy)
    local RewardPop = script_Parent:FindFirstChild("RewardPop");

    if not RewardPop then
        return false;
    end;

    local v35 = {};

    if p32 > 0 then
        local v36 = {
            name = "Gems",
            image = u1.GEM_IMAGE,
            count = p32,
            target = u1.counter("Gems"),
            amountColor = u1.GEM_TEXT
        };
        table.insert(v35, v36);
    end;

    if p31 > 0 then
        local v37 = {
            name = "Coins",
            image = u1.COIN_IMAGE,
            count = p31,
            target = u1.counter("Coins")
        };
        table.insert(v35, v37);
    end;

    local u38 = {};

    for _, v in p30 do
        for _, v2 in v do
            if #u38 < 10 - #v35 then
                table.insert(u38, v2);
            end;
        end;
    end;

    for _, v in v35 do
        table.insert(u38, v);
    end;

    if #u38 == 0 then
        return false;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "RewardSlot";
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.fromOffset(100, 100);
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Image";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Parent = Frame;
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "View";
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.Parent = Frame;
    local u39 = p34 or {};
    local success, result = pcall(function() -- Line: 148
        -- upvalues: RewardPop (copy), u38 (copy), u33 (copy), Frame (copy), Font_new_ret (ref), u39 (ref)
        require(RewardPop).show(u38, {
            origin = u33,
            template = Frame,
            font = Font_new_ret,
            heading = u39.heading,
            displayOrder = u39.displayOrder
        });
    end);
    Frame:Destroy();

    if not success then
        warn("Claim celebration failed: " .. tostring(result));
    end;

    return success;
end;

function u1.given(p40, p41, p42) -- Line: 167
    -- upvalues: Parent (copy), u1 (copy)
    if type(p40) ~= "table" then
        return false;
    end;

    local GearCatalog = require(Parent.Gear.GearCatalog);
    local JourneyConfig = require(Parent.Progression.JourneyConfig);

    local function add(p43, p44) -- Line: 175
        if p44 then
            table.insert(p43, p44);
        end;
    end;

    local v45 = 0;
    local v46 = {};
    local v47 = {};
    local v48 = {};
    local v49 = 0;

    for _, v in p40 do
        if type(v) == "table" then
            local v50 = tonumber(v.n) or 0;

            if v.k == "Coins" then
                v49 = v49 + v50;
            elseif v.k == "Gems" then
                v45 = v45 + v50;
            elseif v.k == "Knife" then
                local v51 = u1.knife(v.id, v.owned);

                if v51 then
                    table.insert(v48, v51);
                end;
            elseif v.k == "Emote" then
                local v52 = u1.emote(v.id, v.owned);

                if v52 then
                    table.insert(v47, v52);
                end;
            elseif v.k == "Crate" then
                if v.emote then
                    local v53 = u1.emote(v.emote, v.owned);

                    if v53 then
                        table.insert(v47, v53);
                    end;
                elseif v.skin then
                    local v54 = u1.knife(v.skin, v.owned);

                    if v54 then
                        table.insert(v48, v54);
                    end;
                else
                    local v55 = u1.crate(v.id, v50);

                    if v55 then
                        table.insert(v46, v55);
                    end;
                end;

                v45 = v45 + (tonumber(v.gems) or 0);
            elseif v.k == "Ability" or v.k == "Gear" then
                local v56 = GearCatalog.get(v.id);

                if v56 then
                    local v57 = {
                        image = v56.IconImage
                    };
                    local v58;

                    if v.k == "Gear" then
                        v58 = "+" .. v50;
                    else
                        v58 = nil;
                    end;

                    v57.amount = v58;
                    v57.name = u1.titleCase(v56.Name) .. (v.owned and " (Owned)" or "");
                    local v59;

                    if typeof(v56.Accent) == "Color3" then
                        v59 = v56.Accent;
                    else
                        v59 = nil;
                    end;

                    v57.color = v59;
                    table.insert(v46, v57);
                end;
            elseif v.k == "Spins" then
                table.insert(v46, u1.spins(v50));
            elseif v.k == "CoinBoost" then
                table.insert(v46, {
                    name = "Coin Boost",
                    image = u1.COIN_IMAGE,
                    amount = "2× " .. v50 .. "m"
                });
            elseif v.k == "GemBoost" then
                table.insert(v46, {
                    name = "Gem Boost",
                    image = u1.GEM_IMAGE,
                    amount = "2× " .. v50 .. "m",
                    amountColor = u1.GEM_TEXT
                });
            elseif v.k == "CandyCorn" then
                local v60 = {
                    name = "Candy Corn",
                    image = require(Parent.Game.CandyCorn).Icon,
                    amount = "+" .. v50,
                    color = Color3.fromRGB(255, 176, 70)
                };
                table.insert(v46, v60);
            elseif v.k == "QuestSkips" then
                table.insert(v46, {
                    name = "Quest Skip",
                    title = v50 .. (v50 == 1 and " SKIP" or " SKIPS"),
                    color = u1.GOLD
                });
            elseif v.k == "GhostKeys" then
                local v61 = {
                    image = require(Parent.Game.GhostTraderConfig).KeyIcon,
                    amount = "+" .. v50,
                    name = v50 == 1 and "Ghost Key" or "Ghost Keys",
                    color = u1.GOLD
                };
                table.insert(v46, v61);
            elseif v.k == "Title" then
                local v62 = JourneyConfig.Badges[v.id];

                if v62 then
                    local v63 = {
                        title = string.gsub(u1.titleCase(v62.Name), "%f[%w]Mvp%f[%W]", "MVP")
                    };
                    local v64;

                    if typeof(v62.Color) == "Color3" then
                        v64 = v62.Color;
                    else
                        v64 = nil;
                    end;

                    v63.color = v64;
                    v63.name = "Title" .. (v.owned and " (Owned)" or "");
                    table.insert(v46, v63);
                end;
            end;
        end;
    end;

    return u1.show({ v48, v47, v46 }, v49, v45, p41, p42);
end;

function u1.journey(p65, p66, p67) -- Line: 249
    -- upvalues: Parent (copy), u1 (copy), SkinCatalog (copy)
    local JourneyConfig = require(Parent.Progression.JourneyConfig);
    local v68 = {};
    local v69 = 0;
    local v70 = 0;
    local v71 = 0;
    local v72 = 0;
    local v73 = 0;
    local v74 = nil;
    local v75 = {};
    local v76 = {};

    for _, v in p65 do
        local v77 = u1.asset(v.Icon);

        if v77 then
            table.insert(v68, {
                image = v77
            });
        else
            local v78 = v.SkinId and u1.asset(v.KnifeIcon);

            if v78 then
                local v79 = SkinCatalog.get(v.SkinId);
                local v80 = {
                    image = v78
                };
                local v81;

                if v79 then
                    v81 = u1.titleCase(v79.SourceName or v79.Name) or nil;
                else
                    v81 = nil;
                end;

                v80.name = v81;
                table.insert(v75, v80);
            elseif v.SkinId and u1.knife(v.SkinId) then
                table.insert(v75, u1.knife(v.SkinId));
            end;

            if v.EmoteId and u1.emote(v.EmoteId) then
                table.insert(v76, u1.emote(v.EmoteId));
            end;
        end;

        local v82 = v.Badge and JourneyConfig.Badges[v.Badge];

        if v82 then
            local v83 = {
                name = "Title",
                title = u1.titleCase(v82.Name)
            };
            local v84;

            if typeof(v82.Color) == "Color3" then
                v84 = v82.Color;
            else
                v84 = nil;
            end;

            v83.color = v84;
            table.insert(v68, v83);
        end;

        v69 = v69 + (tonumber(v.Gems) or 0);
        v70 = v70 + (tonumber(v.Coins) or 0);
        v71 = v71 + (tonumber(v.Spins) or 0);
        v72 = v72 + (tonumber(v.CandyCorn) or 0);
        v73 = v73 + (tonumber(v.Keys) or 0);
        v74 = v74 or ((tonumber(v.Keys) or 0) > 0 and (v.KeyCrate or "HalloweenEmote") or nil);
    end;

    if v72 > 0 then
        local v85 = {
            name = "Candy Corn",
            image = require(Parent.Game.CandyCorn).Icon,
            count = v72,
            color = Color3.fromRGB(255, 176, 70)
        };
        table.insert(v68, v85);
    end;

    if v73 > 0 then
        local v86 = require(Parent.Crates.CrateCatalog).get(v74);
        local v87 = {
            image = v86 and v86.Icon or "",
            count = v73,
            name = v73 == 1 and "Crate Key" or "Crate Keys",
            color = Color3.fromRGB(255, 120, 200)
        };
        table.insert(v68, v87);
    end;

    return u1.show({
        v71 > 0 and { u1.spins(v71) } or {},
        v75,
        v76,
        v68
    }, v70, v69, p66, p67);
end;

return u1;