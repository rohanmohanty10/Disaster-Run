  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local AdventCalendarConfig = require(ReplicatedStorage.Shared.Configs.AdventCalendarConfig);
local u1 = nil;
local v2 = Knit.CreateController({
    Name = "AdventCalendarController"
});

function v2.KnitStart(u3) -- Line: 15
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("AdventCalendarService");
    u1.DataUpdated:Connect(function(p4) -- Line: 18
        -- upvalues: u3 (copy)
        u3:UpdateCalendarVisuals(p4);
    end);
    task.spawn(function() -- Line: 22
        -- upvalues: u1 (ref), u3 (copy)
        u3:UpdateCalendarVisuals((u1:GetStatus()));
        u3:StartCountdownLoop();
    end);
end;

function v2.UpdateCalendarVisuals(p5, p6) -- Line: 29
    -- upvalues: CollectionService (copy)
    if not p6 then
        return;
    end;

    local v7 = CollectionService:GetTagged("AdventCalendar")[1];

    if not v7 then
        return;
    end;

    local Attachment = v7:FindFirstChild("Attachment");
    local v8;

    if Attachment then
        v8 = Attachment:FindFirstChild("PromptHolder");
    else
        v8 = Attachment;
    end;

    local v9;

    if Attachment then
        v9 = Attachment:FindFirstChild("BillboardGui");
    else
        v9 = Attachment;
    end;

    local v10 = v9 and v9:FindFirstChild("CurrDay");

    if v10 then
        v10.Text = "Day " .. tostring(p6.Day + 1) .. ":";
    end;

    local Missed = v7:FindFirstChild("Missed");
    local Claimed = v7:FindFirstChild("Claimed");
    local Unclaimed = v7:FindFirstChild("Unclaimed");
    local Claimable = v7:FindFirstChild("Claimable");

    if not (Missed and (Claimed and (Unclaimed and Claimable))) then
        return;
    end;

    if Attachment then
        for _, child in ipairs(Attachment:GetChildren()) do
            if child:IsA("ProximityPrompt") then
                child:Destroy();
            end;
        end;
    end;

    local Day = p6.Day;
    local v11 = p6.History or {};
    local v12 = {};

    for _, v in ipairs({
        Missed,
        Claimed,
        Unclaimed,
        Claimable
    }) do
        for _, child in ipairs(v:GetChildren()) do
            if string.match(child.Name, "^Day%d+$") then
                table.insert(v12, child);
            end;
        end;
    end;

    for _, v in ipairs(v12) do
        local string_match_ret = string.match(v.Name, "^Day(%d+)$");
        local v13 = tonumber(string_match_ret);

        if v13 then
            local Days = v:FindFirstChild("Days");
            local v14;

            if Days then
                v14 = v;

                for _, child in ipairs(Days:GetChildren()) do
                    if child:IsA("ProximityPrompt") then
                        child:Destroy();
                    end;
                end;
            else
                v14 = v;
            end;

            local v15 = v11[tostring(v13)] == true;
            local v16;

            if v13 < Day then
                v16 = not v15;
            else
                v16 = false;
            end;

            local v17 = v13 == Day;

            if v15 then
                v14.Parent = Claimed;
            elseif v16 then
                v14.Parent = Missed;
            elseif v17 then
                v14.Parent = Claimable;
                p5:SetupActiveDay(v14, v8);
            else
                v14.Parent = Unclaimed;
            end;
        end;
    end;
end;

function v2.SetupActiveDay(p18, p19, p20) -- Line: 113
    -- upvalues: u1 (ref)
    if not p20 then
        return;
    end;

    local ProximityPrompt = script:FindFirstChild("ProximityPrompt");

    if ProximityPrompt then
        local u21 = ProximityPrompt:Clone();
        u21.Parent = p20;
        u21.ActionText = "Claim Reward";
        u21.ObjectText = "Day " .. string.match(p19.Name, "%d+");
        u21.Triggered:Connect(function() -- Line: 126
            -- upvalues: u21 (copy), u1 (ref)
            u21.Enabled = false;
            u1:Claim():andThen(function(p22, p23) -- Line: 128
                -- upvalues: u21 (ref)
                if not p22 then
                    warn(p23);
                    u21.Enabled = true;
                end;
            end);
        end);
    end;
end;

function v2.StartCountdownLoop(p24) -- Line: 138
    -- upvalues: RunService (copy), AdventCalendarConfig (copy), CollectionService (copy)
    local function FormatTime(p25) -- Line: 139
        local v26 = p25 < 0 and 0 or p25;
        local math_floor_ret = math.floor(v26 / 86400);
        local math_floor_ret2 = math.floor(v26 % 86400 / 3600);
        local math_floor_ret3 = math.floor(v26 % 3600 / 60);

        return string.format("%dd %02dh %02dm %02ds", math_floor_ret, math_floor_ret2, math_floor_ret3, v26 % 60);
    end;

    RunService.Stepped:Connect(function() -- Line: 152
        -- upvalues: AdventCalendarConfig (ref), CollectionService (ref)
        local UnixTimestamp = DateTime.now().UnixTimestamp;
        local UnixTimestamp2 = DateTime.fromUniversalTime(AdventCalendarConfig.StartDate.Year, AdventCalendarConfig.StartDate.Month, AdventCalendarConfig.StartDate.Day, -AdventCalendarConfig.TimezoneOffset, 0, 0).UnixTimestamp;
        local v27;

        if UnixTimestamp < UnixTimestamp2 then
            v27 = UnixTimestamp2 - UnixTimestamp;
        else
            local os_date_ret = os.date("!*t", UnixTimestamp + AdventCalendarConfig.TimezoneOffset * 3600);
            v27 = 86400 - (os_date_ret.hour * 3600 + os_date_ret.min * 60 + os_date_ret.sec);
        end;

        local v28 = v27 < 0 and 0 or v27;
        local math_floor_ret = math.floor(v28 / 86400);
        local math_floor_ret2 = math.floor(v28 % 86400 / 3600);
        local math_floor_ret3 = math.floor(v28 % 3600 / 60);
        local string_format_ret = string.format("%dd %02dh %02dm %02ds", math_floor_ret, math_floor_ret2, math_floor_ret3, v28 % 60);
        local v29 = CollectionService:GetTagged("AdventCalendar")[1];

        if v29 then
            local Attachment = v29:FindFirstChild("Attachment");

            if Attachment then
                Attachment = Attachment:FindFirstChild("BillboardGui");
            end;

            if Attachment then
                Attachment = Attachment:FindFirstChild("Label");
            end;

            if Attachment then
                Attachment.Text = string_format_ret;
            end;
        end;
    end);
end;

return v2;