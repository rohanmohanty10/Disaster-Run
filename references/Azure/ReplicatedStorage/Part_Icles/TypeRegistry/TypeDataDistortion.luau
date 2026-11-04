 

 

local v1 = {
    DistortionProperties = {
        FieldKind = {
            type = "string",
            default = "Ripple"
        },
        Amplitude = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(0.5)
        },
        Wavelength = {
            type = "number",
            default = 1.5,
            nonNegative = true
        },
        Speed = {
            type = "number",
            default = 3
        },
        Direction = {
            type = "number",
            default = 0
        },
        NoiseScale = {
            type = "number",
            default = 2,
            nonNegative = true
        },
        LensRadius = {
            type = "number",
            default = 1.5,
            nonNegative = true
        },
        EpicenterMode = {
            type = "string",
            default = "WorldPoint"
        },
        Falloff = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        Transparency = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(0.3, 1)
        },
        Strength = {
            type = "number",
            default = 1,
            nonNegative = true
        },
        Amplify = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        AllowOverdrive = {
            type = "boolean",
            default = false
        },
        Resolution = {
            type = "number",
            default = 24,
            nonNegative = true
        },
        Timescale = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        Lifetime = {
            type = "NumberRange",
            default = NumberRange.new(0.5)
        },
        Rate = {
            type = "number",
            default = 10
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        }
    }
};
v1.Types = {
    Distortion = {
        pDataType = "Distortion",
        uiSection = "Distortions",

        classCheck = function(p2) -- Line: 69, Name: classCheck
            local v3 = p2:IsA("BasePart");

            if v3 then
                if p2:GetAttribute("IsDistortion") == true then
                    v3 = p2:FindFirstChild("PartIcleProperties") ~= nil;
                else
                    v3 = false;
                end;
            end;

            return v3;
        end,

        properties = v1.DistortionProperties,
        resize = {
            scaleNumbers = { "Falloff" }
        },
        retime = {
            multiplyNumbers = { "Rate", "Speed" },
            divideRanges = { "Lifetime" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Rate", "Lifetime", "Timescale", "EmitCount", "EmitDelay", "EmitDuration" }
            }, {
                name = "Field",
                props = { "FieldKind", "Amplitude", "Wavelength", "Speed", "Direction", "NoiseScale", "LensRadius" }
            }, {
                name = "Screen",
                props = { "EpicenterMode", "Falloff", "Strength", "Transparency", "Amplify", "AllowOverdrive", "Resolution" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames" }
            }, {
                name = "Events",
                props = { "OnEmit", "OnDeath", "OnDestruction" }
            } }
    }
};

return v1;