  

 

local function HasPositive(p1) -- Line: 1
    for _, v in p1 do
        if v == true then
            return true;
        end;
    end;

    return false;
end;

return function(u2) -- Line: 14
    local Assets = script.Parent.Assets;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local Knit = u2.Knit;
    Knit.GetService("LevelService");
    local u3 = Knit.GetService("StatService");
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);

    if LocalPlayer then
        LocalPlayer:FindFirstChild("Data");
    end;

    local Ability = LocalPlayer.Data:WaitForChild("Ability");
    local _ = Assets.StatInfo;
    local _ = Assets.InfoText;
    local u4 = require(script.StatsUI).new(script.Parent, u2);
    u2.MenuSignal:Connect(function(p5, p6) -- Line: 32
        -- upvalues: u4 (copy), Ability (copy)
        if p5 == "MenuUpdated" and p6 == "Ability" then
            u4:Load(Ability);
        end;
    end);
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 38
        -- upvalues: u4 (copy), Ability (copy)
        u4:Load(Ability);
    end);
    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 42
        -- upvalues: u4 (copy), Ability (copy)
        u4:Load(Ability);
    end);

    for _, v in { "MasteryRank", "MasteryPoints", "MasteryPointCap" } do
        LocalPlayer.Data.Ability:GetAttributeChangedSignal(v):Connect(function() -- Line: 53
            -- upvalues: u4 (copy), Ability (copy)
            u4:Load(Ability);
        end);
    end;

    u4:Load(Ability);
    u2.MenuButtonIndicators = {};

    function u2.AddButtonIndicator(p7, p8, p9) -- Line: 62
        -- upvalues: u4 (copy)
        return u4:AddButtonIndicator(p8, p9);
    end;

    function u2.RemoveButtonIndicator(p10, p11) -- Line: 66
        -- upvalues: u4 (copy)
        return u4:RemoveButtonIndicator(p11);
    end;

    function u2.ToggleMenuButtonIndicator(p12, p13, p14) -- Line: 70
        p12.MenuButtonIndicators[p13] = p14;
    end;

    local u15 = { script.Parent.Parent.Parent.Buttons.Stats, script.Parent.Parent.Parent.Parent.Menu.Ability };
    u2.BindToClock("RerollUpdate", 1, "PreRender", function() -- Line: 79, Name: UpdateIndiactors
        -- upvalues: u3 (copy), LocalPlayer (copy), u2 (copy), u15 (copy)
        if (u3:GetAbilityStats(LocalPlayer.Data.Ability.Value):expect() or {}).StatPoints > 0 then
            u2:ToggleMenuButtonIndicator("StatsUI", true);

            for i = 1, #u15 do
                u2:AddButtonIndicator(u15[i]);
            end;
        else
            u2:ToggleMenuButtonIndicator("StatsUI", false);

            for i = 1, #u15 do
                u2:RemoveButtonIndicator(u15[i]);
            end;
        end;

        local v16 = false;

        for _, v in u2.MenuButtonIndicators do
            if v == true then
                v16 = true;
                break;
            end;
        end;

        if v16 then
            u2:AddButtonIndicator(u2.UI.Buttons.MenuButton);

            return;
        end;

        u2:RemoveButtonIndicator(u2.UI.Buttons.MenuButton);
    end);
end;