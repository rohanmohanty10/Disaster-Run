 
 

local Players = game:GetService("Players");

return function(u1: userdata?, u2: userdata) -- Line: 3
    -- upvalues: Players (copy)
    if u1 then
        local v3;

        if u1 then
            v3 = u1.Character;
        else
            v3 = u1;
        end;

        local v4;

        if u2 then
            v4 = u2:FindFirstChildWhichIsA("Humanoid");
        else
            v4 = u2;
        end;

        if not (v3 and v4) then
            warn("critical assets are missing");

            return false;
        end;

        local setting = u1:FindFirstChild("setting");

        if not setting then
            warn("Player has no setting folder.");

            return false;
        end;

        local DuoMvp = setting:FindFirstChild("DuoMvp");

        if not DuoMvp then
            warn("Player has no DuoMvp setting.");

            return false;
        end;

        local Value = DuoMvp.Value;

        if Value == 0 then
            Value = u1.UserId;
            local success, result = pcall(function() -- Line: 30
                -- upvalues: Players (ref), u1 (copy)
                return Players:GetFriendsAsync(u1.UserId);
            end);

            if success then
                local success2, result2 = pcall(function() -- Line: 35
                    -- upvalues: result (copy)
                    return result:GetCurrentPage();
                end);

                if success2 and #result2 > 0 then
                    Value = result2[math.random(1, #result2)].Id;
                end;
            end;
        end;

        local function fetch(u5) -- Line: 45
            -- upvalues: Players (ref)
            local success, result = pcall(function() -- Line: 46
                -- upvalues: Players (ref), u5 (copy)
                return Players:GetHumanoidDescriptionFromUserId(u5);
            end);

            if success then
                return result;
            end;

            return nil;
        end;

        local success, result = pcall(function() -- Line: 46
            -- upvalues: Players (ref), Value (copy)
            return Players:GetHumanoidDescriptionFromUserId(Value);
        end);

        if not success then
            result = nil;
        end;

        if not result and Value ~= u1.UserId then
            warn((`Failed to fetch description of {Value}, falling back to player`));
            Value = u1.UserId;
            local u6 = Value;
            local v7;
            v7, result = pcall(function() -- Line: 46
                -- upvalues: Players (ref), u6 (copy)
                return Players:GetHumanoidDescriptionFromUserId(u6);
            end);

            if not v7 then
                result = nil;
            end;
        end;

        local v8;

        if result then
            v8 = result;
        else
            local u9 = v3:FindFirstChildWhichIsA("Humanoid");

            if u9 then
                local v10;
                v10, v8 = pcall(function() -- Line: 69
                    -- upvalues: u9 (copy)
                    return u9:GetAppliedDescription();
                end);

                if not v10 then
                    v8 = result;
                end;
            else
                v8 = result;
            end;
        end;

        local v11 = v3:FindFirstChildWhichIsA("Shirt");
        local v12 = v3:FindFirstChildWhichIsA("Pants");

        if not v8 then
            if v11 then
                v11:Clone().Parent = u2;
            end;

            if v12 then
                v12:Clone().Parent = u2;
            end;

            warn((`Failed to fetch description of {Value}`));

            return false;
        end;

        local v13;

        if v11 then
            v13 = v11:GetAttribute("jersey");
        else
            v13 = v11;
        end;

        if v13 then
            if v11 then
                v11:Clone().Parent = u2;
            end;

            if v12 then
                v12:Clone().Parent = u2;
            end;

            v8.Shirt = 0;
            v8.Pants = 0;
        end;

        v4:ApplyDescription(v8);
        pcall(function() -- Line: 112
            -- upvalues: Players (ref), Value (ref), u2 (copy)
            u2.Name = Players:GetNameFromUserIdAsync(Value);
        end);

        return true;
    end;
end;