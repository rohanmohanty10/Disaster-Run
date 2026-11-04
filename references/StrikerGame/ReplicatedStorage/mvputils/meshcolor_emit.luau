 

 

local TweenService = game:GetService("TweenService");
local u15 = {
    sequence = function(p1: userdata, u2: table, p3: number?, p4: any, p5: any, p6: number?) -- Line: 5, Name: sequence
        -- upvalues: TweenService (copy)
        local v7 = p3 or 0.3;
        local v8 = p4 or Enum.EasingStyle.Quad;
        local v9 = p5 or Enum.EasingDirection.Out;
        local u10 = {};
        local u11 = {};
        local u12 = p6 or v7;

        for _, descendant in ipairs(p1:GetDescendants()) do
            if descendant:IsA("BasePart") then
                table.insert(u10, descendant);
            elseif descendant:IsA("ParticleEmitter") then
                table.insert(u11, descendant);
            end;
        end;

        local TweenInfo_new_ret = TweenInfo.new(v7, v8, v9);
        local u13 = 1;

        local function tweenToNext() -- Line: 25
            -- upvalues: u2 (copy), u13 (ref), u10 (copy), TweenService (ref), TweenInfo_new_ret (copy), u11 (copy), u12 (copy), tweenToNext (copy)
            local v14 = u2[u13];

            if not v14 then
                return;
            end;

            for _, v in ipairs(u10) do
                if v and v.Parent then
                    TweenService:Create(v, TweenInfo_new_ret, {
                        Color = v14
                    }):Play();
                end;
            end;

            for _, v in ipairs(u11) do
                if v and v.Parent then
                    v.Color = ColorSequence.new(v14);
                end;
            end;

            u13 = u13 + 1;

            if u13 <= #u2 then
                task.delay(u12, tweenToNext);
            end;
        end;

        tweenToNext();
    end
};

function u15.random(p16: userdata, p17: table, p18: number?, p19: number?, p20: any, p21: any, p22: number?) -- Line: 50
    -- upvalues: u15 (copy)
    local v23 = {};

    for i = 1, p18 or #p17 do
        v23[i] = p17[math.random(1, #p17)];
        local _ = i;
    end;

    u15.sequence(p16, v23, p19, p20, p21, p22);
end;

return u15;