 
 

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
            OutdoorAmbient = Color3.fromRGB(206, 160, 96)
        },
        Atmosphere = {
            Density = 0.192,
            Offset = 0.093,
            Glare = 0.58,
            Haze = 1.98,
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