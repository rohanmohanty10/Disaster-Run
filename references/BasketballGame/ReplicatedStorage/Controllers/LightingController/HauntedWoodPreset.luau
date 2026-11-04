 
 

return {
    Default = {
        Lighting = {
            Brightness = 2,
            EnvironmentDiffuseScale = 0.471,
            EnvironmentSpecularScale = 0.324,
            GlobalShadows = true,
            GeographicLatitude = 206,
            ExposureCompensation = -0.1,
            Ambient = Color3.fromRGB(90, 90, 90),
            ColorShift_Bottom = Color3.fromRGB(255, 255, 255),
            ColorShift_Top = Color3.fromRGB(184, 184, 184),
            OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        },
        Atmosphere = {
            Density = 0.45,
            Offset = 0,
            Glare = 0,
            Haze = 2.5,
            Color = Color3.fromRGB(43, 101, 167),
            Decay = Color3.fromRGB(0, 0, 0)
        },
        Bloom = {
            Intensity = 0.25,
            Size = 24,
            Threshold = 2
        },
        DepthOfField = {
            FarIntensity = 0.21,
            FocusDistance = 90,
            InFocusRadius = 0,
            NearIntensity = 0
        }
    }
};