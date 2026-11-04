 

 

local v1 = {
    SHAPES = { "Sphere", "Cone", "Linear", "Vortex" },
    KINDS = { "Impulse", "Continuous" },
    CUTS = { "Off", "Halves", "Pieces", "Band" },
    FROM_PART = { "PosMode", "PosX", "PosY", "PosZ", "PosXEven", "PosYEven", "PosZEven", "PositionEvenCycle", "RotOrder", "RotX", "RotY", "RotZ", "RotXEven", "RotYEven", "RotZEven", "RotationEvenCycle", "PosXLinkedTo", "PosYLinkedTo", "PosZLinkedTo", "RotXLinkedTo", "RotYLinkedTo", "RotZLinkedTo", "SpreadAngle", "DirMode", "VelocityVectored", "Speed", "Acceleration", "Drag", "InvertMotion", "DisplacementMode", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "TurbulenceFrequency", "PosOffsetXLinkedTo", "PosOffsetYLinkedTo", "PosOffsetZLinkedTo", "RotMode", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "RotSpeedXLinkedTo", "RotSpeedYLinkedTo", "RotSpeedZLinkedTo", "AccelerationTowardsInstance", "AccelStrength" },
    ForceProperties = {
        Shape = {
            type = "string",
            default = "Sphere"
        },
        ActsAs = {
            type = "string",
            default = "Impulse"
        },
        Strength = {
            type = "NumberSequence",
            default = NumberSequence.new(12)
        },
        Falloff = {
            type = "number",
            default = 1,
            nonNegative = true
        },
        Range = {
            type = "number",
            default = 30,
            nonNegative = true
        },
        Inner = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        Width = {
            type = "number",
            default = 20,
            nonNegative = true
        },
        Height = {
            type = "number",
            default = 20,
            nonNegative = true
        },
        Angle = {
            type = "number",
            default = 60,
            nonNegative = true
        },
        EmissionDirection = {
            type = "enum",
            enumType = "NormalId",
            default = Enum.NormalId.Front
        },
        MoveDirection = {
            type = "enum",
            enumType = "NormalId",
            default = Enum.NormalId.Front
        },
        MotionTurbulence = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        TravelTime = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        Lift = {
            type = "number",
            default = 0.7
        },
        Spin = {
            type = "number",
            default = 1
        },
        Pull = {
            type = "number",
            default = 0.5
        },
        Variation = {
            type = "number",
            default = 0.2,
            nonNegative = true
        },
        Turbulence = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        SizeResponse = {
            type = "number",
            default = 0.5,
            nonNegative = true
        },
        Group = {
            type = "string",
            default = ""
        },
        After = {
            type = "string",
            default = "Reactor\'s"
        },
        AfterDelay = {
            type = "number",
            default = 2,
            nonNegative = true
        },
        Pieces = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        Cut = {
            type = "string",
            default = "Off"
        },
        PushAlong = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        PushApart = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        CutNoise = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        CutNoiseScale = {
            type = "number",
            default = 4,
            nonNegative = true
        },
        Lifetime = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(1)
        },
        Timescale = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        Rate = {
            type = "number",
            default = 2
        },
        Enabled = {
            type = "boolean",
            default = false
        }
    }
};
v1.Types = {
    Force = {
        pDataType = "Force",
        uiSection = "Forces",

        classCheck = function(p2) -- Line: 123, Name: classCheck
            local v3 = p2:IsA("BasePart") or p2:IsA("Attachment");

            if v3 then
                if p2:GetAttribute("IsForce") == true then
                    v3 = p2:FindFirstChild("PartIcleProperties") ~= nil;
                else
                    v3 = false;
                end;
            end;

            return v3;
        end,

        properties = v1.ForceProperties,
        resize = {
            scaleGraphs = { "Strength", "Speed", "AccelStrength", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "MotionTurbulence" },
            scaleNumbers = { "Range", "Inner", "Width", "Height", "PushAlong", "PushApart", "CutNoise", "CutNoiseScale" },
            scaleVectors = { "Acceleration" },
            scaleRanges = { "PosX", "PosY", "PosZ" }
        },
        retime = {
            multiplyNumbers = { "Rate", "Drag", "TurbulenceFrequency" },
            divideNumbers = { "TravelTime", "AfterDelay" },
            divideRanges = { "Lifetime" },
            multiplyGraphs = { "Speed" },
            rotSpeedGraphs = { "RotSpeedX", "RotSpeedY", "RotSpeedZ" },
            squareVectors = { "Acceleration" },
            squareGraphs = { "AccelStrength" }
        },
        clipboard = {
            {
                name = "Emission",
                props = { "Rate", "Lifetime", "Timescale", "EmitCount", "EmitDelay", "EmitDuration" }
            },
            {
                name = "Spawn",
                props = { "PosMode", "PosX", "PosY", "PosZ", "PosXEven", "PosYEven", "PosZEven", "PositionEvenCycle", "RotOrder", "RotX", "RotY", "RotZ", "RotXEven", "RotYEven", "RotZEven", "RotationEvenCycle" }
            },
            {
                name = "Motion",
                props = { "MoveDirection", "SpreadAngle", "DirMode", "Speed", "Acceleration", "Drag", "InvertMotion", "DisplacementMode", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "MotionTurbulence", "TurbulenceFrequency", "RotMode", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "AccelerationTowardsInstance", "AccelStrength" }
            },
            {
                name = "Shape",
                props = { "Shape", "Range", "Inner", "Width", "Height", "Angle", "EmissionDirection" }
            },
            {
                name = "Strength",
                props = { "ActsAs", "Strength", "Falloff", "TravelTime", "Lift", "Spin", "Pull" }
            },
            {
                name = "Variation",
                props = { "Variation", "Turbulence", "SizeResponse", "Group" }
            },
            {
                name = "Ground",
                props = { "After", "AfterDelay", "Pieces" }
            },
            {
                name = "Cut",
                props = { "Cut", "PushAlong", "PushApart", "CutNoise", "CutNoiseScale" }
            }
        }
    }
};

return v1;