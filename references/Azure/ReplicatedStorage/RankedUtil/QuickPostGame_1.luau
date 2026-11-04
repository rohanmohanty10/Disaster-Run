 
 

local Ranks = require(script.Parent.Ranks);
local u1 = {
    victory = "VICTORY!",
    loss = "DEFEAT",
    abandon = "ABANDONED"
};

local function find_continue_label(p2: userdata) -- Line: 25
    local Main = p2:FindFirstChild("Main");

    if Main and Main:IsA("TextLabel") then
        return Main;
    end;

    return p2:FindFirstChildWhichIsA("TextLabel", true);
end;

return {
    show = function(u3: table, p4: table, p5: number) -- Line: 35, Name: show
        -- upvalues: u1 (copy), Ranks (copy)
        local match_results = u3.match_results;
        local match_results_all = u3.match_results_all;
        match_results_all.GroupTransparency = 0;
        match_results_all.Visible = true;
        match_results.GameResult.Text = u1[p4.result or ""] or "?";
        match_results.Role.Text = p4.position or "??";

        for _, child in match_results.MyResults:GetChildren() do
            if child:IsA("GuiObject") then
                local v6 = p4.stats and p4.stats[child.Name];

                if v6 ~= nil then
                    child.Text = `{child.Text:split(": ")[1]}: {v6}`;
                end;

                child.Position = UDim2.fromScale(0, child.Position.Y.Scale);
            end;
        end;

        match_results.MyResults.GroupTransparency = 0;
        local v7 = p4.elo_delta or 0;
        local v8 = Ranks.ReturnRank(p5 - v7);
        local v9 = Ranks.ReturnRank(p5);
        local Color = v8:GetColor();
        match_results.RankIcon.Image = v9.Icon;
        match_results.Rank.UIGradient.Color = Color;
        match_results.Glow.UIGradient.Color = Color;
        match_results.Rank.Text = v9.Name:upper();
        local v10;

        if v7 > 0 then
            v10 = true;
        elseif v7 == 0 then
            v10 = p4.result == "victory";
        else
            v10 = false;
        end;

        local v11 = v10 and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 46, 46);
        local math_round_ret = math.round(v11.R * 255);
        local math_clamp_ret = math.clamp(math_round_ret, 0, 255);
        local math_round_ret2 = math.round(v11.G * 255);
        local math_clamp_ret2 = math.clamp(math_round_ret2, 0, 255);
        local math_round_ret3 = math.round(v11.B * 255);
        local math_clamp_ret3 = math.clamp(math_round_ret3, 0, 255);
        match_results.Progress.Text = `ELO: <font color='rgb({math_clamp_ret}, {math_clamp_ret2}, {math_clamp_ret3})'>{p5}</font> ({v10 and "+" or ""}{math.round(v7)})`;
        match_results.Elo.Visible = false;
        match_results.MVP.ImageTransparency = p4.was_mvp and 0 or 1;
        local Continue = match_results:FindFirstChild("Continue");

        if Continue and Continue:IsA("GuiObject") then
            Continue.Visible = true;
            Continue.GroupTransparency = 0;
            local v12 = Continue:FindFirstChildOfClass("UIStroke");

            if v12 then
                v12.Transparency = 0.5;
            end;
        end;

        local continue_label = u3.continue_label;

        if not continue_label and Continue then
            continue_label = Continue:FindFirstChild("Main");

            if not (continue_label and continue_label:IsA("TextLabel")) then
                continue_label = Continue:FindFirstChildWhichIsA("TextLabel", true);
            end;
        end;

        if continue_label then
            continue_label.Text = "Next";
        end;

        local continue_button = u3.continue_button;
        local v13;

        if continue_button or not Continue then
            v13 = continue_button;
        else
            v13 = Continue:FindFirstChild("Button");

            if v13 then
                if not v13:IsA("GuiButton") then
                    v13 = continue_button;
                end;
            else
                v13 = continue_button;
            end;
        end;

        if v13 then
            v13.MouseButton1Click:Once(function() -- Line: 106
                -- upvalues: match_results_all (copy), u3 (copy)
                match_results_all.Visible = false;
                u3.on_continue();
            end);
        end;
    end
};