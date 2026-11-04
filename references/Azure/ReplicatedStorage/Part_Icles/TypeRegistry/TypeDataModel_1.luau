 
 

local v1 = {
    ModelProperties = {
        Speed = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        PosOffsetX = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        PosOffsetY = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        PosOffsetZ = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Turbulence = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        TurbulenceFrequency = {
            type = "number",
            default = 1
        },
        RotSpeedX = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedY = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedZ = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Scale = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Timescale = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        Lifetime = {
            type = "NumberRange",
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 10
        },
        Drag = {
            type = "number",
            default = 0
        },
        Acceleration = {
            type = "Vector3",
            default = Vector3.new(0, 0, 0)
        },
        SpreadAngle = {
            type = "Vector2",
            default = Vector2.new(0, 0)
        },
        RotX = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotY = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotZ = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        PosX = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        PosY = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        PosZ = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        PosMode = {
            type = "string",
            default = "Local"
        },
        RotMode = {
            type = "string",
            default = "OverLife"
        },
        RotOrder = {
            type = "string",
            default = "Global"
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        PartLife = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        VelocityVectored = {
            type = "boolean",
            default = false
        },
        DirMode = {
            type = "string",
            default = "RigidLocal"
        },
        DisplacementMode = {
            type = "string",
            default = "Global"
        },
        InvertMotion = {
            type = "boolean",
            default = false
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        ScaleTextureLength = {
            type = "boolean",
            default = true
        },
        ScaleMotion = {
            type = "boolean",
            default = true
        },
        ScaleRotation = {
            type = "boolean",
            default = false
        },
        EmissionDirection = {
            type = "enum",
            enumType = "NormalId",
            default = Enum.NormalId.Top
        },
        Orientation = {
            type = "string",
            default = "None"
        },
        ZOffset = {
            type = "number",
            default = 0
        },
        RotSpeedXLinkedTo = {
            type = "string",
            default = ""
        },
        RotSpeedYLinkedTo = {
            type = "string",
            default = ""
        },
        RotSpeedZLinkedTo = {
            type = "string",
            default = ""
        },
        PosOffsetXLinkedTo = {
            type = "string",
            default = ""
        },
        PosOffsetYLinkedTo = {
            type = "string",
            default = ""
        },
        PosOffsetZLinkedTo = {
            type = "string",
            default = ""
        },
        RotXLinkedTo = {
            type = "string",
            default = ""
        },
        RotYLinkedTo = {
            type = "string",
            default = ""
        },
        RotZLinkedTo = {
            type = "string",
            default = ""
        },
        PosXLinkedTo = {
            type = "string",
            default = ""
        },
        PosYLinkedTo = {
            type = "string",
            default = ""
        },
        PosZLinkedTo = {
            type = "string",
            default = ""
        },
        RotXEven = {
            type = "boolean",
            default = false
        },
        RotYEven = {
            type = "boolean",
            default = false
        },
        RotZEven = {
            type = "boolean",
            default = false
        },
        PosXEven = {
            type = "boolean",
            default = false
        },
        PosYEven = {
            type = "boolean",
            default = false
        },
        PosZEven = {
            type = "boolean",
            default = false
        },
        PositionEvenCycle = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotationEvenCycle = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        Pool = {
            type = "boolean",
            default = false
        }
    }
};
v1.Types = {
    Model = {
        pDataType = "Model",
        uiSection = "Models",

        classCheck = function(p2) -- Line: 100, Name: classCheck
            local v3 = p2:IsA("Model") and not p2:GetAttribute("IsReactor");

            return v3;
        end,

        properties = v1.ModelProperties,
        resize = {
            scaleGraphs = { "Speed", "Scale", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "Turbulence" },
            scaleVectors = { "Acceleration" },
            scaleRanges = { "PosX", "PosY", "PosZ" }
        },
        retime = {
            multiplyNumbers = { "Rate", "Drag", "TurbulenceFrequency" },
            divideRanges = { "Lifetime" },
            multiplyGraphs = { "Speed" },
            rotSpeedGraphs = { "RotSpeedX", "RotSpeedY", "RotSpeedZ" },
            squareVectors = { "Acceleration" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Rate", "Lifetime", "PartLife", "Timescale", "EmitCount", "EmitDelay", "EmitDuration" }
            }, {
                name = "Spawn",
                props = { "Orientation", "PosMode", "PosX", "PosY", "PosZ", "PosXEven", "PosYEven", "PosZEven", "PositionEvenCycle", "RotOrder", "RotX", "RotY", "RotZ", "RotXEven", "RotYEven", "RotZEven", "RotationEvenCycle", "ZOffset" }
            }, {
                name = "Motion",
                props = { "EmissionDirection", "SpreadAngle", "DirMode", "Speed", "Acceleration", "Drag", "InvertMotion", "DisplacementMode", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "Turbulence", "TurbulenceFrequency", "RotMode", "RotSpeedX", "RotSpeedY", "RotSpeedZ" }
            }, {
                name = "Scale",
                props = { "Scale", "ScaleTextureLength", "ScaleMotion", "ScaleRotation" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames", "Pool" }
            }, {
                name = "Events",
                props = { "OnEmit", "OnDeath", "OnDestruction", "OnHit" }
            } }
    }
};

return v1;