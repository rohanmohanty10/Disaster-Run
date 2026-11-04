  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local SalaryConfig = require(ReplicatedStorage.Shared.Configs.SalaryConfig);
local Popup = require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local v1 = Knit.CreateController({
    Name = "NelPedestalController"
});

local function commas(p2) -- Line: 28
    local v3 = tonumber(p2) or 0;
    local math_floor_ret = math.floor(v3);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function shortReq(p4) -- Line: 34
    local v5 = tonumber(p4) or 0;

    if v5 >= 1000000000 then
        return string.format("¥%.1fb+", v5 / 1000000000);
    end;

    if v5 >= 1000000 then
        return string.format("¥%dm+", (math.floor(v5 / 1000000)));
    end;

    if v5 >= 1000 then
        return string.format("¥%dk+", (math.floor(v5 / 1000)));
    end;

    return "¥" .. tostring(v5) .. "+";
end;

local u6 = {
    StyleSpins = "Style Spins",
    FlowSpins = "Flow Spins",
    LuckyStyleSpins = "Lucky Style Spins",
    LuckyFlowSpins = "Lucky Flow Spins",
    GachaSpins = "Crate Spins"
};

local function buildRewardLines(p7) -- Line: 50
    -- upvalues: SalaryConfig (copy), commas (copy), u6 (copy)
    local v8 = SalaryConfig.CareerRewardBrackets[p7];

    if not v8 then
        return {};
    end;

    local v9 = {};

    for _, v in SalaryConfig.RewardPools[v8.RewardPool] or {} do
        local v10 = nil;

        if v.MinAmount and v.MaxAmount then
            local string_format = string.format;
            local v11 = tonumber(v.MinAmount) or 0;
            local math_floor_ret = math.floor(v11);
            v10 = string_format("%s-%s", tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), commas(v.MaxAmount));
        elseif v.Amount then
            local v12 = tonumber(v.Amount) or 0;
            local math_floor_ret = math.floor(v12);
            v10 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        end;

        if v.Type == "Money" then
            table.insert(v9, string.format("¥ %s", v10 or ""));
        elseif v.Type == "GoalEffect" or (v.Type == "Cosmetic" or (v.Type == "BallSkin" or (v.Type == "PlayerCard" or v.Type == "Emote"))) then
            table.insert(v9, v.Display or (v.Name or ""));
        else
            local v13 = u6[v.Type] or v.Type;

            if v.Type == "EventSpins" then
                v13 = (v.EventName or "Event") .. " Spins";
            end;

            table.insert(v9, string.format("%s %s", v10 or "", v13));
        end;
    end;

    return v9;
end;

function v1.KnitStart(p14) -- Line: 83
    -- upvalues: Knit (copy), ReplicatedStorage (copy), SalaryConfig (copy), shortReq (copy), buildRewardLines (copy), PlayerGui (copy), LocalPlayer (copy), Popup (copy), CollectionService (copy)
    local Service = Knit.GetService("SalaryService");
    local PedastalRewardsBB = ReplicatedStorage.Assets.UI:WaitForChild("PedastalRewardsBB");
    local u15 = PedastalRewardsBB:FindFirstChild("Reward"):Clone();
    u15.Name = "RewardLineTemplate";
    local u16 = {};

    local function populate(p17, p18) -- Line: 94
        -- upvalues: u16 (copy), SalaryConfig (ref), shortReq (ref), buildRewardLines (ref), u15 (copy)
        local v19 = u16[p17];

        if not v19 then
            return;
        end;

        local bb = v19.bb;
        local v20 = SalaryConfig.CareerRewardBrackets[p17];

        if not v20 then
            return;
        end;

        local v21 = {};

        for _, v in p18 and (p18.ClaimedBracketsV2 or {}) or {} do
            v21[tonumber(v) or v] = true;
        end;

        local v22 = v21[p17] == true;
        local v23 = (p18 and p18.BestCareerYenV2 or 0) >= v20.MinYen;
        local RewardTitle = bb:FindFirstChild("RewardTitle");

        if RewardTitle then
            RewardTitle.Text = string.format("Reward %d:", p17);
        end;

        local Icon = bb:FindFirstChild("Icon");

        if Icon and Icon:IsA("ImageLabel") then
            local Icon2 = v20.Icon;

            if Icon2 and Icon2 ~= "" then
                Icon.Image = Icon2;
            end;
        end;

        local Requirement = bb:FindFirstChild("Requirement");

        if Requirement then
            local Color3_fromRGB_ret = Color3.fromRGB(180, 240, 190);
            local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);

            if v22 then
                Requirement.Text = "CLAIMED!!";
                Requirement.TextColor3 = Color3_fromRGB_ret;
            elseif v23 then
                Requirement.Text = shortReq(v20.MinYen);
                Requirement.TextColor3 = Color3_fromRGB_ret;
            else
                Requirement.Text = shortReq(v20.MinYen);
                Requirement.TextColor3 = Color3_fromRGB_ret2;
            end;
        end;

        for _, child in bb:GetChildren() do
            if child.Name == "RewardLine" then
                child:Destroy();
            end;
        end;

        local Reward = bb:FindFirstChild("Reward");

        if Reward then
            Reward.Visible = false;
        end;

        for i, v in buildRewardLines(p17) do
            local v24 = u15:Clone();
            v24.Name = "RewardLine";
            v24.Text = v;
            v24.Visible = true;
            v24.LayoutOrder = i + 1;
            v24.Parent = bb;
        end;

        v19.prompt.Enabled = not v22;
    end;

    local function bindPedestal(p25) -- Line: 175
        -- upvalues: u16 (copy), PedastalRewardsBB (copy), PlayerGui (ref), LocalPlayer (ref), Service (copy), Popup (ref), populate (copy)
        if not p25:IsDescendantOf(workspace) then
            return;
        end;

        local u26 = tonumber(p25:GetAttribute("Reward"));

        if not u26 then
            return;
        end;

        if u16[u26] then
            u16[u26].bb.Adornee = p25;
            u16[u26].prompt.Parent = p25;

            return;
        end;

        local v27 = PedastalRewardsBB:Clone();
        v27.Name = string.format("PedastalRewardsBB_%d", u26);
        v27.Adornee = p25;
        v27.MaxDistance = 100;
        v27.AlwaysOnTop = true;
        v27.Parent = PlayerGui;
        local BracketClaimPrompt = p25:FindFirstChild("BracketClaimPrompt");

        if BracketClaimPrompt then
            BracketClaimPrompt:Destroy();
        end;

        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.Name = "BracketClaimPrompt";
        ProximityPrompt.ActionText = "Claim Reward " .. u26;
        ProximityPrompt.ObjectText = "NEL Bracket";
        ProximityPrompt.MaxActivationDistance = 10;
        ProximityPrompt.HoldDuration = 0;
        ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.Enabled = true;
        ProximityPrompt.Parent = p25;
        ProximityPrompt.Triggered:Connect(function(p28) -- Line: 211
            -- upvalues: LocalPlayer (ref), Service (ref), u26 (copy), Popup (ref)
            if p28 ~= LocalPlayer then
                return;
            end;

            local v29, v30 = Service:ClaimBracketReward(u26);

            if not v29 then
                Popup.Popup(nil, v30 or "Could not claim this reward");
            end;
        end);
        u16[u26] = {
            bb = v27,
            pedestal = p25,
            prompt = ProximityPrompt
        };
        populate(u26, Service:GetSalaryState());
    end;

    local function refreshAll() -- Line: 168
        -- upvalues: Service (copy), u16 (copy), populate (copy)
        local SalaryState = Service:GetSalaryState();

        for i in u16 do
            populate(i, SalaryState);
        end;
    end;

    for _, v in CollectionService:GetTagged("RewardPedastals") do
        bindPedestal(v);
    end;

    CollectionService:GetInstanceAddedSignal("RewardPedastals"):Connect(bindPedestal);
    CollectionService:GetInstanceRemovedSignal("RewardPedastals"):Connect(function(p31) -- Line: 235
        -- upvalues: u16 (copy)
        local v32 = tonumber(p31:GetAttribute("Reward"));

        if not v32 then
            return;
        end;

        local v33 = u16[v32];

        if not v33 then
            return;
        end;

        if v33.bb then
            v33.bb:Destroy();
        end;

        if v33.prompt then
            v33.prompt:Destroy();
        end;

        u16[v32] = nil;
    end);
    Service.BracketRewardClaimed:Connect(refreshAll);
    Service.NewBestCareer:Connect(refreshAll);
end;

return v1;