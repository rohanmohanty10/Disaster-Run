  

 

local function CreateRainbow(p1, p2, p3, p4) -- Line: 1
    local v5 = {};

    for i = 1, p1 do
        local v6 = (i - 1) / (p1 - 1);
        table.insert(v5, ColorSequenceKeypoint.new(v6, Color3.fromHSV((v6 - p2) % 1, p3 or 1, p4 or 1)));
    end;

    return ColorSequence.new(v5);
end;

return function(p7, u8) -- Line: 11
    -- upvalues: CreateRainbow (copy)
    if not u8.Parent.Visible then
        return;
    end;

    local u9 = Random.new();
    local Label = u8.Button.Label;
    local UIStroke = u8.Button.UIStroke;
    local u10 = {};

    for _, v in { "Rotation", "Font", "Text", "TextColor3", "TextStrokeColor3", "Position", "TextStrokeTransparency", "TextTransparency" } do
        u10[v] = Label[v];
    end;

    local Color = UIStroke.Color;
    local RarityGradient = UIStroke:FindFirstChild("RarityGradient");
    local u11;

    if RarityGradient then
        u11 = RarityGradient.Color;
    else
        u11 = RarityGradient;
    end;

    local u12;

    if RarityGradient then
        u12 = RarityGradient.Rotation;
    else
        u12 = RarityGradient;
    end;

    local PathShortcuts = require(game:GetService("ReplicatedStorage").ReplicatedModules.PathShortcuts);
    require(PathShortcuts.KnitPath.Knit);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local FormData = require(PathShortcuts.ReplicatedModules.StatsFolder.Umbra.MAYHEM.Common).FormData;
    local u13 = Trove.new();
    u13:AttachToInstance(u8);
    local v14 = { "SHD", "FallenX", "Crazed", "Equinox" };
    local u15 = {};

    for i, v in FormData do
        if i ~= "Rainbow" and i ~= "Chaos" then
            local v16 = {
                Name = i,
                Font = v.Font,
                Color = v.PrimaryColor,
                StrokeColor = v.SecondaryColor,
                Combined = table.find(v14, i) and true or false
            };
            table.insert(u15, v16);
        end;
    end;

    local u17 = nil;
    u17 = {
        Recover = function(p18) -- Line: 127, Name: Recover
            -- upvalues: Label (copy), RarityGradient (copy), u10 (copy), UIStroke (copy), Color (copy), u11 (copy)
            if not (Label and (Label:FindFirstChild("UIGradient") and RarityGradient)) then
                return;
            end;

            for i, v in u10 do
                if not (p18 and table.find(p18, i)) then
                    Label[i] = v;
                end;
            end;

            if p18 and table.find(p18, "Gradient") then
                return;
            end;

            Label.UIGradient.Enabled = true;
            UIStroke.Color = Color;

            if RarityGradient then
                RarityGradient.Color = u11;
                RarityGradient.Enabled = true;
                RarityGradient:SetAttribute("IsEnabled", true);
            end;
        end,

        Glitch = function() -- Line: 146, Name: Glitch
            -- upvalues: RarityGradient (copy), u9 (copy), Label (copy), UIStroke (copy), u17 (ref)
            if not RarityGradient then
                return;
            end;

            RarityGradient.Enabled = false;
            RarityGradient:SetAttribute("IsEnabled", false);

            for _ = 1, u9:NextInteger(5, 20) do
                Label.Text = string.rep("-", u9:NextInteger(2, 10));
                Label.Position = UDim2.fromScale(0, u9:NextNumber(0, 1));
                UIStroke.Color = u9:NextInteger(1, 2) == 1 and Color3.new() or Color3.new(1, 1, 1);
                task.wait();
            end;

            u17.Recover({ "Text", "Gradient" });
        end,

        Selection = function() -- Line: 163, Name: Selection
            -- upvalues: Label (copy), RarityGradient (copy), u15 (copy), u9 (copy), u12 (copy), UIStroke (copy), u11 (copy)
            if not (Label and (Label:FindFirstChild("UIGradient") and RarityGradient)) then
                return;
            end;

            local v19 = u15[u9:NextInteger(1, #u15)];
            Label.UIGradient.Enabled = false;
            Label.TextStrokeTransparency = 0;
            Label.Text = string.upper(v19.Name);
            Label.Font = v19.Font;
            Label.TextColor3 = v19.Color;
            Label.TextStrokeColor3 = v19.StrokeColor;

            if RarityGradient then
                RarityGradient:SetAttribute("IsEnabled", false);
                RarityGradient.Rotation = u12;
                UIStroke.RarityGradient.Enabled = v19.Combined and true or false;
                UIStroke.RarityGradient.Color = v19.Combined and ColorSequence.new({ ColorSequenceKeypoint.new(0, v19.Color), ColorSequenceKeypoint.new(1, v19.StrokeColor) }) or u11;
            end;

            UIStroke.Color = v19.Combined and Color3.new(1, 1, 1) or v19.Color;
        end
    };
    u13:Connect(game:GetService("RunService").Heartbeat, function() -- Line: 185
        -- upvalues: RarityGradient (copy), UIStroke (copy), CreateRainbow (ref)
        if RarityGradient and RarityGradient:GetAttribute("IsEnabled") then
            UIStroke.Color = Color3.new(1, 1, 1);
            RarityGradient.Rotation = 45;
            RarityGradient.Color = CreateRainbow(16, tick());
        end;
    end);
    u13:Connect(u8.Parent:GetPropertyChangedSignal("Visible"), function() -- Line: 193
        -- upvalues: u8 (copy), u13 (copy)
        if not u8.Parent.Visible then
            u13:Destroy();
        end;
    end);

    repeat
        u17.Recover();
        task.wait(u9:NextNumber(0.2, 2.5));
        u17.Glitch();
        u17.Selection();
        task.wait(u9:NextNumber(0.1, 1.5));
        u17.Recover({ "Text" });
        u17.Glitch();
    until not (Label and (Label:FindFirstChild("UIGradient") and (UIStroke and (u8 and (RarityGradient and u8.Parent.Visible)))));

    u13:Destroy();
end;