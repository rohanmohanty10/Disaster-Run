 
 

return {
    Default = {
        Lighting = {
            Brightness = 5,
            EnvironmentDiffuseScale = 0.6,
            EnvironmentSpecularScale = 1,
            GlobalShadows = true,
            GeographicLatitude = 0,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(71, 80, 109),
            ColorShift_Bottom = Color3.fromRGB(107, 114, 255),
            ColorShift_Top = Color3.fromRGB(131, 137, 255),
            OutdoorAmbient = Color3.fromRGB(77, 62, 88)
        },
        Atmosphere = {
            Density = 0.3,
            Offset = 0.5,
            Glare = 1.43,
            Haze = 2.22,
            Color = Color3.fromRGB(75, 181, 119),
            Decay = Color3.fromRGB(134, 176, 156)
        },
        Bloom = {
            Intensity = 1,
            Size = 35,
            Threshold = 1.5
        },
        DepthOfField = {
            FarIntensity = 0.167,
            FocusDistance = 53.96,
            InFocusRadius = 50,
            NearIntensity = 0
        }
    }
};