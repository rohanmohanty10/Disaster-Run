  

 

game:GetService("RunService").RenderStepped:Connect(function() -- Line: 4
    script.Parent.Value = script.Parent.Value + 1;

    if script.Parent.Value > 100 then
        script.Parent.Value = 0;
    end;

    local v1 = math.clamp(script.Parent.Value * 3.6, 0, 360);
    local ImageLabel = script.Parent.Parent.Frame1.ImageLabel;
    local ImageLabel2 = script.Parent.Parent.Frame2.ImageLabel;
    ImageLabel.UIGradient.Rotation = script.FlipProgress.Value == false and math.clamp(v1, 180, 360) or 180 - math.clamp(v1, 0, 180);
    ImageLabel2.UIGradient.Rotation = script.FlipProgress.Value == false and math.clamp(v1, 0, 180) or 180 - math.clamp(v1, 180, 360);
    ImageLabel.ImageColor3 = script.ImageColor.Value;
    ImageLabel2.ImageColor3 = script.ImageColor.Value;
    ImageLabel.ImageTransparency = script.ImageTrans.Value;
    ImageLabel2.ImageTransparency = script.ImageTrans.Value;
    ImageLabel.Image = "rbxassetid://" .. script.ImageId.Value;
    ImageLabel2.Image = "rbxassetid://" .. script.ImageId.Value;

    if script.MissingPartType.Value == "Color" then
        ImageLabel.UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
            ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
        });
        ImageLabel2.UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
            ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
        });
        ImageLabel.UIGradient.Transparency = NumberSequence.new(0);
        ImageLabel2.UIGradient.Transparency = NumberSequence.new(0);

        return;
    end;

    if script.MissingPartType.Value == "Trans" then
        ImageLabel.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
            NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
        });
        ImageLabel2.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
            NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
        });
        ImageLabel.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1));
        ImageLabel2.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1));

        return;
    end;

    if script.MissingPartType.Value ~= "TransAndColor" then
        script.MissingPartType.Value = "Trans";
        error("Unknown Type. Only 3 available: “Trans”, “Color” and “TransAndColor”, changing to “Trans”.");

        return;
    end;

    ImageLabel.UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
        NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
        NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
        NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
    });
    ImageLabel2.UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
        NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
        NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
        NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
    });
    ImageLabel.UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
        ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
        ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
        ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
    });
    ImageLabel2.UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
        ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
        ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
        ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
    });
end);