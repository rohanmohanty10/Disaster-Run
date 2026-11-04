  

game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(u1: userdata, u2, u3: number, u4: number) -- Line: 6, Name: highlightEffect
    -- upvalues: RunService (copy), Color3_fromRGB_ret (copy)
    local u5 = time();
    local u6 = nil;
    u6 = RunService.Heartbeat:Connect(function() -- Line: 9
        -- upvalues: u5 (copy), u1 (copy), u6 (ref), u4 (copy), u2 (copy), Color3_fromRGB_ret (ref), u3 (copy)
        local v7 = time() - u5;

        if not u1:IsDescendantOf(workspace) then
            u6:Disconnect();

            return;
        end;

        if u4 >= v7 then
            u1:SetAttribute("HighlightOutline", Color3_fromRGB_ret:Lerp(u2, (math.clamp(v7 / u3, 0, 1))));

            return;
        end;

        local v8 = (v7 - u4) / 0.2;

        if v8 <= 1 then
            u1:SetAttribute("HighlightOutline", u2:Lerp(Color3_fromRGB_ret, v8));

            return;
        end;

        u6:Disconnect();
        u1:SetAttribute("HighlightOutline", nil);
    end);
end;