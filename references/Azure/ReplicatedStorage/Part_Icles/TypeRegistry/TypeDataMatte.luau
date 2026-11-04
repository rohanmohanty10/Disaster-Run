 

 

local v1 = {
    BACK_FACES = { "Auto", "Off", "X", "Y", "Z" },
    VIEW_MODES = { "Tilted", "Semi Tilt", "Middle", "Front", "On Top" },
    FLIPBOOK_MODES = { "None", "OneShot", "Loop", "PingPong" },
    MatteProperties = {
        Lifetime = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(2)
        },
        Rate = {
            type = "number",
            default = 1
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        Texture = {
            type = "string",
            default = ""
        },
        TextureScale = {
            type = "number",
            default = 1,
            nonNegative = true
        },
        BackFaces = {
            type = "string",
            default = "Auto"
        },
        ViewMode = {
            type = "string",
            default = "Tilted"
        },
        Pool = {
            type = "boolean",
            default = true,
            optional = true
        },
        FlipbookMode = {
            type = "string",
            default = "OneShot"
        },
        FlipbookTime = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(0, 1)
        },
        FlipbookFramerate = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(30)
        },
        FlipbookStartRandom = {
            type = "boolean",
            default = false
        },
        FlipbookReverse = {
            type = "boolean",
            default = false
        },
        MaskTexture = {
            type = "string",
            default = ""
        },
        MaskScale = {
            type = "number",
            default = 1,
            nonNegative = true
        },
        MaskEdgeColor = {
            type = "ColorSequence",
            default = ColorSequence.new(Color3.new(1, 1, 1))
        },
        MaskEdgeBrightness = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        MaskFlipbookMode = {
            type = "string",
            default = "OneShot"
        },
        MaskFlipbookTime = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(0, 1)
        },
        MaskFlipbookFramerate = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(30)
        },
        MaskFlipbookStartRandom = {
            type = "boolean",
            default = false
        },
        MaskFlipbookReverse = {
            type = "boolean",
            default = false
        },
        PictureActive = {
            type = "boolean",
            default = true
        },
        MaskActive = {
            type = "boolean",
            default = false
        },
        Brightness = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Transparency = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(0)
        },
        Color = {
            type = "ColorSequence",
            default = ColorSequence.new(Color3.new(1, 1, 1))
        }
    }
};
v1.Types = {
    Matte = {
        pDataType = "Matte",
        uiSection = "Mattes",

        classCheck = function(p2) -- Line: 81, Name: classCheck
            local v3 = p2:IsA("BasePart");

            if v3 then
                if p2:GetAttribute("IsMatte") == true then
                    v3 = p2:FindFirstChild("PartIcleProperties") ~= nil;
                else
                    v3 = false;
                end;
            end;

            return v3;
        end,

        properties = v1.MatteProperties,
        resize = {},
        retime = {
            multiplyNumbers = { "Rate" },
            divideRanges = { "Lifetime" },
            multiplyRanges = { "FlipbookFramerate", "MaskFlipbookFramerate" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Rate", "Lifetime", "EmitCount", "EmitDelay" }
            }, {
                name = "Look",
                props = { "Texture", "TextureScale", "BackFaces", "ViewMode", "Brightness", "Transparency", "Color" }
            }, {
                name = "Flipbook",
                props = { "FlipbookMode", "FlipbookTime", "FlipbookFramerate", "FlipbookStartRandom", "FlipbookReverse" }
            }, {
                name = "Mask",
                props = { "MaskTexture", "MaskScale", "MaskEdgeColor", "MaskEdgeBrightness", "MaskFlipbookMode", "MaskFlipbookTime", "MaskFlipbookFramerate", "MaskFlipbookStartRandom", "MaskFlipbookReverse" }
            }, {
                name = "Advanced",
                props = { "Pool" }
            } }
    }
};

return v1;