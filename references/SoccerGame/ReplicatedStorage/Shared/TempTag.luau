  

local v1 = {};
local u2 = {};
local u3 = {};

function v1.temporaryTag(p4: number, p5: userdata, p6: string) -- Line: 6
    -- upvalues: u2 (copy)
    if u2[p5] and u2[p5][p6] then
        u2[p5][p6] = time() + p4;

        return;
    end;

    u2[p5] = {
        [p6] = time() + p4
    };
    p5:AddTag(p6);
end;

function v1.temporaryValue(p7: number, p8: userdata, p9: string, p10: any) -- Line: 15
    -- upvalues: u3 (copy)
    if u3[p8] then
        u3[p8][p9] = time() + p7;
    else
        u3[p8] = {
            [p9] = time() + p7
        };
    end;

    p8:SetAttribute(p9, p10);
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 24
    -- upvalues: u2 (copy), u3 (copy)
    for i, v in table.clone(u2) do
        if i:IsDescendantOf(game) then
            local v11 = i;
            local v12 = v;

            for i2, v2 in v do
                if v2 < time() then
                    v12[i2] = nil;
                    v11:RemoveTag(i2);
                end;
            end;
        else
            u2[i] = nil;
        end;
    end;

    for i, v in table.clone(u3) do
        if i:IsDescendantOf(game) then
            local v13 = i;
            local v14 = v;

            for i2, v2 in table.clone(v) do
                if v2 < time() then
                    v14[i2] = nil;
                    v13:SetAttribute(i2, nil);
                end;
            end;
        else
            u3[i] = nil;
        end;
    end;
end);

return v1;