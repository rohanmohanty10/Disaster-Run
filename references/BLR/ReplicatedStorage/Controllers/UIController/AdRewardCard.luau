  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RunService = game:GetService("RunService");
local Icons = require(ReplicatedStorage.Shared.Configs.Icons);
local ItemRarities = require(ReplicatedStorage.Shared.ItemRarities);
local Inventory = ReplicatedStorage.Shared.Inventory;
local BallSkins = require(Inventory.BallSkins);
local Cards = require(Inventory.Cards);
local Cosmetics = require(Inventory.Cosmetics);
local GoalEffects = require(Inventory.GoalEffects);
local StyleSkins = require(Inventory.StyleSkins);
local v1 = Knit.CreateController({
    Name = "AdRewardCard"
});
local u2 = nil;
local Color3_fromRGB_ret = Color3.fromRGB(140, 196, 80);
local Color3_fromRGB_ret2 = Color3.fromRGB(127, 140, 141);

local function getInventoryRarity(p3: string, p4: string?) -- Line: 46
    -- upvalues: GoalEffects (copy), Cosmetics (copy), BallSkins (copy), StyleSkins (copy), Cards (copy)
    if not p4 or p4 == "" then
        return nil;
    end;

    if p3 == "GoalEffect" and GoalEffects[p4] then
        return GoalEffects[p4];
    end;

    if p3 == "Cosmetic" and Cosmetics[p4] then
        return Cosmetics[p4];
    end;

    if p3 == "BallSkin" and BallSkins[p4] then
        return BallSkins[p4];
    end;

    if p3 == "Style" and StyleSkins[p4] then
        return StyleSkins[p4];
    end;

    if p3 == "Card" and Cards[p4] then
        return Cards[p4];
    end;

    return nil;
end;

local function getCardColor(p5: string, p6: string?) -- Line: 74
    -- upvalues: Color3_fromRGB_ret (copy), getInventoryRarity (copy), ItemRarities (copy), Color3_fromRGB_ret2 (copy)
    if p5 == "Money" then
        return Color3_fromRGB_ret;
    end;

    local v7 = getInventoryRarity(p5, p6);

    if v7 and (ItemRarities[v7] and ItemRarities[v7].Color) then
        return ItemRarities[v7].Color;
    end;

    return Color3_fromRGB_ret2;
end;

local function formatNumberWithCommas(p8: number) -- Line: 87
    local math_floor_ret = math.floor(p8);
    local v9 = tostring(math_floor_ret);
    local v10;

    repeat
        v9, v10 = v9:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v10 == 0;

    return v9;
end;

local function formatSpinText(p11: string, p12: number?) -- Line: 98
    local v13 = tonumber(p12) or 1;

    return string.format("+%d %s", v13, ({
        styleSpins = "Style Spins",
        flowSpins = "Flow Spins",
        luckyStyleSpins = "Lucky Spins",
        luckyFlowSpins = "Lucky Flow Spins",
        gachaSpins = "Crate Spins",
        gachaLuckySpins = "Lucky Crate Spins",
        wheelSpins = "Wheel Spins",
        isagiWheelTokens = "Isagi Tokens",
        eventSpins = "Event Spins"
    })[p11] or p11);
end;

function v1.CreateCard(p14: table, p15: string, p16: number, p17: userdata, p18: string, p19: string, p20: number?, p21: boolean?) -- Line: 121
    -- upvalues: getInventoryRarity (copy), Color3_fromRGB_ret (copy), ItemRarities (copy), Color3_fromRGB_ret2 (copy), RunService (copy), formatNumberWithCommas (copy), formatSpinText (copy), u2 (ref), ReplicatedStorage (copy), Icons (copy)
    local u22 = p17:Clone();
    u22.Name = ("AdRewardCard_%s_%d"):format(p15, p16);
    local Box = u22.Box;
    local Backdrop = Box.Backdrop;
    local rewardinfo = Box.rewardinfo;
    local Text = rewardinfo.Text;
    local RewardIcon = rewardinfo.RewardIcon;
    u22:SetAttribute("RewardItemId", p15);
    u22:SetAttribute("RewardIndex", p16);
    u22:SetAttribute("RewardType", p18);
    u22:SetAttribute("RewardName", p19);
    local v23 = getInventoryRarity(p18, p19);

    if v23 then
        u22:SetAttribute("RewardRarity", v23);
    end;

    if (p18 == "Money" or p18:find("Spins")) and typeof(p20) == "number" then
        u22:SetAttribute("RewardAmount", p20);
    end;

    local v24 = p21 == true;
    u22:SetAttribute("RainbowBackdrop", v24);

    if v24 then
        local u25 = nil;
        u25 = RunService.RenderStepped:Connect(function() -- Line: 164
            -- upvalues: u22 (copy), u25 (ref), Backdrop (copy)
            if not (u22 and u22.Parent) then
                if u25 then
                    u25:Disconnect();
                end;

                return;
            end;

            local v26 = tick() % 10 / 10;
            Backdrop.ImageColor3 = Color3.fromHSV(v26, 0.8, 1);
        end);
    else
        local v27;

        if p18 == "Money" then
            v27 = Color3_fromRGB_ret;
        else
            local v28 = getInventoryRarity(p18, p19);

            if v28 and (ItemRarities[v28] and ItemRarities[v28].Color) then
                v27 = ItemRarities[v28].Color;
            else
                v27 = Color3_fromRGB_ret2;
            end;
        end;

        Backdrop.ImageColor3 = v27;
    end;

    local v29 = {
        styleSpins = true,
        flowSpins = true,
        luckyStyleSpins = true,
        luckyFlowSpins = true,
        gachaSpins = true,
        gachaLuckySpins = true,
        wheelSpins = true,
        isagiWheelTokens = true,
        eventSpins = true
    };

    if p18 == "Money" and (typeof(p20) == "number" and p20 > 0) then
        Text.Text = formatNumberWithCommas(p20);
    elseif v29[p18] then
        Text.Text = formatSpinText(p18, p20);
    else
        if p19 ~= "" then
            p15 = p19 or p15;
        end;

        Text.Text = p15;
    end;

    if p18 == "Cosmetic" and u2 then
        RewardIcon.Image = "";
        local v30 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(p19);

        if v30 then
            local v31 = u2:CreateCosmeticIcon(v30);
            v31.Size = UDim2.fromScale(1, 1);
            v31.AnchorPoint = Vector2.new(0.5, 0.5);
            v31.Position = UDim2.fromScale(0.5, 0.5);
            v31.Parent = RewardIcon;

            return u22;
        end;
    else
        local v32 = nil;
        local v33;

        if p18 == "Money" then
            v33 = "rbxassetid://72060219740081";
        elseif p18 == "GoalEffect" then
            v33 = Icons.GoalEffects and Icons.GoalEffects[p19];
        elseif p18 == "BallSkin" then
            v33 = Icons.BallSkins and Icons.BallSkins[p19];
        elseif p18 == "Special" then
            v33 = "rbxassetid://125339871021518";

            if script:FindFirstChild("UIGradient") then
                script.UIGradient:Clone().Parent = RewardIcon;
            end;

            Instance.new("UIAspectRatioConstraint").Parent = RewardIcon;
        else
            v33 = p18 == "styleSpins" and "rbxassetid://125339871021518" or (p18 == "flowSpins" and "rbxassetid://133558083095603" or (p18 == "luckyStyleSpins" and "rbxassetid://125339871021518" or ((p18 == "luckyFlowSpins" or (p18 == "gachaSpins" or (p18 == "gachaLuckySpins" or (p18 == "wheelSpins" or p18 == "isagiWheelTokens")))) and "rbxassetid://133558083095603" or (p18 == "eventSpins" and "rbxassetid://133558083095603" or v32))));
        end;

        if (p18 == "luckyStyleSpins" or (p18 == "luckyFlowSpins" or p18 == "gachaLuckySpins")) and script:FindFirstChild("Lucky") then
            script.Lucky:Clone().Parent = RewardIcon;
        end;

        RewardIcon.Image = v33 or "rbxassetid://0";
    end;

    return u22;
end;

function v1.KnitStart(p34) -- Line: 275
    -- upvalues: Knit (copy), u2 (ref)
    if not script:FindFirstChild("ServiceActive") or script.ServiceActive.Value ~= true then
        print("(CLIENT) Ad Cards Disabled");

        return;
    end;

    print("(CLIENT) Ad Cards Service Booted Successfully");
    local success, result = pcall(function() -- Line: 283
        -- upvalues: Knit (ref)
        return Knit.GetController("CosmeticIcon");
    end);

    if success then
        u2 = result;
    end;

    print("(CLIENT) AdRewardCard started");
end;

return v1;