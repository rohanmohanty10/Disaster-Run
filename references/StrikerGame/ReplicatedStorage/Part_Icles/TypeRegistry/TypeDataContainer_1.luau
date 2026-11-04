 
 

local v1 = {
    MODES = { "Absolute", "Relative", "Relative Lifetime", "Relative Span" },
    COLOR_MODES = { "Recolor", "Colorize", "Shift", "Tint" },
    APPLY_KINDS = { "Emitter", "Mesh", "Beam", "Trail", "Reactor" },
    SKIP_ROWS = {
        DriveRate = { "DriveRate" },
        DriveScale = { "DriveScale" },
        DriveTimescale = { "DriveTimescale" },
        DriveBrightness = { "DriveBrightness" },
        DriveSpread = { "DriveSpreadX", "DriveSpreadY" },
        DriveLightInfluence = { "DriveLightInfluence" },
        DriveLightEmission = { "DriveLightEmission" },
        DriveColor = { "DriveColor" }
    },
    DRIVE_GRAPHS = {
        DriveRate = "multiply",
        DriveScale = "multiply",
        DriveTimescale = "multiply",
        DriveBrightness = "multiply",
        DriveSpreadX = "add",
        DriveSpreadY = "add",
        DriveLightInfluence = "add",
        DriveLightEmission = "add"
    },
    ContainerProperties = {
        Mode = {
            type = "string",
            default = "Absolute"
        },
        Lifetime = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 2
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        DriveRate = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        DriveScale = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        DriveTimescale = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        DriveBrightness = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        DriveSpreadX = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        DriveSpreadY = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        DriveLightInfluence = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        DriveLightEmission = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        DriveColor = {
            type = "ColorSequence",
            default = ColorSequence.new(Color3.new(1, 1, 1))
        },
        ColorMode = {
            type = "string",
            default = "Recolor"
        }
    }
};
v1.Types = {
    Container = {
        pDataType = "Container",
        uiSection = "Containers",

        classCheck = function(p2) -- Line: 76, Name: classCheck
            local v3 = p2:IsA("BasePart") or p2:IsA("Attachment");

            if v3 then
                if p2:GetAttribute("IsContainer") == true then
                    v3 = p2:FindFirstChild("PartIcleProperties") ~= nil;
                else
                    v3 = false;
                end;
            end;

            return v3;
        end,

        properties = v1.ContainerProperties,
        resize = {},
        retime = {
            multiplyNumbers = { "Rate" },
            divideRanges = { "Lifetime" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Rate", "Lifetime", "Mode", "EmitCount", "EmitDelay" }
            }, {
                name = "Drive",
                props = { "DriveRate", "DriveScale", "DriveTimescale", "DriveBrightness", "DriveSpreadX", "DriveSpreadY", "DriveLightInfluence", "DriveLightEmission", "DriveColor", "ColorMode" }
            } }
    }
};

return v1;