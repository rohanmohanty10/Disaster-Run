  

 

local u1 = {};
u1.__index = u1;
local Xtal = require(game.ReplicatedStorage:WaitForChild("Xtal"));
local Templates = script:WaitForChild("Templates");
local NumberSlider = require(script:WaitForChild("NumberSlider"));
local ColorPicker = require(script:WaitForChild("ColorPicker"));
local u2 = game.Players.LocalPlayer:GetMouse();

function u1.new(p3, ...) -- Line: 12
    -- upvalues: u1 (copy), Templates (copy), NumberSlider (copy), ColorPicker (copy), u2 (copy), Xtal (copy)
    local u4 = setmetatable({}, u1);
    u4.Option = nil;
    u4.Type = p3;

    if p3 == "Border" then
        u4.Option = Templates.Border:Clone();
    elseif p3 ~= "Input" then
        if p3 == "Selection" then
            u4.Option = Templates.Selection:Clone();
            u4.Index = ...;
            u4.Option.Button.MouseButton1Click:Connect(function() -- Line: 26
                -- upvalues: u4 (copy)
                local v5 = table.find(u4.Index, u4.Activated) + 1;
                local v6 = #u4.Index < v5 and 1 or v5;

                if u4.Index[v6] then
                    u4:Select(u4.Index[v6]);
                end;
            end);
            u4.Option.Button.MouseButton2Click:Connect(function() -- Line: 37
                -- upvalues: u4 (copy)
                local v7 = table.find(u4.Index, u4.Activated) - 1;
                local v8 = v7 < 1 and #u4.Index or v7;

                if u4.Index[v8] then
                    u4:Select(u4.Index[v8]);
                end;
            end);
        elseif p3 == "Slider" then
            u4.Option = Templates.Slider:Clone();
            u4.Slider = NumberSlider.new(function(p9) -- Line: 50
                -- upvalues: u4 (copy)
                u4.Updated:Fire(u4.Option.Box.Text);
                u4:SetText((tostring(p9)));
            end, u4.Option, ...);
            u4.Option.Box.FocusLost:Connect(function() -- Line: 55
                -- upvalues: u4 (copy)
                u4.Slider:Set(tonumber(u4.Option.Box.Text) or 0, true);
                u4.Updated:Fire(u4.Option.Box.Text);
            end);
        elseif p3 == "TextBox" then
            u4.Option = Templates.TextBox:Clone();
            u4.Option.Box.FocusLost:Connect(function() -- Line: 62
                -- upvalues: u4 (copy)
                u4.Updated:Fire(u4.Option.Box.Text);
            end);
        elseif p3 == "Toggle" then
            u4.Option = Templates.Toggle:Clone();
            u4.Activated = false;
            u4.Option.Button.MouseButton1Click:Connect(function() -- Line: 69
                -- upvalues: u4 (copy)
                u4:Toggle(not u4.Activated);
            end);
        elseif p3 == "Color" then
            u4.Option = Templates.Color:Clone();
            u4.Activated = false;
            local u10 = nil;
            u4.Option.Button.MouseButton1Click:Connect(function() -- Line: 76
                -- upvalues: u10 (ref), ColorPicker (ref), u4 (copy), u2 (ref)
                if u10 then
                    u10:Destroy();
                    u10 = nil;
                end;

                u10 = ColorPicker.New(u4.Option:FindFirstAncestorWhichIsA("ScreenGui"), u2, {
                    Draggable = true,
                    RoundedCorners = false,
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                });
                u10:SetColor(u4.Option.Button.BackgroundColor3);
                u10.Finished:Connect(function(p11) -- Line: 89
                    -- upvalues: u4 (ref), u10 (ref)
                    u4:SetColor(p11);
                    u10 = nil;
                end);
                u10.Canceled:Connect(function(p12) -- Line: 94
                    -- upvalues: u10 (ref)
                    u10 = nil;
                end);
            end);
        end;
    end;

    u4.Updated = Xtal.new("Signal");

    return u4;
end;

function u1.Select(p13, p14) -- Line: 105
    if p13.Type == "Selection" then
        if not table.find(p13.Index, p14) then
            p14 = p13.Index[1];
        end;

        p13.Activated = p14;
        p13.Updated:Fire(p13.Activated);
        p13.Option.Button.Text = p13.Activated;
    end;
end;

function u1.SetText(p15, ...) -- Line: 116
    if p15.Type == "TextBox" or p15.Type == "Slider" then
        p15.Option.Box.Text = ... or "";
        p15.Text = ... or "";
        p15.Updated:Fire(p15.Option.Box.Text);
    end;
end;

function u1.Toggle(p16, p17) -- Line: 124
    if p16.Type == "Toggle" then
        p16.Activated = p17;
        local v18 = 12 * (p16.Activated and 1 or -1);

        if p16.Option:IsDescendantOf(game) then
            p16.Option.Button.Slider:TweenPosition(UDim2.new(0.5, v18, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2, true);
        else
            p16.Option.Button.Slider.Position = UDim2.new(0.5, v18, 0.5, 0);
        end;

        p16.Updated:Fire(p16.Activated);
    end;
end;

function u1.SetColor(p19, p20) -- Line: 137
    if p19.Type ~= "Color" then
        return;
    end;

    p19.Option.Button.BackgroundColor3 = p20;
    p19.Updated:Fire(p20);
end;

function u1.SetRawData(p21, p22) -- Line: 143
    p21.RawData = p22;
end;

function u1.GetRawData(p23) -- Line: 147
    return p23.RawData;
end;

function u1.Destroy(p24) -- Line: 151
    p24.Option:Destroy();
    p24.Updated:Disconnect();

    if p24.Slider then
        p24.Slider:Destroy();
    end;

    setmetatable(p24, nil);
end;

return u1;