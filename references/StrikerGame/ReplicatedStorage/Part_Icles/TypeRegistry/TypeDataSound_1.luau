 
 

local v1 = {
    SoundProperties = {
        Volume = {
            type = "NumberSequence",
            attrName = "SndVolume",
            default = NumberSequence.new(0.5)
        },
        PlaybackSpeed = {
            type = "NumberSequence",
            attrName = "SndPlaybackSpeed",
            default = NumberSequence.new(1)
        },
        Timescale = {
            type = "NumberSequence",
            attrName = "SndTimescale",
            default = NumberSequence.new(1)
        },
        Lifetime = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(0)
        },
        Rate = {
            type = "number",
            default = 10
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        RollOffMin = {
            type = "number",
            default = 10,
            nonNegative = true
        },
        RollOffMax = {
            type = "number",
            default = 10000,
            nonNegative = true
        },
        Looped = {
            type = "boolean",
            default = false
        },
        StartOffset = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        Local2D = {
            type = "boolean",
            default = false
        }
    }
};
v1.Types = {
    Sound = {
        pDataType = "Sound",
        uiSection = "Sounds",

        classCheck = function(p2) -- Line: 34, Name: classCheck
            return p2:IsA("Sound");
        end,

        properties = v1.SoundProperties,
        resize = {
            scaleNumbers = { "RollOffMin", "RollOffMax" }
        },
        retime = {
            multiplyNumbers = { "Rate" },
            divideRanges = { "Lifetime" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Rate", "Lifetime", "StartOffset", "Looped", "Local2D", "Timescale", "EmitCount", "EmitDelay", "EmitDuration" }
            }, {
                name = "Sound",
                props = { "Volume", "PlaybackSpeed", "RollOffMin", "RollOffMax" }
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