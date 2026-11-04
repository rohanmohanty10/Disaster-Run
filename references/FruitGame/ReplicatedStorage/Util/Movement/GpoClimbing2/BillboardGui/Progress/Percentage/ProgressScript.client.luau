 

game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 4 ]]
    if script.Parent.Value > 100 then
        script.Parent.Value = 0
    end
    local v1 = script.Parent.Value * 3.6
    local v2 = math.clamp(v1, 0, 360)
    script.ImageColor.Value = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(85, 255, 127), script.Parent.Value / 100)
    print(script.ImageColor.Value)
    local v3 = script.Parent.Parent.Frame1.ImageLabel
    local v4 = script.Parent.Parent.Frame2.ImageLabel
    v3.UIGradient.Rotation = script.FlipProgress.Value == false and math.clamp(v2, 180, 360) or 180 - math.clamp(v2, 0, 180)
    v4.UIGradient.Rotation = script.FlipProgress.Value == false and math.clamp(v2, 0, 180) or 180 - math.clamp(v2, 180, 360)
    v3.ImageColor3 = script.ImageColor.Value
    v4.ImageColor3 = script.ImageColor.Value
    v3.ImageTransparency = script.ImageTrans.Value
    v4.ImageTransparency = script.ImageTrans.Value
    v3.Image = "rbxassetid://" .. script.ImageId.Value
    v4.Image = "rbxassetid://" .. script.ImageId.Value
    if script.MissingPartType.Value == "Color" then
        v3.UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
            ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
        })
        v4.UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
            ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
        })
        v3.UIGradient.Transparency = NumberSequence.new(0)
        v4.UIGradient.Transparency = NumberSequence.new(0)
        return
    elseif script.MissingPartType.Value == "Trans" then
        v3.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
            NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
        })
        v4.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
            NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
        })
        v3.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
        v4.UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1))
        return
    elseif script.MissingPartType.Value == "TransAndColor" then
        v3.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
            NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
        })
        v4.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.5, script.TransOfPercentPart.Value),
            NumberSequenceKeypoint.new(0.501, script.TransOfMissingPart.Value),
            NumberSequenceKeypoint.new(1, script.TransOfMissingPart.Value)
        })
        v3.UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
            ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
        })
        v4.UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.5, script.ColorOfPercentPart.Value),
            ColorSequenceKeypoint.new(0.501, script.ColorOfMissingPart.Value),
            ColorSequenceKeypoint.new(1, script.ColorOfMissingPart.Value)
        })
    else
        script.MissingPartType.Value = "Trans"
        error("Unknown Type. Only 3 available: \226\128\156Trans\226\128\157, \226\128\156Color\226\128\157 and \226\128\156TransAndColor\226\128\157, changing to \226\128\156Trans\226\128\157.")
    end
end)