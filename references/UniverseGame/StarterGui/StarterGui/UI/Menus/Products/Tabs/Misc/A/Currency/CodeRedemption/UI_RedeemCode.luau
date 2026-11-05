  

 

return function(u1) -- Line: 1
    local u2 = u1.Knit.GetService("ShopService");
    local Parent = script.Parent;
    local u3 = nil;
    Parent.Redeem.MouseButton1Click:Connect(function() -- Line: 9
        -- upvalues: Parent (copy), u3 (ref), u2 (copy), u1 (copy)
        local Text = Parent.Code.Text;

        if u3 or #Text < 1 then
            return;
        end;

        u3 = true;
        task.delay(3, function() -- Line: 15
            -- upvalues: u3 (ref)
            u3 = nil;
        end);
        local v4, v5 = u2:RedeemCode(Text):expect();
        local v6 = type(v5) ~= "table" and {} or v5;
        local u7 = {
            Success = { "Code Redemption Success", (`[{Text}] was successfully redeemed`) },
            AlreadyRedeemed = { "Code Redemption Failed", (`[{Text}] is already redeemed`) },
            RedemptionFailed = { "Code Redemption Failed", (`Something went wrong while redeeming [{Text}], please try again later`) },
            NotInGroup = { "Code Redemption Failed", "You must be in the group to redeem codes" },
            RequirementFailed = { "Code Redemption Failed", (`Level any ability [{v6[1]}] more times`) }
        };

        local function ResultHandler(p8) -- Line: 35
            -- upvalues: u7 (copy)
            if u7[p8] then
                return unpack(u7[p8]);
            end;

            if type(p8) == "string" then
                return "Code Redemption Failed", p8;
            end;

            return "Code Redemption Failed", "Code is expired or invalid";
        end;

        local v9;

        if u7[v4] then
            v9, v4 = unpack(u7[v4]);
        elseif type(v4) == "string" then
            v9 = "Code Redemption Failed";
        else
            v9 = "Code Redemption Failed";
            v4 = "Code is expired or invalid";
        end;

        u1.NewPrompt({
            Title = v9,
            Text = v4
        });
    end);
end;