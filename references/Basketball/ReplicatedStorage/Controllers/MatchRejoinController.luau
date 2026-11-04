 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local v1 = Knit.CreateController({
    Name = "MatchRejoinController"
});

function v1.KnitStart(p2) -- Line: 20
    -- upvalues: Knit (copy), RunService (copy), GetUnixTime (copy), NumberUtil (copy)
    local Service = Knit.GetService("MatchmakingService");
    local Reconnect = Knit.Player.PlayerGui.Reconnect;
    local v3, v4 = Service:CheckAbandonedMatch();

    if v3 then
        local u5 = v4 - 15;
        local u6 = nil;
        u6 = RunService.PreRender:Connect(function() -- Line: 31
            -- upvalues: GetUnixTime (ref), u5 (copy), Reconnect (copy), u6 (ref), NumberUtil (ref)
            if u5 <= GetUnixTime() then
                Reconnect.Enabled = false;
                u6:Disconnect();

                return;
            end;

            local v7 = u5 - GetUnixTime();
            local v8 = NumberUtil.AdaptiveClockString(v7);
            Reconnect.BG.ConfirmBG.Message.Text = `You disconnected from a match. You must reconnect within {v8} to not get penalized.`;
        end);
        Reconnect.BG.Reconnect.Activated:Connect(function() -- Line: 46
            -- upvalues: Reconnect (copy), Service (copy)
            Reconnect.Enabled = false;
            Service:RejoinMatch();
        end);
        local u9 = false;
        Reconnect.BG.Abandon.Activated:Connect(function() -- Line: 52
            -- upvalues: u9 (ref), Reconnect (copy)
            if u9 then
                Reconnect.Enabled = false;

                return;
            end;

            u9 = true;
            Reconnect.BG.Abandon.YesText.Text = "YOU SURE?";
        end);
        Reconnect.Enabled = true;
    end;
end;

return v1;