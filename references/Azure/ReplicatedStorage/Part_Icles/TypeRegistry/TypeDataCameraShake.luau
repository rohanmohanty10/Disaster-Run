 

 

local v1 = {
    CameraShakeProperties = {
        ShakeAmplitude = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        ShakeRotAmplitude = {
            type = "NumberSequence",
            default = NumberSequence.new(0.6)
        },
        Timescale = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        ShakeFrequency = {
            type = "NumberSequence",
            default = NumberSequence.new(10)
        },
        ShakeFalloff = {
            type = "number",
            default = 0,
            nonNegative = true
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
    CameraShake = {
        pDataType = "CameraShake",
        uiSection = "Camera Shakes",

        classCheck = function(p2) -- Line: 36, Name: classCheck
            local v3 = p2:IsA("BasePart");

            if v3 then
                if p2:GetAttribute("IsCameraShake") == true then
                    v3 = p2:FindFirstChild("PartIcleProperties") ~= nil;
                else
                    v3 = false;
                end;
            end;

            return v3;
        end,

        properties = v1.CameraShakeProperties,
        resize = {
            scaleGraphs = { "ShakeAmplitude" },
            scaleNumbers = { "ShakeFalloff" }
        },
        retime = {
            multiplyNumbers = { "Rate" },
            multiplyGraphs = { "ShakeFrequency" },
            divideRanges = { "Lifetime" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Rate", "Lifetime", "Timescale", "EmitCount", "EmitDelay", "EmitDuration" }
            }, {
                name = "Shake",
                props = { "ShakeAmplitude", "ShakeRotAmplitude", "ShakeFrequency", "ShakeFalloff" }
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