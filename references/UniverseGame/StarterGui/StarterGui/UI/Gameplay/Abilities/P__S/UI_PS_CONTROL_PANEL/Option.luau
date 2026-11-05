  

 

local u1 = {};
u1.__index = u1;
local Xtal = require(game.ReplicatedStorage:WaitForChild("Xtal"));
local Templates = script:WaitForChild("Templates");
local NumberSlider = require(script:WaitForChild("NumberSlider"));

function u1.new(p2, ...) -- Line: 9
    -- upvalues: u1 (copy), Templates (copy), NumberSlider (copy), Xtal (copy)
    local u3 = setmetatable({}, u1);
    u3.Option = nil;
    u3.Type = p2;

    if p2 == "Border" then
        u3.Option = Templates.Border:Clone();
    elseif p2 ~= "Input" then
        if p2 == "Selection" then
            u3.Option = Templates.Selection:Clone();
            u3.Index = ...;
            u3.Option.Button.MouseButton1Click:Connect(function() -- Line: 23
                -- upvalues: u3 (copy)
                local v4 = table.find(u3.Index, u3.Activated) + 1;
                local v5 = #u3.Index < v4 and 1 or v4;

                if u3.Index[v5] then
                    u3:Select(u3.Index[v5]);
                end;
            end);
            u3.Option.Button.MouseButton2Click:Connect(function() -- Line: 34
                -- upvalues: u3 (copy)
                local v6 = table.find(u3.Index, u3.Activated) - 1;
                local v7 = v6 < 1 and #u3.Index or v6;

                if u3.Index[v7] then
                    u3:Select(u3.Index[v7]);
                end;
            end);
        elseif p2 == "Slider" then
            u3.Option = Templates.Slider:Clone();
            u3.Slider = NumberSlider.new(function(p8) -- Line: 47
                -- upvalues: u3 (copy)
                u3.Updated:Fire(u3.Option.Box.Text);
                u3:SetText((tostring(p8)));
            end, u3.Option, ...);
            u3.Option.Box.FocusLost:Connect(function() -- Line: 52
                -- upvalues: u3 (copy)
                u3.Slider:Set(tonumber(u3.Option.Box.Text) or 0, true);
                u3.Updated:Fire(u3.Option.Box.Text);
            end);
        elseif p2 == "TextBox" then
            u3.Option = Templates.TextBox:Clone();
            u3.Option.Box.FocusLost:Connect(function() -- Line: 59
                -- upvalues: u3 (copy)
                u3.Updated:Fire(u3.Option.Box.Text);
            end);
        elseif p2 == "Toggle" then
            u3.Option = Templates.Toggle:Clone();
            u3.Activated = false;
            u3.Option.Button.MouseButton1Click:Connect(function() -- Line: 66
                -- upvalues: u3 (copy)
                u3:Toggle(not u3.Activated);
            end);
        end;
    end;

    u3.Updated = Xtal.new("Signal");

    return u3;
end;

function u1.Select(p9, p10) -- Line: 76
    if p9.Type == "Selection" then
        if not table.find(p9.Index, p10) then
            p10 = p9.Index[1];
        end;

        p9.Activated = p10;
        p9.Updated:Fire(p9.Activated);
        p9.Option.Button.Text = p9.Activated;
    end;
end;

function u1.SetText(p11, ...) -- Line: 87
    if p11.Type == "TextBox" or p11.Type == "Slider" then
        p11.Option.Box.Text = ... or "";
        p11.Text = ... or "";
        p11.Updated:Fire(p11.Option.Box.Text);
    end;
end;

function u1.Toggle(p12, p13) -- Line: 95
    if p12.Type == "Toggle" then
        p12.Activated = p13;
        local v14 = 12 * (p12.Activated and 1 or -1);

        if p12.Option:IsDescendantOf(game) then
            p12.Option.Button.Slider:TweenPosition(UDim2.new(0.5, v14, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2, true);
        else
            p12.Option.Button.Slider.Position = UDim2.new(0.5, v14, 0.5, 0);
        end;

        p12.Updated:Fire(p12.Activated);
    end;
end;

function u1.Destroy(p15) -- Line: 108
    p15.Option:Destroy();
    p15.Updated:Disconnect();

    if p15.Slider then
        p15.Slider:Destroy();
    end;

    setmetatable(p15, nil);
end;

return u1;