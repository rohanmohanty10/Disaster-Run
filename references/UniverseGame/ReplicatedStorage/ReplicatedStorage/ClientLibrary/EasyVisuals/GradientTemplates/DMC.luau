  

 

return function() -- Line: 1
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0, 1, 1)),
        ColorSequenceKeypoint.new(0.1510416716337204, Color3.new(0, 0.666667, 1)),
        ColorSequenceKeypoint.new(0.3072916567325592, Color3.new(0.666667, 0, 0)),
        ColorSequenceKeypoint.new(0.4965277910232544, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.6649305820465088, Color3.new(0.666667, 0, 0)),
        ColorSequenceKeypoint.new(0.8385416865348816, Color3.new(0, 0.666667, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 1, 1))
    });

    return UIGradient;
end;