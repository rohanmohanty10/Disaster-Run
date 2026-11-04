 
 

return {
    Default = {
        Lighting = {
            Brightness = 3,
            EnvironmentDiffuseScale = 0.75,
            EnvironmentSpecularScale = 0,
            GlobalShadows = true,
            GeographicLatitude = 0,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(91, 75, 52),
            ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
            ColorShift_Top = Color3.fromRGB(252, 255, 196),
            OutdoorAmbient = Color3.fromRGB(122, 95, 57)
        },
        Atmosphere = {
            Density = 0.3,
            Offset = 0.5,
            Glare = 0.4,
            Haze = 1.03,
            Color = Color3.fromRGB(236, 255, 205),
            Decay = Color3.fromRGB(89, 99, 82)
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