  

 

local StarterGui = game:GetService("StarterGui");
local RunService = game:GetService("RunService");

return function(p1) -- Line: 4
    -- upvalues: StarterGui (copy), RunService (copy)
    local Parent = script.Parent;
    local Timer = Parent.Timer;
    local Payouts = Parent.Payouts;
    local u2 = {};

    local function Init() -- Line: 12
        -- upvalues: StarterGui (ref), RunService (ref)
        (function(p3, ...) -- Line: 14, Name: CoreCall
            -- upvalues: StarterGui (ref), RunService (ref)
            local v4 = {};

            for _ = 1, 8 do
                v4 = { pcall(StarterGui[p3], StarterGui, ...) };

                if v4[1] then
                    break;
                end;

                RunService.Stepped:Wait();
            end;

            return unpack(v4);
        end)("SetCore", "ResetButtonCallback", false);
    end;

    function p1.UpdateAfkWorldRewards(p5, p6) -- Line: 29
        -- upvalues: Parent (copy), u2 (copy), Payouts (copy)
        if not Parent.Visible then
            Parent.Visible = true;
        end;

        local RewardName = p6.RewardName;
        local Amount = p6.Amount;

        if u2[RewardName] then
            u2[RewardName] = u2[RewardName] + Amount;
        else
            u2[RewardName] = Amount;
        end;

        local v7 = u2[RewardName];
        local v8 = Payouts:FindFirstChild(RewardName);

        if v8 then
            local v9 = RewardName == "UShards" and "U<s>s</s>" or RewardName;
            v8.Text = `{v9} payout: {v7} {v9}`;
        end;
    end;

    function p1.UpdateAfkWorldTime(p10, p11) -- Line: 52
        -- upvalues: Parent (copy), Timer (copy)
        if not Parent.Visible then
            Parent.Visible = true;
            p10.UI:SetAttribute("AfkWorldEnabled", true);
        end;

        Timer.Text = p11;
    end;
end;