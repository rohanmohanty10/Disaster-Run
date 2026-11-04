 
 

return {
    Default = {
        Lighting = {
            Brightness = 3,
            EnvironmentDiffuseScale = 0.75,
            EnvironmentSpecularScale = 0,
            GlobalShadows = true,
            GeographicLatitude = 53.779,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(91, 75, 52),
            ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
            ColorShift_Top = Color3.fromRGB(252, 255, 196),
            OutdoorAmbient = Color3.fromRGB(122, 95, 57)
        },
        Atmosphere = {
            Density = 0.286,
            Offset = 0.25,
            Glare = 0.32,
            Haze = 2.01,
            Color = Color3.fromRGB(236, 255, 205),
            Decay = Color3.fromRGB(89, 99, 82)
        },
        Bloom = {
            Intensity = 1,
            Size = 24,
            Threshold = 2
        },
        ColorCorrection = {
            Brightness = 0.05,
            Contrast = 0.1,
            Saturation = 0.4,
            TintColor = Color3.fromRGB(255, 255, 255)
        },
        DepthOfField = {
            FarIntensity = 0.1,
            FocusDistance = 0.05,
            InFocusRadius = 30,
            NearIntensity = 0.75
        }
    }
};