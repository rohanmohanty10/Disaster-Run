  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

return function(p1) -- Line: 6
    -- upvalues: TweenService (copy), RunService (copy)
    local v2 = p1 or {};
    local v3 = v2.Transparency or 1;
    local u4 = v2.Lifetime or 0.5;
    local v5 = v2.TextureSpeed or 0;
    local u6 = Enum.EasingStyle[v2.Style or "Sine"];
    local u7 = Enum.EasingDirection[v2.Direction or "Out"];

    for _, descendant in v2.Effect:GetDescendants() do
        if descendant:IsA("Beam") then
            local Keypoints = descendant.Transparency.Keypoints;
            local _ = #Keypoints;
            local v8 = nil;
            local v9 = nil;

            if typeof(v3) == "number" then
                v9 = v3;
                v8 = v9;
                local v10 = v9;
                v9 = v8;
                v10 = v8;
            elseif typeof(v3) == "string" then
                local v11, v12 = v3:match("([^,]+),([^,]+)");
                v8 = tonumber(v11);
                v9 = tonumber(v12);
            end;

            if v8 and not descendant.Enabled then
                descendant.Enabled = true;
                local u13 = {};
                local u14 = {};

                for i, v in ipairs(Keypoints) do
                    u13[i] = v.Value;
                    u14[i] = v8 + (v9 - v8) * v.Time;
                end;

                TweenService:Create(descendant, TweenInfo.new(u4, u6, u7), {
                    TextureSpeed = v5
                }):Play();
                local u15 = 0;
                local u16 = nil;
                u16 = RunService.Heartbeat:Connect(function(p17) -- Line: 58
                    -- upvalues: u15 (ref), u4 (copy), u16 (ref), descendant (copy), TweenService (ref), u6 (copy), u7 (copy), Keypoints (copy), u13 (copy), u14 (copy)
                    u15 = u15 + p17;

                    if u4 <= u15 then
                        u16:Disconnect();
                        u16 = nil;
                        descendant.Enabled = false;

                        return;
                    end;

                    local v18 = TweenService:GetValue(math.clamp(u15 / u4, 0, 1), u6, u7);
                    local v19 = {};

                    for i, v in ipairs(Keypoints) do
                        v19[i] = NumberSequenceKeypoint.new(v.Time, u13[i] + (u14[i] - u13[i]) * v18, v.Envelope);
                    end;

                    descendant.Transparency = NumberSequence.new(v19);
                end);
            end;
        end;
    end;
end;