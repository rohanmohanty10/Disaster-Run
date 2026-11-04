 
 

return {
    Default = {
        Lighting = {
            Brightness = 3,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 0,
            GlobalShadows = true,
            GeographicLatitude = 0,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(138, 153, 172),
            ColorShift_Bottom = Color3.fromRGB(91, 129, 162),
            ColorShift_Top = Color3.fromRGB(103, 110, 150),
            OutdoorAmbient = Color3.fromRGB(80, 101, 140)
        },
        Atmosphere = {
            Density = 0.3,
            Offset = 0.5,
            Glare = 0,
            Haze = 2.04,
            Color = Color3.fromRGB(202, 255, 251),
            Decay = Color3.fromRGB(85, 99, 98)
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