  

 

local function CreateRainbowSequence(p1, p2, p3, p4) -- Line: 1
    local v5 = {};

    for i = 1, p1 do
        local v6 = (i - 1) / (p1 - 1);
        table.insert(v5, ColorSequenceKeypoint.new(v6, Color3.fromHSV((v6 - p2) % 1, p3 or 1, p4 or 1)));
    end;

    return ColorSequence.new(v5);
end;

return function(p7) -- Line: 11
    -- upvalues: CreateRainbowSequence (copy)
    local Parent = script.Parent;
    local u8 = require(p7.Knit.Util.Trove).new();
    local u9 = nil;

    local function CharacterAdded(u10) -- Line: 16
        -- upvalues: u8 (copy), Parent (copy), u9 (ref), CreateRainbowSequence (ref)
        u8:Clean();

        local function Update() -- Line: 19
            -- upvalues: u10 (copy), Parent (ref), u9 (ref), u8 (ref), CreateRainbowSequence (ref)
            Parent.Visible = u10:GetAttribute("CanGoHyper") == true;

            if Parent.Visible then
                u9 = u8:Connect(game:GetService("RunService").Heartbeat, function() -- Line: 24
                    -- upvalues: Parent (ref), CreateRainbowSequence (ref)
                    Parent.IndicatorText.UIStroke.UIGradient.Color = CreateRainbowSequence(8, tick() * 1.25);
                end);

                return;
            end;

            if u9 then
                u8:Remove(u9);
                u9 = nil;
            end;
        end;

        u8:Add(u10:GetAttributeChangedSignal("CanGoHyper"):Connect(Update));
        Update();
    end;

    if p7.Character then
        CharacterAdded(p7.Character);
    end;

    p7.Player.CharacterAdded:Connect(CharacterAdded);
end;