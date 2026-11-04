 
 

return {
    Default = {
        Lighting = {
            Brightness = 3,
            EnvironmentDiffuseScale = 0.279,
            EnvironmentSpecularScale = 0.618,
            GlobalShadows = true,
            GeographicLatitude = 180,
            ExposureCompensation = 0.3,
            Ambient = Color3.fromRGB(180, 14, 14),
            ColorShift_Bottom = Color3.fromRGB(198, 62, 52),
            ColorShift_Top = Color3.fromRGB(255, 179, 85),
            OutdoorAmbient = Color3.fromRGB(195, 127, 100)
        },
        Atmosphere = {
            Density = 0.266,
            Offset = 0.662,
            Glare = 0,
            Haze = 0,
            Color = Color3.fromRGB(199, 199, 199),
            Decay = Color3.fromRGB(188, 73, 38)
        },
        Bloom = {
            Intensity = 0.25,
            Size = 24,
            Threshold = 2
        },
        ColorCorrection = {
            Brightness = 0.03,
            Contrast = 0.3,
            Saturation = 0.2,
            TintColor = Color3.fromRGB(255, 255, 255)
        },
        DepthOfField = {
            FarIntensity = 0.21,
            FocusDistance = 90,
            InFocusRadius = 0,
            NearIntensity = 0
        }
    }
};