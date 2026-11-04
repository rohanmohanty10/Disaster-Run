  

local u1 = {};
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Debris = game:GetService("Debris");

function u1.TweenSize(p2, p3, p4, p5) -- Line: 7
    -- upvalues: TweenService (copy), u1 (copy), Debris (copy)
    for _, v in pairs(p4) do
        local v6 = TweenService:Create(v, u1.Basic(p2, p3), {
            Size = p5
        });
        v6:Play();
        Debris:AddItem(v6, p2);
    end;
end;

function u1.Popup(p7) -- Line: 15
    -- upvalues: u1 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Text = p7.Name;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextStrokeTransparency = 1;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextScaled = true;
    TextLabel.Parent = p7;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Size = UDim2.new(0.6, 0, 0.35, 0);
    TextLabel.TextTransparency = 1;
    TextLabel.ZIndex = -3;
    TextLabel.Font = Enum.Font.FredokaOne;
    TextLabel.FontFace.Weight = Enum.FontWeight.Bold;
    TextLabel.Position = p7.Position - UDim2.new(0, 0, 0.2, 0);
    u1.TweenTransparency(0.15, "Sine", { TextLabel }, 0);
    u1.TweenPosition(0.25, "Exponential", { TextLabel }, UDim2.new(0.5, 0, TextLabel.Position.Y.Scale - 0.6, 0));
    task.delay(0.35, function() -- Line: 32
        -- upvalues: u1 (ref), TextLabel (copy)
        u1.TweenTransparency(0.35, "Sine", { TextLabel }, 1);
    end);
    task.delay(0.8, function() -- Line: 35
        -- upvalues: TextLabel (copy)
        TextLabel:Destroy();
    end);
end;

function u1.TweenTransparency(p8, p9, p10, p11) -- Line: 40
    -- upvalues: TweenService (copy), u1 (copy), Debris (copy)
    for _, v in pairs(p10) do
        if v:IsA("Frame") or (v:IsA("ImageLabel") or v:IsA("CanvasGroup")) then
            local v12 = TweenService:Create(v, u1.Basic(p8, p9), {
                BackgroundTransparency = p11
            });
            v12:Play();
            Debris:AddItem(v12, p8);
        else
            local v13 = TweenService:Create(v, u1.Basic(p8, p9), {
                TextTransparency = p11,
                TextStrokeTransparency = p11
            });
            v13:Play();
            Debris:AddItem(v13, p8);
        end;
    end;
end;

function u1.TweenCFrame(p14, p15, p16, p17) -- Line: 54
    -- upvalues: TweenService (copy), u1 (copy), Debris (copy)
    for _, v in pairs(p16) do
        local v18 = TweenService:Create(v, u1.Basic(p14, p15), {
            CFrame = p17
        });
        v18:Play();
        Debris:AddItem(v18, p14);
    end;
end;

function u1.TweenPosition(p19, p20, p21, p22) -- Line: 62
    -- upvalues: TweenService (copy), u1 (copy), Debris (copy)
    for _, v in pairs(p21) do
        local v23 = TweenService:Create(v, u1.Basic(p19, p20), {
            Position = p22
        });
        v23:Play();
        Debris:AddItem(v23, p19);
    end;
end;

function u1.Basic(p24, p25) -- Line: 70
    return TweenInfo.new(p24, Enum.EasingStyle[p25], Enum.EasingDirection.Out);
end;

return u1;