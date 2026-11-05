  

 

return {
    Lighting = {
        Brightness = 2.5,
        EnvironmentDiffuseScale = 0,
        EnvironmentSpecularScale = 0,
        GlobalShadows = true,
        ShadowSoftness = 0.05,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        FogStart = 0,
        FogEnd = 100000,
        Ambient = Color3.fromRGB(0, 0, 0),
        ColorShift_Bottom = Color3.fromRGB(162, 175, 191),
        ColorShift_Top = Color3.fromRGB(255, 255, 250),
        OutdoorAmbient = Color3.fromRGB(162, 175, 191),
        FogColor = Color3.fromRGB(0, 0, 0)
    },
    Objects = {
        {
            Name = "No Thoughts",
            ClassName = "Sky",
            CelestialBodiesShown = true,
            MoonTextureId = "rbxasset://sky/moon.jpg",
            SkyboxBk = "http://www.roblox.com/asset/?id=98202165",
            SkyboxDn = "http://www.roblox.com/asset/?id=98202176",
            SkyboxFt = "http://www.roblox.com/asset/?id=98202152",
            SkyboxLf = "http://www.roblox.com/asset/?id=98202161",
            SkyboxRt = "http://www.roblox.com/asset/?id=98202146",
            SkyboxUp = "http://www.roblox.com/asset/?id=98202169",
            StarCount = 3000,
            SunAngularSize = 15,
            SunTextureId = "rbxasset://sky/sun.jpg"
        },
        {
            Name = "ColorCorrection",
            ClassName = "ColorCorrectionEffect",
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            Enabled = true,
            TintColor = Color3.fromRGB(275, 275, 275)
        },
        {
            Name = "Bloom",
            ClassName = "BloomEffect",
            Intensity = 0.6,
            Size = 50,
            Threshold = 1,
            Enabled = true
        },
        {
            Name = "SunRays",
            ClassName = "SunRaysEffect",
            Intensity = 0.1,
            Spread = 0.6,
            Enabled = true
        },
        {
            Name = "Atmosphere",
            ClassName = "Atmosphere",
            Density = 0.25,
            Offset = 0.25,
            Glare = 1,
            Haze = 0,
            Color = Color3.fromRGB(247, 249, 255),
            Decay = Color3.fromRGB(151, 159, 177)
        },
        {
            Name = "Blur",
            ClassName = "BlurEffect",
            Size = 0,
            Enabled = false
        },
        {
            Name = "DepthOfField",
            ClassName = "DepthOfFieldEffect",
            FarIntensity = 0.75,
            FocusDistance = 0.05,
            InFocusRadius = 10,
            NearIntensity = 0.75,
            Enabled = false
        }
    }
};